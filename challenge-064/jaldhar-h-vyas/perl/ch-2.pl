#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub search {
    my ($S, @W) = @_;
    my @results;

    push @results, grep { $S =~ /$_/ } @W; 

    return (scalar @results) ? join ', ', @results : 0;
}

say search("perlweeklychallenge", ("weekly", "challenge", "perl"));
say search("perlandraku", ("python", "ruby", "haskell"));
