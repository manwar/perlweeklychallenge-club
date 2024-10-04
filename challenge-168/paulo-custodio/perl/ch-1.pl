#!/usr/bin/env perl

# Challenge 168
#
# Task 1: Perrin Prime
# Submitted by: Roger Bell_West
#
# The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is
# the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ....)
#
#     A Perrin prime is a number in the Perrin sequence which is also a prime
#     number.
#
# Calculate the first 13 Perrin Primes.
#
# f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193,
#          792606555396977]

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

sub perrin_seq {
    my(@t)=(3,0,2);
    return sub {
        push @t, $t[-2]+$t[-3];
        return shift @t;
    }
}

sub perrin_prime_seq {
    my $it=perrin_seq();
    my %seen;
    return sub {
        while (1) {
            my $n=$it->();
            return $n if is_prime($n) && !$seen{$n}++;
        }
    };
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift;
my @pp;
my $it=perrin_prime_seq();
push @pp, $it->() while @pp<$n;
say join ", ", sort {$a<=>$b} @pp;
