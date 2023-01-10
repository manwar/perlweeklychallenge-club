#!/bin/env raku

unit sub MAIN(UInt:D \m);

put (^m).grep(*.is-prime).elems;
