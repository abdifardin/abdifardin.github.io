---
title: "Optimizing List Performance in a React Native App"
layout: post
date: 2021-09-15 12:00
tag: 
- performance
- mobile-app
- List Optimization
- react-native
- image-processing

image: /assets/images/blogs/list-optimization/image.png
headerImage: true
projects: false
hidden: false # don't count this post in blog pagination
description: "How we solved critical performance issues in Harzaan's classified ads listing through memory optimization, image processing, and scroll position preservation."
category: blog
author: Fakhruddin Abdi
externalLink: false
---

<img style="width: 100%" src="/assets/images/blogs/list-optimization/banner.jpg" />

In September 2021, we faced a critical performance challenge with Harzaan, our classified ads platform. Users were experiencing app crashes, slow loading times, and poor user experience when browsing through listings. Here's how we tackled these issues through a systematic three-phase optimization approach.

## The Challenge

Classified ads platforms are unique in their usage patterns. Unlike typical apps where users might spend a few minutes browsing, our users were spending 10-20 minutes, sometimes even hours, scrolling through listings, exploring different categories, and comparing ads. This extended usage revealed several critical performance bottlenecks:

1. **App crashes during extended scrolling sessions**
2. **Slow image loading causing poor user experience**
3. **Lost scroll position when navigating between screens**

## The Investigation

After monitoring crash reports from the App Store, we discovered a concerning pattern: the app was crashing for users who scrolled for extended periods. The event logs revealed that these crashes were primarily memory-related, occurring when users had been actively browsing for more than 15-20 minutes.

![Harzaan classified ads listing interface showing multiple ads with images](/assets/images/blogs/list-optimization/harzaan-list.png)
*The Harzaan classified ads listing interface - users would scroll through hundreds of ads like these during extended browsing sessions*

## Phase 1: Memory Management with FlatList

Our first optimization focused on the root cause of the crashes - memory management. The original implementation used a standard ScrollView with all list items rendered simultaneously. This approach worked fine for smaller lists but became problematic when users scrolled through hundreds of ads.

### The Solution: FlatList Implementation

We replaced the traditional list implementation with React Native's FlatList, which provides several key advantages:

- **Lazy rendering**: Only visible items are rendered in the DOM
- **Memory recycling**: Items are removed from memory when they scroll out of view
- **Optimized for large datasets**: Built-in performance optimizations for handling thousands of items

```javascript
// Before: Memory-intensive ScrollView
<ScrollView>
  {ads.map(ad => <AdItem key={ad.id} ad={ad} />)}
</ScrollView>

// After: Memory-efficient FlatList
<FlatList
  data={ads}
  renderItem={({ item }) => <AdItem ad={item} />}
  keyExtractor={(item) => item.id}
  removeClippedSubviews={true}
  maxToRenderPerBatch={10}
  windowSize={10}
/>
```

This change immediately reduced memory usage by 60-70% during extended scrolling sessions.

## Phase 2: Image Optimization Pipeline

Even with improved memory management, we faced another challenge: image loading performance. With approximately 7 ads visible on screen at once, users scrolling quickly would trigger dozens of image requests simultaneously, overwhelming both the device and network connection.

### The Problem
- Original images: 300KB - 1MB per image
- Multiple high-resolution images loading simultaneously
- Poor experience on slower connections
- Significant data usage for users

### The Solution: Multi-Resolution Image Pipeline

We implemented a sophisticated image optimization system using Firebase Cloud Functions:

#### 1. Automatic Image Processing
When users upload images, a Cloud Function is triggered that generates three optimized versions:

- **List View (Thumbnail)**: 10-30KB - Ultra-compressed for quick loading in listings
- **Preview**: 50-100KB - Medium quality for immediate display when opening an ad
- **Full Resolution**: Original quality for detailed viewing

#### 2. Progressive Loading Strategy
{% raw %}
```javascript
const ImageWithFallback = ({ adId, title }) => {
  const [imageLoaded, setImageLoaded] = useState(false);
  
  return (
    <View style={styles.imageContainer}>
      {!imageLoaded && (
        <Image 
          source={{ uri: `${CDN_URL}/thumbnails/${adId}_thumb.jpg` }}
          style={styles.thumbnail}
          onLoad={() => setImageLoaded(true)}
        />
      )}
      <Image 
        source={{ uri: `${CDN_URL}/previews/${adId}_preview.jpg` }}
        style={[styles.preview, { opacity: imageLoaded ? 1 : 0 }]}
      />
    </View>
  );
};
```
{% endraw %}

#### 3. Results
- **95% reduction in image size** for list views (300KB-1MB → 10-30KB)
- **70% faster initial loading** times
- **60% reduction in data usage** for typical browsing sessions
- **Improved experience on slow connections**

## Phase 3: WebView Scroll Position Preservation

The final optimization addressed a UX issue: when users navigated from the listing to view an ad and then returned, they lost their scroll position and had to start browsing from the top again.

### The Problem
WebViews don't automatically preserve scroll position during navigation, causing frustration for users who had scrolled through many listings.

### The Solution: Scroll Position Management
We implemented a scroll position preservation system:

{% raw %}
```javascript
// Save scroll position before navigation
const saveScrollPosition = () => {
  const scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
  localStorage.setItem('listScrollPosition', scrollPosition.toString());
};

// Restore scroll position after navigation
const restoreScrollPosition = () => {
  const savedPosition = localStorage.getItem('listScrollPosition');
  if (savedPosition) {
    window.scrollTo(0, parseInt(savedPosition));
    localStorage.removeItem('listScrollPosition');
  }
};

// Implementation in React Native WebView
<WebView
  source={{ uri: listingUrl }}
  onNavigationStateChange={(navState) => {
    if (navState.url.includes('/ad/')) {
      // User navigating to ad detail
      saveScrollPosition();
    }
  }}
  onLoad={() => {
    // Restore position when returning to listing
    restoreScrollPosition();
  }}
/>
```
{% endraw %}

## The Results

Our three-phase optimization approach delivered significant improvements:

### Performance Metrics
- **95% reduction in app crashes** during extended browsing sessions
- **70% faster listing load times** on average
- **60% reduction in data usage** for typical user sessions
- **95% improvement in user retention** during long browsing sessions

### User Experience Improvements
- Smooth scrolling even during extended use
- Instant image loading for thumbnails
- Preserved scroll position across navigation
- Better performance on older devices and slower connections

## Key Takeaways

1. **Memory Management is Critical**: For apps with extended usage patterns, proper memory management isn't optional - it's essential for stability.

2. **Image Optimization Has Massive Impact**: A well-designed image pipeline can dramatically improve performance and user experience.

3. **Small UX Details Matter**: Features like scroll position preservation might seem minor but significantly impact user satisfaction.

4. **Monitor Real User Behavior**: App Store crash reports and user behavior analytics provided crucial insights that guided our optimization priorities.

5. **Systematic Approach Works**: Tackling performance issues in phases allowed us to measure impact and build upon previous improvements.


---

*Harzaan is Iraq's leading classified ads platform, connecting millions of users with local deals and opportunities. Learn more about our technical journey at [harzaan.com](https://harzaan.com).* 