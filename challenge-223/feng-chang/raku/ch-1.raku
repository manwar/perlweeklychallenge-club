#!/bin/env raku

unit sub MAIN(UInt:D $n);

put (2..$n).grep(*.is-prime).elems;
