#!/usr/bin/env perl
#
# ch-2a.pl - Alternate solutions (see blog)

use v5.38;
use List::Util qw< sum max reduce >;

sub reduce1 {
    (reduce { $a->[1] > $b->[1] ? $a : $b }
        map { [   $_ => sum @{$_[$_]}   ] } keys @_)->[0];
}

sub reduce2 {
    my @teams = map { sum @$_ } @_;
    reduce { $teams[$a] > $teams[$b] ? $a : $b } keys @_;
}

sub hash_ {
    my %vals = map { sum(@{$_[$_]}) => $_ } keys @_;
    $vals{ max keys %vals }
}

sub loop {
    my @best = (0,0);
    for (keys @_) {
        my $sum = sum $_[$_]->@*;
        @best = ($sum, $_) if $sum > $best[0];
    }
    $best[1];
}


# Benchmark them if --bench is given
if ($ARGV[0] and $ARGV[0] =~ /^--bench(mark)?$/) {
    require './ch-2.pl';
    use Benchmark qw< cmpthese >;

    my @grid = ([0,0,0,0,0],
                [1,0,0,0,0],
                [1,1,0,1,1],
                [1,1,0,0,0],
                [1,1,0,1,0]);

    cmpthese(-3, {
        reduce1 => sub { reduce1(@grid) },
        reduce2 => sub { reduce2(@grid) },
        hash    => sub { hash_(@grid) },
        loop    => sub { loop(@grid) },
        best    => sub { best(@grid) },
    });
}
