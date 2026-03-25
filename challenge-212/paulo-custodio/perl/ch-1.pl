#!/usr/bin/env perl

# Perl Weekly Challenge 212 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-212/

use Modern::Perl;

sub encode {
    my($word, @jumps) = @_;
    my @word = split //, $word;
    for my $i (0..$#word) {
        if ($word[$i] =~ /[a-z]/) {
            $word[$i] = chr(((ord($word[$i])-ord('a') + $jumps[$i]) % 26) + ord('a'));
        }
        elsif ($word[$i] =~ /[A-Z]/) {
            $word[$i] = chr(((ord($word[$i])-ord('A') + $jumps[$i]) % 26) + ord('A'));
        }
    }
    return join "", @word;
}

@ARGV or die "usage: ch-1.pl word jumps...\n";
say encode(@ARGV);
