#!/usr/bin/perl
use v5.38;

my $alien = shift;
my @words = @ARGV;

my $i = 0;
my %order = map { $_ => $i++ } split //, $alien;

say
    join q{ },
    sort {
        my @a = split //, $a;
        my @b = split //, $b;
        for my $i (keys @a) {
            if ($order{$a[$i]} != $order{$b[$i]}) {
                return $order{$a[$i]} <=> $order{$b[$i]};
            }
        }
        return @a <=> @b;
    }
    @words;
