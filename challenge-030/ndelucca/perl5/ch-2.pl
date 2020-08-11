#!/usr/bin/perl

use strict;
use warnings;

# I'll assume 0 is considered unsigned in this case, so it doesn't enter the "positive" category
# Could've used only 1 "random" array, but it is more clear using two
my $filter = 12;
my @random1 = (1..$filter);
my @random2 = (1..$filter);

my @evens = grep { $_ % 2 == 0 } (1..$filter);

my @compliant = ();

for my $even (@evens){

    for my $rand1 (@random1){

        for my $rand2 (@random2){

            my $sum = $even + $rand1 + $rand2;

            if ($sum == $filter){

                my $combination = join ", ", sort ($even,$rand1,$rand2);
                push @compliant, $combination unless ( grep { $_ eq $combination } @compliant );

            }
        }
    }
}

printf "(%s)\n", $_  for @compliant;
