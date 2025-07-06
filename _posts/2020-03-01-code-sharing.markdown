---
title: "Code Sharing Across Platforms"
layout: post
date: 2020-03-01 12:00
tag: 
- state-management
- react
- react-native
- code-sharing
- harzaan

image: /assets/images/blogs/code-sharing/image.png
headerImage: true
projects: false
hidden: false
description: "How Harzaan leveraged JavaScript-based technologies and decoupled logic to share state management across web and mobile platforms, significantly improving development efficiency."
category: blog
author: Fakhruddin Abdi
externalLink: false
---
<img style="width: 100%" src="/assets/images/blogs/code-sharing/banner.png" />

We at Harzaan faced a common challenge for startups: building both web and mobile applications with a limited development team. We couldn't afford dedicated teams for each platform, so we opted for a JavaScript-based tech stack, choosing React for web and React Native for mobile.

However, even with a shared language, we initially ended up with different codebases for each platform. While the core logic for features like post listing, post viewing, and categories was nearly identical, especially between the web mobile view and the React Native app, we found ourselves wasting significant time syncing these logics. Maintaining two separate codebases for essentially the same functionality was inefficient.

Our solution was to completely extract the business logic and state management from the UI layers, making it truly platform-agnostic. This meant decoupling the code and keeping it in pure JavaScript, allowing us to ship and reuse it across both web and mobile platforms without modification.

To ensure seamless synchronization of changes between platforms, we utilized Git submodules. This approach allowed us to share the core logic repository across our web and mobile projects, ensuring that any updates to the shared logic were easily propagated.

By implementing this strategy, we significantly reduced development time and greatly improved our overall development process. This approach allowed our small team to maintain a consistent user experience across platforms while maximizing code reuse and minimizing redundant effort.

## Code Examples

### Shared Logic (JavaScript)

This module encapsulates the data fetching and state management, making it reusable across different platforms.

```javascript
// shared/store/itemsStore.js

import { useState, useEffect } from 'react';

const initialState = {
  items: [],
  loading: false,
  error: null,
};

export const useItemsStore = () => {
  const [state, setState] = useState(initialState);

  const fetchItems = async () => {
    setState((prevState) => ({ ...prevState, loading: true, error: null }));
    try {
      const response = await fetch('https://api.example.com/items');
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      setState((prevState) => ({ ...prevState, items: data, loading: false }));
    } catch (error) {
      setState((prevState) => ({ ...prevState, error: error.message, loading: false }));
    }
  };

  return { state, fetchItems };
};
```

### React Web Component

This component uses the `useItemsStore` hook to fetch and display data on the web.

```javascript
// web/components/ItemsList.js

import React, { useEffect } from 'react';
import { useItemsStore } from '../../shared/store/itemsStore';

const ItemsListWeb = () => {
  const { state, fetchItems } = useItemsStore();
  const { items, loading, error } = state;

  useEffect(() => {
    fetchItems();
  }, []);

  if (loading) {
    return <div>Loading items...</div>;
  }

  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <div>
      <h1>Items (Web)</h1>
      <ul>
        {items.map((item) => (
          <li key={item.id}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
};

export default ItemsListWeb;
```

### React Native Mobile Component

Similarly, this component uses the same `useItemsStore` hook for the mobile application.

```javascript
// mobile/components/ItemsList.js

import React, { useEffect } from 'react';
import { View, Text, FlatList, StyleSheet } from 'react-native';
import { useItemsStore } from '../../shared/store/itemsStore';

const ItemsListMobile = () => {
  const { state, fetchItems } = useItemsStore();
  const { items, loading, error } = state;

  useEffect(() => {
    fetchItems();
  }, []);

  if (loading) {
    return <Text style={styles.message}>Loading items...</Text>;
  }

  if (error) {
    return <Text style={styles.message}>Error: {error}</Text>;
  }

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Items (Mobile)</Text>
      <FlatList
        data={items}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => <Text style={styles.item}>{item.name}</Text>}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    marginTop: 50, // Adjust for status bar
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  message: {
    fontSize: 18,
    textAlign: 'center',
    marginTop: 50,
  },
  item: {
    fontSize: 16,
    paddingVertical: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
  },
});

export default ItemsListMobile;
```

These examples illustrate how the `useItemsStore` containing the core logic is imported and utilized in both React for web and React Native for mobile, demonstrating effective code sharing and separation of concerns.

---

*Harzaan is Iraq's leading classified ads platform, connecting millions of users with local deals and opportunities. Learn more about our technical journey at [Harzaan project](/harzaan).* 