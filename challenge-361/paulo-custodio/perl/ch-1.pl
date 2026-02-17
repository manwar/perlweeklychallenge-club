#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum);

@ARGV==1 or die "usage: $0 n\n";

my $N = 0+shift;
my @seq = get_zeckendorf($N);
say join ", ", @seq;

sub get_fibonacci {
    my ($n) = @_;
    my @fibs = (0, 1);

    while (1) {
        my $next = $fibs[-1] + $fibs[-2];
        last if $next > $n;
        push @fibs, $next;
    }

    return @fibs;
}

sub get_zeckendorf {
    my ($target) = @_;
    my @fibs = reverse get_fibonacci($target);
    my @result;
    my $last_index = -2; # ensure not consecutive

    for my $i (0 .. $#fibs) {
        my $f = $fibs[$i];
        # Rule: f <= target, f > 0, and $i cannot be consecutive to $last_index
        if ($f <= $target && $f > 0 && $i > $last_index + 1) {
            push @result, $f;
            $target -= $f;
            $last_index = $i;
        }
    }
    return @result;
}
