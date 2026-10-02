#!/usr/bin/env bash
set -euo pipefail

REPO="ocodo/ocodo-mono-dotzero"

rm -rf package
mkdir -p package/fonts

echo "Downloading latest GitHub release..."
gh release download \
  --repo "$REPO" \
  --pattern 'OcodoMonoDotZero-NerdFont.zip' \
  --dir /tmp

echo "Extracting fonts..."
unzip -j \
  /tmp/OcodoMonoDotZero-NerdFont.zip \
  'OcodoMonoDotZeroNerdFont-*.ttf' \
  'OcodoMonoDotZeroNerdFont-*.woff2' \
  -d package/fonts

echo "Preparing package..."
cp package.json package/package.json
cp font.css package/font.css

echo "Node: $(node --version)"
echo "npm:  $(npm --version)"

echo "Publishing..."
(
  cd package
  npm publish --access public
)
