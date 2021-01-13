#!/usr/bin/perl
use 5.020;
use warnings;

sub max {
    my (@N) = @_;
    my $maximum = 0;

    for my $i (@N) {
        if ($i > $maximum) {
            $maximum = $i;
        }
    }

    return $maximum;
}

sub histogram {
    my (@N) = @_;

    for my $y (reverse 1 .. max(@N)) {
        say "$y ",
            (join q{}, map { $N[$_] < $y ? q{ } : q{#}; } (0 .. scalar @N - 1));
    }
    say '-' x scalar @N + 2;
    say q{  }, (join q{}, @N);
}

my @N = @ARGV;

my $rainwater = 0;
my $tallest = $N[0];

for my $i (0 .. scalar @N - 1) {
        
    if ($N[$i] < $tallest) {
        $rainwater += ($tallest - $N[$i]);
    } else {
        $tallest = $N[$i];
    }
}

histogram(@N);
say $rainwater;
