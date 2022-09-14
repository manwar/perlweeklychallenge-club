#!/bin/sh

raku -e 'say (0 .. @*ARGS.elems-1).grep({@*ARGS[$_] == @*ARGS.max})' 5 2 9 1 7 6
#(2)

#raku -e 'say (0 .. @*ARGS.elems-1).grep({@*ARGS[$_] == @*ARGS.max})' 4 2 3 1 5 0
#(4)
