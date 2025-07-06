---
title: "Dynamic GraphQL Schema Generation"
layout: post
date: 2023-08-01 10:00
tag: 
- graphql
- code-generation
- ndb
- node.js
- prisma

image: /assets/images/projects/ndb/banner.png
headerImage: true
projects: false 
hidden: false
description: "How we tackled evolving GraphQL schemas in the NDB project with a dynamic code generator."
category: blog
author: Fakhruddin Abdi
externalLink: false
---

In the **NDB project**, we faced a significant challenge early in development: uncertainty regarding the final GraphQL schema. Initial requirements and specifications were fluid, and it was clear that the schema would undergo constant changes as the project evolved.

After careful consideration and evaluation of the change costs and potential impacts, we identified that the GraphQL schema, along with its queries, mutations, and resolvers, would be the primary components affected by these continuous modifications. Manually updating the entire cycle from schema definition to resolvers for every change would consume a significant amount of time and effort, leading to development bottlenecks and potential errors.

To address this, I decided to build a dynamic system that could convert a static, hard-coded, and unmanageable GraphQL schema into a JavaScript object. This approach allowed for easy updates and management of the schema definitions through scripts.

I developed a generator that consumes this JavaScript object as input and automatically generates the GraphQL schema and resolvers. This automated process drastically reduced the time and complexity associated with schema evolution, allowing us to adapt quickly to changing requirements without extensive manual refactoring.

Here are some examples of the code used in the generator:

### Model Fields Generation

This utility function generates standard GraphQL fields for a given model, including `id`, a single `model` instance, and a list of `models`.

```javascript
export const generateModelFields = (modelName: string) => {
  const _modelName = toLowercaseUnderscore(modelName)
  const modelId = {
    name: `${_modelName}_id`,
    type: 'ID',
    isRequired: true,
    // ... other properties ...
  };

  const model = {
    name: modelName,
    type: modelName,
    // ... other properties ...
  };

  const models = {
    name: `${_modelName}s`,
    type: modelName,
    isRequired: true,
    isList: true,
    // ... other properties ...
  };

  return { modelId, model, models };
}
```

### Middleware for Resolvers

These middleware functions provide common functionalities like logging, user creation, and payment processing, which can be easily plugged into resolvers.

```javascript
const createMiddleware = (
  func: (args: Args, context: Context) => Promise<any>,
) => {
  return async ({ parent, args, context, info, params }: ResolverFuncArgs) => {
    const newArgs = await func(args, context);
    return { parent, args: newArgs, context, info, params };
  };
};

const _logData = (args: Args, context: Context): Promise<Args> => {
  return Promise.resolve(args);
};

export {
  createCognitoUser, createPayment, deleteCognitoUser, findUser, logData
};
```

### Type Generation Utilities

These functions are crucial for programmatically constructing GraphQL types and queries from the JavaScript object representation.

```javascript
export const combineTypeAndAttributes = (list: any, name: string) =>
  `type ${name} {\n${list.join('\n')}\n}`;

export const addIfRequired = when<Field, Field>(isRequired, addRequired);
export const addIfList = when<Field, Field>(isList, addList);

export const makeType = compose<Field[][], any, any, any, any>(
  fromPairs,
  map(mapFieldToTuple),
  map(addIfRequired),
  map(addIfList),
);

export const generateSchemaType = (fields: Field[], name: string) =>
  compose<any[], any, any, any, string>(
    (list: [string]) => combineTypeAndAttributes(list, name),
    values,
    mapObjIndexed(mapObjToString),
    makeType,
  )(fields);

export const generateSchemaQueries = compose(
  join('\n'),
  map(compose(genQuery, addReturn, addArgs)),
);
```

### Payment Type Definition

For example, for the `Payment` type, we define its fields as a JavaScript object. This allows for a clear and programmatic way to manage the schema's structure.

```javascript
import { basicFields, providerPayment, user, userId } from '../sharedFields.js';
import { Field } from '../../__types__/models.js';

const amount = {
  name: 'amount',
  type: 'Int',
  isRequired: true,
  // ... other properties ...
};

export const fields: Field[] = [
  ...basicFields,
  // ... other fields ...
];
```

### Payment Queries and Mutations

Building upon the field definitions, we then define the GraphQL queries and mutations for the `Payment` type. Each query and mutation is also represented as a JavaScript object, specifying its name, associated model, type (query/mutation), API function, data source, input arguments, expected output, and any middleware to be applied.

```javascript
import { logData } from '../generators/middleWares.js';
import { id, listMetadata, payment, payments } from '../sharedFields.js';
import { amount, filter } from './paymentFields.js';

const allPayments = {
  name: 'allPayments',
  model: 'Payment',
  type: 'query',
  apiFunc: 'getRecords',
  dataSource: 'ndbApi',
  input: [/* ... input fields ... */],
  output: payments,
  middlewares: [],
};

const createPayment = {
  name: 'createPayment',
  model: 'Payment',
  type: 'mutation',
  apiFunc: 'createRecord',
  dataSource: 'ndbApi',
  input: [amount, model_id('user')],
  output: payment,
  middlewares: [logData],
};

export const queries = [
  allPayments,
  // ... other queries and mutations ...
];
```

### Schema Integration

These dynamically generated types, queries, and mutations are then imported and composed into the main GraphQL schema definition using template literals, providing a flexible and maintainable structure.

```javascript
import { gql } from 'apollo-server';
import { userQuery, userMutation, userType } from '../models/user/index.js';
import { paymentQuery, paymentMutation, paymentType } from '../models/payment/index.js';
// ... other imports ...

const typeDefs = gql`
  type Query {
    ${userQuery}
    ${paymentQuery}
    // ... other queries ...
  }

  type Mutation {
    ${paymentMutation}
    // ... other mutations ...
  }
  
  ${paymentType}
  ${userType}
  // ... other types ...

  ${inputs.map((input) => `${input} \n`)}
`;

export { typeDefs };
```

### Resolvers Integration

Similarly, the resolvers for each model (queries, mutations, and relation resolvers) are imported and combined into a single `resolvers` object. This modular approach ensures that each part of the schema can be developed and managed independently while seamlessly integrating into the overall GraphQL API.

```javascript
import {
  paymentQueryResolvers,
  paymentMutationesolvers,
  paymentRelationResolvers as Payment,
} from '../models/payment/index.js';
import {
  userQueryResolvers,
  userMutationResolvers,
  userRelationResolvers as User,
} from '../models/user/index.js';
// ... other imports ...

const resolvers: any = {
  Query: {
    ...paymentQueryResolvers,
    ...userQueryResolvers,
    // ... other query resolvers ...
  },
  Mutation: {
    ...paymentMutationesolvers,
    // ... other mutation resolvers ...
  },
  Payment,
  User,
  // ... other relation resolvers ...
};

export { resolvers };
```

### Conclusion

This dynamic schema generation approach has been instrumental in managing the evolving requirements of the NDB project. It has allowed us to maintain a flexible and maintainable GraphQL schema, while also reducing the time and effort required to update the schema as the project evolves.



