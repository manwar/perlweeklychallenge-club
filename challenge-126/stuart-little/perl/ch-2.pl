#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub nbrs($mat, $i, $j) {
    my @pairs = grep {$_->[0] >= 0 && $_->[0] < scalar @{$mat} && $_->[1] >= 0 && $_->[1] < scalar @{$mat->[0]} && ($_->[0] != $i || $_->[1] != $j)}
    map {my $co = $_; my @a = map {[$i+$_,$j+$co]} (-1..1); @a}
    (-1..1);
    return \@pairs;
}

my @in = grep {scalar @{$_}} map {my @a = split /\s+/, $_; \@a} <DATA>;

for my $i (0..(scalar @in)-1) {
    for my $j (0..(scalar @{$in[0]})-1) {
        print( (($in[$i]->[$j] eq 'x') ? ($in[$i]->[$j]) : (scalar grep { $in[$_->[0]]->[$_->[1]] eq 'x' } @{nbrs(\@in,$i,$j)})) . " ");
    }
    print("\n");
}

__DATA__
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
