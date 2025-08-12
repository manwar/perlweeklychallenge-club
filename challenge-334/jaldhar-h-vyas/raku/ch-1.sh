#!/bin/sh

raku -e 'my@a=@*ARGS».Int;(@a[@a[*-2]..@a[*-1]]).sum.say' "$@"
