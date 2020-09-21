#!/usr/bin/env perl

use strict; use warnings;
use v5.26;

use List::Util qw(any min);

# tested with: perl ch-1.pl 9 10 7 5 6 1

sub leaderElement {
    @_ > 0 or return (0); # this is the only case of result [0]
    my @rList = reverse @_;
    my $curLeader = -1 + min @rList; # pseudo first leader
                                     # to work alwo with negative values
    reverse map { $curLeader <= $_ ? $curLeader = $_ : () } @rList;
}

any { /^(-h|--*help)$/ } @ARGV  and say("perl ch-1.pl <integer> ..."), exit 1;

my @answer = leaderElement( grep { int($_) eq $_ } @ARGV );
say "(@answer)";
