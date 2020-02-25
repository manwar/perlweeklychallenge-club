#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-041/
#
#  Write a script to display attractive number between 1 and 50.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 01/02/2020 02:23:28 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Math::Factor::XS qw/count_prime_factors/;
use Math::Prime::XS qw/is_prime/;

sub is_attractive {
    my $what = shift;

    return is_prime(count_prime_factors($what));
}

# TESTS

use Test::More;

is(is_attractive(20),1);
is(is_attractive(23),'');
is(is_attractive(28),1);
is(is_attractive(256),'');

done_testing;


