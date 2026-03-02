#! /usr/bin/env raku

unit sub MAIN ($string where $string ~~ /^<[a..z]>+$/);

(^$string.chars).map({ $string.substr($_, 1) x ($_ + 1) }).join.say;
