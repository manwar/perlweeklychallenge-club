#!/bin/env raku

unit sub MAIN(UInt:D $int);

my token Seq { (<[0..9]>) $0 $0+ }
put $int.match(/<Seq>/, :g).grep(*.chars == 3).first // -1;
