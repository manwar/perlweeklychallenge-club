#!/usr/bin/env perl

# Perl Weekly Challenge 168 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-168/

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
say "(", join(", ", sort {$a<=>$b} @pp), ")";
