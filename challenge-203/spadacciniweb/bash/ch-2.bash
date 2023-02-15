#!/bin/bash

echo -n "path source: "
read SOURCE

[ -d "$SOURCE" ] || { echo "$SOURCE directory does not exist."; exit 1; }

echo -n "path target: "
read TARGET
[ -d "$TARGET" ] || { echo "$TARGET directory does not exist."; exit 1; }

rsync -av -f"+ */" -f"- *" $SOURCE/ $TARGET
