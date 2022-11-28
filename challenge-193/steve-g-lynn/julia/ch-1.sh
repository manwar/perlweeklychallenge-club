#!/bin/sh

julia -e 'for i in (parse(Int64,"0b"*repeat("0",parse(Int64,ARGS[1]))):parse(Int64,"0b"*repeat("1",parse(Int64,ARGS[1])))); println(SubString(bitstring(i),65-parse(Int64,ARGS[1]))); end;' $@

