#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

# task 1

my $adn = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";
my $cpl = "CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC";
my $len = length($adn);

is `gforth forth/ch-1.fs $adn`, "$len \n$cpl\n";
is `gforth forth/ch-1.fs $cpl`, "$len \n$adn\n";

is `perl perl/ch-1.pl $adn`, "$len\n$cpl\n";
is `perl perl/ch-1.pl $cpl`, "$len\n$adn\n";


# task 2

for my $a (0,1,2,3,4,5,14) {
    for my $b (0,1,2,3,4,5,12) {
        my $r = $a*$b;
        is `gforth -e ' $a $b' forth/ch-2.fs`, "$r \n";

        is `perl perl/ch-2.pl $a $b`, "$r\n";
    }
}

done_testing;
