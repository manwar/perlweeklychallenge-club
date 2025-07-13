#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[ a..z 0 .. 9 ]>+$/,
               :v(:$verbose));

my @ints = $str.split(/<[a..z]>+/).grep: * ~~ /\d+/;

say ": Integers: { @ints.join(", ") }" if $verbose;

say @ints.unique.join(", ");
