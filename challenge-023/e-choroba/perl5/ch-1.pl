#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ sum };

# Recursive implementation.

sub fds {
    my ($seq, $order) = @_;
    my @r = map $seq->[$_] - $seq->[$_ - 1], 1 .. $#$seq;
    return @r if $order == 1;

    return fds(\@r, $order - 1)
}

# Faster, uses memoizing and formulas for the given order.

{   my %cache;
    sub binomial {
        my ($n, $k) = @_;
        return $cache{$n}{$k} if $cache{$n}{$k};
        my $r = 1;
        $r *= $_ for 2 .. $n;
        $r /= $_ for 2 .. $k, 2 .. ($n - $k);
        return $cache{$n}{$k} = $r
    }
}

sub fds2 {
    my ($seq, $order) = @_;
    my @coefficients = map binomial($order, $_), 0 .. $order;
    $coefficients[2 * $_] *= -1 for -($order + 1) / 2 .. -1;
    return map {
        my $i = $_;
        sum(map $seq->[$i + $_] * $coefficients[$_], 0 .. $order)
    } 0 .. $#$seq - $order
}

my $order = pop;
say join ' ', fds2([@ARGV], $order);
