#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 082
#               http://www.perlweeklychallenge.org
#               Task 1 - Common Factors
#               
#       AUTHOR: Lubos Kolouch 
#      CREATED: 10/14/2020 07:25:23 PM
#===============================================================================

use strict;
use warnings;

sub get_common_factors {
    my $numbers = shift;

    # 1 is always factor
    my @common_factors = (1);

    # it's enough to to go sqrt of one of the numbers
    for (2..int(sqrt($numbers->{'first'}))) {
        next unless $numbers->{'first'} % $_ == 0;

        # add to solution if it is factor of the second number
        push @common_factors, $_ if $numbers->{'second'} % $_ == 0;

        # the same for the "other factor"
        my $other_factor =  $numbers->{'first'} / $_;
        push @common_factors, $other_factor if $numbers->{'second'} % $other_factor == 0;
    }

    # return them in the right order
    @common_factors = sort {$a <=> $b} @common_factors;
    return \@common_factors;
}

use Test::More;

is_deeply(get_common_factors( { first => 12, second => 18 } ), [1,2,3,6]);
is_deeply(get_common_factors( { first => 18, second => 23 } ), [1]);
is_deeply(get_common_factors( { first => 1, second => 1 } ), [1]);

done_testing;
