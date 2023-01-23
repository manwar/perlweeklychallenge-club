#!/bin/sh

raku -e '(0 .. @*ARGS-1).combinations(2).grep({@_[1]-@_[0]>1}).map({@*ARGS[@_[0]..@_[1]]}).grep( {my @n=@_; (0 .. @n-3).map( {(@n[$_+1]-@n[$_]) == (@n[$_+2]-@n[$_+1])} ).sum==(@n.elems-2) } ).say' $@


