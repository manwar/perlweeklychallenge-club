#!/usr/bin/perl
use 5.038;
use warnings;

sub sum(@elems) {
    my $total;
    for my $n (@elems) {
        $total += $n;
    }

    return $total;
}

my @scores = @ARGV;
my @previous; 

for my $score (@scores) {
    if ($score eq 'C') {
        pop @previous;
    }
    elsif ($score eq 'D') {
        push @previous, 2 * $previous[-1];
    }
    elsif ($score eq '+') {
        push @previous, $previous[-1] + $previous[-2];
    }
    else {
        push @previous, $score;
    }
}

say sum(@previous);
