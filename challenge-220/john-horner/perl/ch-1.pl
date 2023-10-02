use strict;
use warnings;
use v5.10;
my @ints = ( 1, 1, 4, 2, 1, 3 );

my @sortedints = sort(@ints);

my $matches = 0;

for ( my $i = 0 ; $i < @ints ; $i++ ) {
    $matches++ if $ints[$i] == $sortedints[$i];
}
say $matches;
