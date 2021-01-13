#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my $string  = "perlweeklychallenge";
my @words   = qw(perl weekly challenge);
my @ret     = ();
for my $word (@words) {
    $string =~ s/$word/ / && push @ret, $word
}

say $string =~ /\S/ ? 0 : "@ret"
