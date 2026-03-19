#!/usr/bin/env perl

# Perl Weekly Challenge 241 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/

use Modern::Perl;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}

sub prime_factors {
    my($n) = @_;
    my @factors;
    my $p = 0;
    while ($n > 1) {
        do { $p++; } while (!is_prime($p));
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
    return @factors;
}

# parse args
@ARGV>0 or die "ch-2 n n...\n";
my @nums = @ARGV;

# process
@nums = map { $_->[0] }
        sort {
            my(@fa) = @{$a->[1]};
            my(@fb) = @{$b->[1]};
            if (@fa != @fb) { return scalar(@fa) - scalar(@fb); }
            for my $i (0 .. $#fa) {
                if ($fa[$i] != $fb[$i]) { return $fa[$i] - $fb[$i]; }
            }
            return 0;
        }
        map {[$_, [prime_factors($_)]]} @nums;

# output
say "@nums";
