#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main (@sentences) {
    my %word_freq = ();
    foreach my $sentence (@sentences) {
        foreach my $word ( split /\s+/, $sentence ) {
            $word_freq{$word}++;
        }
    }

    say "("
      . join( ", ",
        sort map { qq{"$_"} } grep { $word_freq{$_} == 1 } keys %word_freq )
      . ")";
}

main(@ARGV);
