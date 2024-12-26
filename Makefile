# Variables
JEKYLL = bundle exec jekyll
SERVE_OPTS = --drafts --livereload
BUILD_DIR = _site

# Default target
all: build

# Build the site
build:
	$(JEKYLL) build

# Serve the site locally
serve:
	$(JEKYLL) serve $(SERVE_OPTS)

# Clean the site
clean:
	$(JEKYLL) clean

# Deploy the site (example, customize as needed)
deploy: build
	rsync -avz --delete $(BUILD_DIR)/ user@server:/path/to/deploy

# Phony targets
.PHONY: all build serve clean deploy
