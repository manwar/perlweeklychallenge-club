use v5.10;
use strict;
use warnings;
my $string = 'Perl Weekly Challenge';
my $occurrences = $string =~ tr/e/E/; # tr returns number of occurrences
say $string;
say $occurrences;
