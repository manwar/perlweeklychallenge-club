#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge
#               https://www.perlweeklychallenge.org
#               Task 1 - Pattern Match
#
#       AUTHOR: YOUR NAME (), 
#      CREATED: 02/13/2021 12:22:27 PM
#===============================================================================

use strict;
use warnings;

sub pattern_match {
    my $what = shift;

    # convert the pattern to regex
    $what->{p} =~ s/\?/./g;
    $what->{p} =~ s/\*/.*/g;
    $what->{p} = '^'.$what->{p}.'$';

    my $match = $what->{s} =~ /$what->{p}/;
    return 0 unless $match;
    return 1;
}

use Test::More;

is(pattern_match({'s' => 'abcde', 'p' => 'a*e'}), 1);
is(pattern_match({'s' => 'abcde', 'p' => 'a*d'}), 0);
is(pattern_match({'s' => 'abcde', 'p' => '?b*d'}), 0);
is(pattern_match({'s' => 'abcde', 'p' => 'a*c?e'}), 1);

done_testing;
