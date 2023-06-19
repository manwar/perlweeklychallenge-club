use strict;
use warnings;

use lib './lib';
use Good::Strings;

my $gs = Good::Strings->new;

use Data::Dumper;

my $chars = shift @ARGV;

my $sum = $gs->sum_lengths(
    \@ARGV,
    $chars,
);


print "\nCharacters: $chars";
print "\nWords: ";
print join ', ', @ARGV;
print "\nSum: $sum.\n\n"

