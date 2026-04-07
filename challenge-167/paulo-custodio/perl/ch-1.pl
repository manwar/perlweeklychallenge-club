#!/usr/bin/env perl

# Perl Weekly Challenge 167 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-167/

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

sub next_prime {
    my($n) = @_;
    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}

sub is_circular_prime {
    my($n)=@_;
    state %seen;
    return 0 if $seen{$n}++;
    return 0 if $n<10;
    return 0 if $n =~ /[024568]/;
    my @rotations;
    for (1..length($n)) {
        push @rotations,$n;
        return 0 if !is_prime($n);
        $n=substr($n,1).substr($n,0,1);
    }
    $seen{$_}++ for @rotations;
    return 1;
}

sub next_circular_prime {
    my($n)=@_;
    $n++;
    while (!is_circular_prime($n)) {
        $n=next_prime($n);
    }
    return $n;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift;
my @cprimes;
my $cp=1;
while (@cprimes<$n) {
    $cp=next_circular_prime($cp);
    push @cprimes,$cp if $cp>=100;
}
say "(", join(", ", @cprimes), ")";
