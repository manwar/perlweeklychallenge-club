#!/usr/bin/perl
use 5.030;
use warnings;

sub classify {
    my %count;

    for my $n (@_) {
        push @{$count{$n}}, $n;
    }
    return %count;
}

my %freq = classify(@ARGV);

say q{(},
    (
        join q{,},
        map { @{$freq{$_}} }
        sort { scalar @{$freq{$a}} <=> scalar @{$freq{$b}} || $b <=> $a }
        keys %freq
    ),
q{)};
