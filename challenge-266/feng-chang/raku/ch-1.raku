#!/bin/env raku

unit sub MAIN(Str:D $sent1, Str:D $sent2);

put ($sent1, $sent2)».words.Slip.Bag.grep(*.value == 1)».key.sort;
