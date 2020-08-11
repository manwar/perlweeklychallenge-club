#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-051/         #
#                                                                         #
# Colourful Number                                                        #
# Write a script to display all Colorful Number with 3 digits.            #
#                                                                         #
#   A number can be declare Colorful Number where all the products of     #
#   consecutive subsets of digit are different.                           #
#                                                                         #
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3    #
# are unique.                                                             #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;

# The range to search can be narrowed.
# 3 digit numbers gives us a beginning range of 100 .. 999

# Q(first appearance) == Q(second appearance)
# Numbers with repetitions are not colourful numbers.

# 0 == ( Q x 0 )
# Numbers with 0s are not colorful numbers.

# Q == ( Q x 1 )
# Numbers with 1s are not colorful numbers.

# 100 no, 200, 230, 231, 232, 233 ... 234 seems right.
# 999 no, 989, 988 ... 987 seems right.

my $MIN = 234;
my $MAX = 987;

LOOP:
for (my $i = $MIN; $i <= $MAX; ++$i) {
    my %seen = ();
    my @d = (split //, $i );

    foreach ( $d[0], $d[1], $d[2], $d[0]*$d[1], $d[1]*$d[2], $d[0]*$d[1]*$d[2]) {

        exists $seen{$_} ? next LOOP : $seen{$_}++ ;

    }
    print "$i\n";
}

__END__
Output is 328 lines / numbers.
output:

234
235
237
.
.
.
985
986
987
