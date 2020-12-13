use strict;
use warnings;
use feature 'say';

my $input = shift // 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

say "Input         : $input";
say 'Length        : ' . $input =~ tr/TAGC/ATCG/;
say "Complementary : $input";
