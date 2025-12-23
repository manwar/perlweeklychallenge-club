#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true /;
no warnings qw/ experimental::builtin /;

sub fibonacci($n) {
    my @fibs = (1, 2);

    while (true) {
        my $fib = $fibs[-1] + $fibs[-2];

        if ($fib > $n) {
            last;
        }

        push @fibs, $fib;
    }

    return @fibs;
}

sub find($n, $fibs, $current, $start) {
    if ($n == 0 && @{$current}) {
        say q{}, (join q{ + }, @{$current}), " = ", sum(@{$current});
        return 1;
    }

    my $found = 0;

    for my $i ($start .. scalar @{$fibs} - 1) {
        if ($fibs->[$i] > $n) {
            next;
        }

        my @next = @{$current};
        push @next, $fibs->[$i];
        $found += find($n - @{$fibs}[$i], $fibs, \@next, $i + 1);
    }

    return $found;
}

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my ($N) = @ARGV;
my @fibs = fibonacci($N);

unless (find($N, \@fibs, [], 0)) {
    say 0;
};
