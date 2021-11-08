#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub trps($n) {
    my @triples;
    push @triples, (grep {$_->[0] && $_->[1] && $_->[1]**2 == $n**2-$_->[0]**2} map {[$_, int(sqrt($n**2-$_**2)), $n]} 1..int(($n+1)/2));
    push @triples, ( map { my $s = int($n**2/$_); my $a = int(($s-$_)/2); my $b = int(($s+$_)/2); [$a,$n,$b]} grep { ($n**2 % $_ == 0) && ($_%2 == int($n**2/$_)%2) } 1..$n-1 );
    return \@triples;
}

my $sol=trps($ARGV[0]);
(scalar @{$sol}) && do {
    for (@{$sol}) {
	say "@{$_}";
    }
    exit;
};

say -1;
