#!/bin/sh

# "prime_count" has inclusive ranges, so we need to adjust the limit.
# This neat subtlety was carefully avoided in the examples.
perl -MMath::Prime::Util=:all -E "say prime_count $1 - 1"
