#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge
#               https://www.perlweeklychallenge.org
#               Task 1 - Unique Subsequence
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/13/2021 12:22:27 PM
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

#FIXME: This does not work

sub unique_subsequences {
    my $what = shift;

    # let's change the pattern a bit
    my $mod_pattern = $what->{t};
    $mod_pattern =~ s/(.)/$1\(\?=.*/g;
    $mod_pattern .= ')' x length($what->{t});
    say $mod_pattern;

    my @matches = ($what->{s} =~ m/($mod_pattern)/g);
    say for @matches;
    say scalar @matches;
    return 1;
}

use Test::More;
is(unique_subsequences({'s' => 'littleit', 't' => 'lit'}), 1);

done_testing;
