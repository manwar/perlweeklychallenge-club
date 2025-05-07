#!/bin/sh

perl -E 'say 0+grep{/^[aeiou]|[aeiou]$/}@ARGV' "$@"
