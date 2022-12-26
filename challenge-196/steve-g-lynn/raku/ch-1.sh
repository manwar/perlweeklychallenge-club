#!/bin/sh

raku -e 'my @list=@*ARGS; (0 .. @list-1).combinations(3).map({@list[$_]}).grep({ @_[2] > @_[0] }).grep({ @_[1] > @_[2] }).head(1).flat.say' $@

