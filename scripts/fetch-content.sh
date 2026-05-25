#!/usr/bin/env sh
# Fetch site content from the content repo into ./content (Pattern B: the
# whole content repo *is* this site's content). Runs before `astro build`.
#
# Produces:
#   content/posts/   -> blog posts        (src/pages/posts/...)
#   content/pages/   -> standalone pages   (src/pages/[...slug].astro)
#
# Environment:
#   CONTENT_REPO_TOKEN  Fine-grained, read-only GitHub PAT. Required for a
#                       private content repo. On Cloudflare Pages set it as a
#                       Secret env var; locally export it (this repo uses
#                       direnv, so .envrc / .env works) or rely on your own
#                       git credentials for an anonymous/SSH clone.
#   CONTENT_REPO_URL    Override the clone URL entirely (handy for local
#                       testing against a checkout, e.g. a sibling directory).
#   FORCE_FETCH         Set to re-clone even when content/ already exists.
set -e

CONTENT_DIR="content"
DEFAULT_REPO_HOST="github.com/simensen/beausimensen-com-content.git"

# Fast path for local iteration: keep the existing checkout unless forced.
# CI builds run from a clean tree, so content/ is absent and this clones.
if [ -d "$CONTENT_DIR/posts" ] && [ -z "$FORCE_FETCH" ]; then
  echo "fetch-content: $CONTENT_DIR/ already present; skipping (set FORCE_FETCH=1 to refresh)."
  exit 0
fi

rm -rf "$CONTENT_DIR"

if [ -n "$CONTENT_REPO_URL" ]; then
  REPO_URL="$CONTENT_REPO_URL"
elif [ -n "$CONTENT_REPO_TOKEN" ]; then
  REPO_URL="https://${CONTENT_REPO_TOKEN}@${DEFAULT_REPO_HOST}"
else
  REPO_URL="https://${DEFAULT_REPO_HOST}"
fi

echo "fetch-content: cloning content into $CONTENT_DIR/ ..."
git clone --depth 1 "$REPO_URL" "$CONTENT_DIR"

# Ensure the collection base dirs exist even if the content repo ships one
# of them empty (the glob loaders then just resolve to zero entries).
mkdir -p "$CONTENT_DIR/posts" "$CONTENT_DIR/pages"

echo "fetch-content: done."
