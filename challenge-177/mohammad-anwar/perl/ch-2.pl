#!/usr/bin/perl

=head1

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #2: Palindromic Prime Cyclops

    Write a script to generate first 20 Palindromic Prime Cyclops Numbers.

=cut

use Test2::V0;
use v5.36;
use experimental qw(builtin);
use builtin   qw(true false);

is [    101,   16061,   31013,   35053,   38083,   73037,   74047,
      91019,   94049, 1120211, 1150511, 1160611, 1180811, 1190911,
    1250521, 1280821, 1360631, 1390931, 1490941, 1520251,
], palindromic_prime_cyclops(20);

done_testing;

#
#
# METHODS

sub is_cyclops($n) {
    my @n = split //, $n;
    my $m = (@n - 1) / 2;
    return false if @n % 2 == 0
                 or $n[$m] != 0
                 or grep /0/, @n[0..$m-1]
                 or grep /0/, @n[$m+1..@n-1];
    return true;
}

sub is_prime($n) {
    return false if ($n == 1);
    do { return false unless $n % $_ } for (2 .. sqrt $n);
    return true;
}

sub is_palindrome($n) {
    return $n eq reverse $n;
}

sub palindromic_prime_cyclops($n) {
    my @ppc = ();
    my $i   = 101;
    while (@ppc < $n) {
        push @ppc, $i
        if is_palindrome($i) and is_prime($i) and is_cyclops($i);
        $i += 2;
    }

    return \@ppc;
}
