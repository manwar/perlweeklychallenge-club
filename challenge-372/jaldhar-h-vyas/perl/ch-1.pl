#!/usr/bin/perl
use 5.40.1;
use warnings;

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my ($str) = @ARGV;
my @words = $str =~/(\w+)/g;
my $spaces = (length $str) - sum(map { length $_ } @words);
my $gaps = scalar @words - 1;

if ($gaps) {
    for my $i (0 .. $gaps - 1) {
        $words[$i] .= q{ } x ($spaces / $gaps);
    }
    push @words, q{ } x ($spaces % $gaps);        
} else {
    push @words, q{ } x $spaces;
}

say q{"}, (join q{}, @words), q{"};

