#!/bin/sh

raku -e 'say q{(}, @*ARGS.map({ $_ * $_ }).sort.join(q{, }), q{)};' $@