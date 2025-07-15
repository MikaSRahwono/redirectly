#!/bin/bash
set -e

rm -rf dist
mkdir dist

echo "Compiling Go Lambda functions..."

for fn in create redirect stats
do
  GOOS=linux GOARCH=amd64 go build -o dist/${fn} ${fn}.go
  zip -j dist/${fn}.zip dist/${fn}
done

echo "Build complete. Files are in dist/"
