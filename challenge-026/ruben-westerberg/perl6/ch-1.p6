#!/usr/bin/env perl6

my ($stones,$jewels)=@*ARGS??@*ARGS!! <chancellor chocolate>;
print "Alphabet (stone) word: $stones\nTest (jewel) word: $jewels\n";
my @stones= $stones.comb.unique;
put "Number of letters of Alphabet found in Test: ", $jewels.chars-(S:g/[@stones]// given $jewels).chars;
