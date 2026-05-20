#!/bin/env raku

unit sub MAIN(Str:D $str);

put $str.match(/((.)$0*)/, :g)».Int.max;
