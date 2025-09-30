#!/bin/sh

raku -e 'my @n=@*ARGS[0].match(/(\d+)/,:g)».Int;(@n ~~ @n.sort({$^a <=> $^b})).say' "$@"