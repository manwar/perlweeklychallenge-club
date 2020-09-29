#!/usr/bin/env perl
use v5.28;

=head1 Usage

    # perl ./challenge-080/gugod/perl/ch-1.pl 5 2 -2 0
    1

    # perl ./challenge-080/gugod/perl/ch-1.pl 5 2 -2 0 1
    3

=cut

my @N = grep { $_ > 0 } map { int($_) } @ARGV;

my %seen = map { $_ => 1 } @N;
my $i = 1;
$i++ while $seen{$i};

say $i;
