#!/usr/bin/env perl
use v5.28;

=head1 Usage

    # perl ./challenge-080/gugod/perl/ch-2.pl 1 4 3 2
    7

=cut

my @N = grep { $_ > 0 } map { int($_) } @ARGV;

my $extra = grep { @N[$_] != @N[$_-1] } (1..@N-1);

say @N + $extra;
