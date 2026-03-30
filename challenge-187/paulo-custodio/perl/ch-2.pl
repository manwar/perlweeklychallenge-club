#!/usr/bin/env perl

# Perl Weekly Challenge 187 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-187/

use Modern::Perl;
use List::Util 'sum';

sub triplets {
    my(@n) = @_;
    my @result;
    for my $ai (0..$#n) {
        my $a = $n[$ai];
        for my $bi (0..$#n) {
            next if $bi == $ai;
            my $b = $n[$bi];
            for my $ci (0..$#n) {
                next if $ci == $bi || $ci == $ai;
                my $c = $n[$ci];
                next unless $a+$b>$c;
                next unless $b+$c>$a;
                next unless $a+$c>$b;
                if (!@result || sum(@result) < sum($a, $b, $c)) {
                    @result = ($a, $b, $c);
                }
            }
        }
    }
    return sort {$b <=> $a} @result;
}

@ARGV or die "usage: ch-2.pl list...\n";
say "(", join(", ", triplets(@ARGV)), ")";
