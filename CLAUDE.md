# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal portfolio website for Fakhruddin Abdi, built using Jekyll and hosted on GitHub Pages. The site showcases projects, blog posts, and professional information. It uses a custom Jekyll theme with responsive design and includes features like Google Analytics, Disqus comments, and social media integration.

## Development Commands

### Local Development
```bash
# Install dependencies
bundle install

# Serve locally with live reload and drafts
bundle exec jekyll serve --drafts --livereload

# Alternative using Makefile
make serve

# Serve with development config (localhost URLs)
bundle exec jekyll serve --config _config.yml,_config-dev.yml
```

### Building and Testing
```bash
# Build the site
bundle exec jekyll build
make build

# Clean build artifacts
bundle exec jekyll clean
make clean

# Run tests with HTML validation
bundle exec rake test

# Run HTML proofer manually
bundle exec htmlproofer ./_site --only-4xx
```

## Site Architecture

### Core Structure
- **_config.yml**: Main Jekyll configuration with site metadata, plugins, and feature flags
- **_config-dev.yml**: Development overrides for local testing
- **_layouts/**: HTML templates for different page types
  - `default.html`: Base layout with HTML structure
  - `post.html`: Blog post layout with metadata, tags, and navigation
  - `page.html`: Standard page layout
  - `compress.html`: HTML compression wrapper
- **_includes/**: Reusable components (header, footer, analytics, social links)
- **_sass/**: Modular SCSS organization
  - `base/`: Core styles, variables, and utilities
  - `components/`: UI component styles
  - `pages/`: Page-specific styles

### Content Organization
- **_posts/**: Blog posts in Markdown with YAML frontmatter
- **assets/images/**: Organized by content type (projects/, blogs/, about/)
- **projects.html**: Portfolio showcase page
- **about.md**: Professional background and experience
- **blog/**: Blog listing page

### Post Structure
Posts use YAML frontmatter with these key fields:
- `layout`: Usually "post" for blog entries
- `projects`: Set to `true` for project showcases
- `hidden`: Set to `true` to exclude from blog pagination
- `category`: Used for Disqus comments and post navigation
- `image` + `headerImage`: For featured images
- `tags`: For categorization and filtering

### Jekyll Features Enabled
- SEO optimization with jekyll-seo-tag
- Sitemap generation
- RSS feed
- Emoji support with jemoji
- Related posts
- Read time estimation
- Social media integration
- Google Analytics tracking
- Disqus comments for specified categories

## Image Optimization

The site uses JPG images for better performance and compatibility. When adding new images:
- Use JPG format for photographs and complex images
- Organize images in logical subdirectories under `/assets/images/`
- Update image paths in both content and any referenced includes

## Development Notes

- The site uses Bundle for dependency management
- HTML compression is enabled through the compress layout
- Local development uses port 4000 by default
- The site is optimized for GitHub Pages deployment
- All external links and social media profiles are configurable in _config.yml

## Common Issues and Solutions

### Architecture/Dependency Issues
If you encounter nokogiri architecture errors when running `bundle exec jekyll serve`, the jemoji plugin may be temporarily disabled in _config.yml. This is due to architecture compatibility issues between ARM64 and x86_64 versions of native gems.

**Current workaround**: The jemoji plugin is commented out in _config.yml:
```yaml
plugins:
  # - jemoji  # Temporarily disabled due to architecture issues
```

### Liquid Template Warnings
You may see warnings about invalid Liquid expressions in certain blog posts. These are typically in code examples and don't affect site functionality.