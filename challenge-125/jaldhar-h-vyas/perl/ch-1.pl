#!/usr/bin/perl
use 5.038;
use warnings;
use POSIX qw/ floor /;

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

my ($N) = @ARGV;
my @triples;

foreach my $a (1 .. $N) {
    my $aSquared = $a ** 2;
    my $b = $a + 1;

    while ($a >= $N || $b <= $N) {
        my $bSquared = $b ** 2;
        my $sum = $aSquared + $bSquared;
        my $c = int(sqrt($sum));

        if ($c == $b) {
            last;
        }

        if ($sum == $c ** 2 && ($a == $N || $b == $N || $c == $N)) {
            push @triples, [ $a, $b, $c ];
        }

        $b++;
    }
}

@triples =
    sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] || $a->[2] <=> $b->[2] }
    map { [split q{-}] }
    unique(
        map { join q{-}, @{$_} } 
        @triples
    );

say @triples
    ? join "\n", map { q{(} . (join q{, }, @{$_}) . q{)} } @triples
    : -1;
