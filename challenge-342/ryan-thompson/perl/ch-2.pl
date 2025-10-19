#!/usr/bin/env perl

use v5.38;
use List::Util qw< max >;

sub max_score {
    return 0 if $_[0] eq '';
    my ($l, $r) = split //, $_[0], 2;
    my $s = !$l + $r =~ tr/1//;
    max 0+$s, map { $s += $_ ? -1 : 1 } split //,substr $r,0,-1;
}

# Only a few % faster on larger strings, and a lot less readable.
sub max_score_ugly_fast {
    return 0 if $_[0] eq '';
    my $s = !substr($_[0],0,1) + substr($_[0],1) =~ tr/1//;
    max 0+$s, map { $s += substr($_[0],$_,1) ? -1 : 1 } 1..length($_[0])-2;
}
