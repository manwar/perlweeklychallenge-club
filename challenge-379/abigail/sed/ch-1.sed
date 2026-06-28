#!/opt/homebrew/bin/gsed

s/$/\n/;:x s/(.)(\n.*)/\2\1/;tx;s/\n//
