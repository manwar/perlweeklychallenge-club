#!/bin/sh

raku -e 'my @a=@*ARGS.words.pairup;(@a.map({$_.value})∖@a.map({$_.key})).keys.join.say' "$@"