#!/usr/bin/perl
use 5.020;
use warnings;

sub pick {
    my @range = @{$_[0]};
    my $quantity = $_[1] // 1;

    if ($quantity < 1 || $quantity > scalar @range) {
        die "out of range\n";
    }

    my @picked;

    for my $i (1 .. $quantity) {
        my $try = q{ };
        while ($try eq q{ }) {
            $try = $range[int(rand(scalar @range))];
        }
        @range = map { $_ eq $try ? q{ } : $_; } @range;
        push @picked, $try;
    }

    return wantarray ? @picked : $picked[0];
}

sub batch {
    my @range = @{$_[0]};
    my $quantity = $_[1];

    if ($quantity < 1 || $quantity > scalar @range) {
        die "out of range\n";
    }

    my $length = scalar @range;
    my $i = 0;
    while ($i < $length) {
        my @row;
        for (1 .. $quantity) {
            push @row, shift @range;
            $i++;
            if ($i == $length) {
                last;
            }
        }
        push @range, [@row];
    }

    return wantarray ? @range : $range[0];
}

my @matrix = batch([sort { $a <=> $b } pick([1 .. 50], 25)], 5);
my $input = pick([1 .. 50]);
my $output = 0;

for my $i (0 .. scalar @matrix - 1) {
    if ($input <=  $matrix[$i][-1]) {
        for my $j (0 .. scalar @{$matrix[$i]} - 1) {
            if ($matrix[$i][$j] == $input) {
                $output = 1;
                last;
            }
        }
        last;
    }
}

for my $i (0 .. scalar @matrix - 1) {
    print $i ? q{        } : 'matrix: ';
    say q{[ }, (join q{, }, map { sprintf("%2d", $_); } @{$matrix[$i]}), q{ ]};
}
say "\nInput: ", $input;
say $output;
