#!/bin/sh

julia -e 'for i in 1:length(ARGS); if parse(Float64,ARGS[i])==maximum(parse.(Float64,ARGS)); println(i-1); end; end;' 5 2 9 1 7 6

#2

#julia -e 'for i in 1:length(ARGS); if parse(Float64,ARGS[i])==maximum(parse.(Float64,ARGS)); println(i-1); end; end;' 4 2 3 1 5 0

#4

