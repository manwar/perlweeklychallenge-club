#!/usr/bin/env perl

# Perl Weekly Challenge 169 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-169/

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

sub is_powerfull {
    my($n) = @_;
    my @factors = prime_factors($n);
    for (@factors) {
        return 0 if $n % ($_*$_) != 0;
    }
    return 1;
}

sub is_perfect {
    my($n) = @_;
    for my $e (2..$n) {
        for my $b (1..$n) {
            my $power = $b ** $e;
            return 1 if $power == $n;
            last if $power > $n;
        }
    }
    return 0;
}

sub is_aquilles {
    my($n) = @_;
    return is_powerfull($n) && !is_perfect($n);
}

sub aquilles_seq {
    my($n) = 1;
    return sub {
        while (1) {
            $n++;
            return $n if is_aquilles($n);
        }
    };
}

@ARGV==1 or die "usage: ch-2.pl n\n";
my $n=shift;
my @aquilles;
my $it = aquilles_seq();
push @aquilles, $it->() while @aquilles < $n;
say "(", join(", ", @aquilles), ")";
