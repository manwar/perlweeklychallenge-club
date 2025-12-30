#!/usr/bin/perl
use 5.038;
use warnings;

sub rotate($k, @arr) {
    if ($k < 0) {
        for my $i (1 .. -$k) {
            unshift @arr, pop @arr;
        }
    } elsif ($k > 0) {
        for my $i (1 .. $k) {
            push @arr, shift @arr;
        }
    }

    return @arr;

}

my ($k, @matrix) = @ARGV;

@matrix = map { [ split /\s+/ ] } @matrix;

my $m = scalar @matrix;
my $n = scalar @{$matrix[0]};

$k %= $m * $n;

my @flat = map { @{$_} } @matrix;
@flat = rotate(-$k, @flat);

@matrix = ();
while (@flat) {
    push @matrix, [splice @flat, 0, $n];
}

say q{(}, 
    ($n < 2
        ? (q{[} . (join q{, }, map { @{$_} } @matrix) . q{]})
        : (join "\n", map { q{[} . (join q{, }, @{$_}) . q{]} } @matrix)),
    q{)};
