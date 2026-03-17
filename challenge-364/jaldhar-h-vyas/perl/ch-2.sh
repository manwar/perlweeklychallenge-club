#!/bin/sh

perl -E 'say shift=~s/\(\)/o/gr=~s/\(al\)/al/gr' "$@"


