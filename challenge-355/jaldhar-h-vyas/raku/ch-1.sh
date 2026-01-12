#!/bin/sh

raku -e '$_=@*ARGS[0];.subst(/^/,(0 x 3-.chars % 3)).comb(3).join(q{,}).subst(/^0+\,*/,"").say' "$@"
