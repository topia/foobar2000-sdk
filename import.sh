#!/bin/sh

set -ex

archive="$1"
shift
name="$(basename "$archive")"
name="${name%.*}"

echo importing $name

rm -rf temp
mkdir temp
7z x "$archive" -otemp
mv SDK SDK.old || :
mv temp SDK
rm -rf SDK.old

git add -A
git commit -m "import $name"
git tag -f "$name"

if [ $# -gt 0 ]; then
  exec "$0" "$@"
fi
