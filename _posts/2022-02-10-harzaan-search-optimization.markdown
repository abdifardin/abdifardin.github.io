---
title: "Optimizing Kurdish Search for Classified Ads"
layout: post
date: 2022-02-10 12:00
tag: 
- search-optimization
- localization
- natural-language-processing
- kurdish

image: /assets/images/blogs/search-optimization/search-image.png
headerImage: true
projects: false
hidden: false
description: "How Harzaan tackled the complexities of Kurdish language variations to build a smart search system that accurately finds classified ads."
category: blog
author: Fakhruddin Abdi
externalLink: false
---

<img style="width: 100%" src="/assets/images/blogs/search-optimization/search.png" />

We at Harzaan always seek to localize our features and support native languages as much as possible.

One of the challenges we had is the different types of writing for a single product in the Kurdish language.

We have worked hard to make it possible, and our smart search system can guess very closely what you are looking for.

For example, in Kurdish for Toyota Land Cruiser, we have different writings, like the main writing, or تۆیۆتا لاندکروزر or وەنەوشە, and these writings are often misspelled. So we tried to collect all different forms of the words and configure the search as family words.

But it didn't quite fix the problem because we may have some other writing for it, and they will be totally hidden from search in this case.

Here im gonna explain how we solved this problem and how we built a smart search system that can handle this.



## The Challenge: Linguistic Variation in Kurdish Search

Kurdish, like many other languages, presents unique challenges for search engines due to its diverse dialects and informal writing styles. A single product or brand can be written in multiple ways, often leading to search queries that don't directly match the indexed content.

Initially, we attempted to solve this by defining "family groups" of words. This involved manually mapping different spellings or colloquial terms to a single, canonical form, and then configuring our search engine to recognize these variations as the same word.

## First Approach: Family Word Grouping

Our initial strategy focused on creating comprehensive lists of word variations for common terms and product names. For instance, for "Toyota Land Cruiser," we identified numerous ways it could be written by users:

*   Original/Formal: Toyota Land Cruiser
*   Kurdish (Sorani Script): تۆیۆتا لاندکروزر
*   Colloquial/Common Misspellings: وەنەوشە (Wanawsha - a common nickname)

We then grouped these variations, aiming to ensure that a search for any of these terms would yield results for "Toyota Land Cruiser."

### Limitations of Family Word Grouping

While this approach improved search accuracy for known variations, it had significant limitations:

*   **Incomplete Coverage**: It was impossible to account for every possible misspelling or informal writing style. New or unforeseen variations would still result in hidden posts.
*   **Manual Effort**: Maintaining and updating these family word lists was a time-consuming manual process.
*   **Lack of Adaptability**: The system couldn't dynamically learn new variations from user behavior.

This led to a scenario where, despite our efforts, many legitimate posts could still be missed by users employing unconventional spellings.

## Second Approach: Smart System - Mapping Search Input to Actual Brands/Models

Recognizing the inherent limitations of a static, keyword-matching approach, we pivoted our strategy. Instead of relying solely on matching keywords in titles and descriptions, we shifted to a more intelligent system that focuses on mapping the user's search input directly to actual, verified brand and model names within our database.

This new, smart system leverages a combination of techniques:

1.  **User Input Analysis**: When a user types a search query, our system first analyzes the input.
2.  **Family Word Integration (as a preliminary step)**: We still utilize the concept of family words, but now as a preliminary step to initially map the user's potentially varied input to existing brands and models. This acts as a powerful disambiguation layer.
3.  **Intelligent Suggestions**: Based on the preliminary mapping, the system provides intelligent suggestions to the user. These suggestions are actual, validated brands and models from our catalog.
4.  **User Confirmation**: If the user selects one of the suggested, correct brands or models, their selection is accepted.
5.  **Direct Post Retrieval**: Instead of performing a keyword-based search on titles and descriptions, we now directly fetch all posts associated with the *selected brand or model*. This ensures that no relevant post is missed, regardless of how the user initially phrased their search query.

### How it Works in Practice

Consider the "Toyota Land Cruiser" example again. A user might type "وەنەوشە" (Wanawsha). Our system would:

1.  Receive "وەنەوشە" as input.
2.  Recognize "وەنەوشە" as a family word for "Toyota Land Cruiser" through its learned patterns.
3.  Suggest "Toyota Land Cruiser" (and potentially other related models if applicable) to the user.
4.  Upon the user confirming "Toyota Land Cruiser," the system retrieves all posts classified under the "Toyota Land Cruiser" model, ensuring comprehensive and accurate results.

This fundamental shift means we are no longer trying to guess every possible keyword variation. Instead, we guide the user to the correct, standardized product identifier and then retrieve all associated listings, eliminating the problem of hidden posts due to linguistic nuances.

## The Results

This new search system has significantly improved the user experience and the visibility of listings on Harzaan:

*   **Increased Search Accuracy**: Users can find what they're looking for much more easily, even with unconventional spellings.
*   **Enhanced Post Visibility**: Product owners can be confident that their listings will appear in relevant searches, regardless of minor variations in user input.
*   **Improved User Satisfaction**: The smart suggestions and accurate results lead to a more intuitive and satisfying search experience.
*   **Scalability**: The system's learning capability allows it to adapt to new linguistic patterns without constant manual updates.

This powerful combination of linguistic understanding and data-driven mapping has revolutionized how users interact with search on Harzaan, connecting buyers and sellers more efficiently than ever before. 

---

*Harzaan is Iraq's leading classified ads platform, connecting millions of users with local deals and opportunities. Learn more about our technical journey at [Harzaan project](/harzaan).* 