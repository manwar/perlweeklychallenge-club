#!/usr/bin/env perl

# Perl Weekly Challenge 177 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-177/

use Modern::Perl;

sub is_palindromic {
    my($n) = @_;
    my $rev = join '', reverse split //, $n;
    return $n == $rev;
}

sub is_cyclops {
    my($n) = @_;
    return 0 unless $n =~ /^([1-9]+)0([1-9]+)$/;
    return 0 unless length($1)==length($2);
    return 1;
}

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

sub is_palindromic_cyclops_prime {
    my($n) = @_;
    return is_palindromic($n) && is_cyclops($n) && is_prime($n);
}

sub palindromic_cyclops_prime {
    my($N) = @_;
    my $n = 100;
    my @result;
    while (@result < $N) {
        push @result, $n if is_palindromic_cyclops_prime($n);
        $n++;
    }
    return @result;
}

@ARGV==1 or die "usage: ch-2.pl N\n";
my $N = shift;
say "(", join(", ", palindromic_cyclops_prime($N)), ")";
