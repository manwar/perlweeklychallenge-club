#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 001
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-001/
#               Task 1 - replace characters
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/23/2021 03:36:54 PM
#===============================================================================

use strict;
use warnings;

sub replace_e {
    my $what = shift;

    my $count = () = $what =~ /e/g;

    $what =~ s/e/E/g;

    return [$count, $what];
}

use Test::More;

is_deeply(replace_e('Perl Weekly Challenge'), [5, 'PErl WEEkly ChallEngE']);
done_testing;

