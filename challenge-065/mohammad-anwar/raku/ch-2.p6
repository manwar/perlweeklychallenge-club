#!/usr/bin/env perl6

#
# Perl Weekly Challenge - 065
#
# Task #2: Palindrome Partition
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-065/
#

use v6.d;

sub MAIN(Str :$string? where $string.chars > 1 = 'aabaab') {
    my $palindromes = find-partitions($string);
    $_.join(", ").say for @$palindromes;
}

sub find-partitions(Str $string) {

    my %partitions;
    for ($string.split('')).combinations -> $partition {
        my $str = $partition.join('');
        next if $str.chars == 1 || $str.chars == $string.chars;

        if $str.chars > 1 && $string.index($str).defined {
            %partitions{$str} = $string.index($str);
        }
    }

    my $index = 0;
    my $palindromes     = [];
    my %seen_partitions = ();

    for %partitions.sort({ $^a.value <=> $^b.value
                           ||
                           $^a.key cmp $^b.key
                        }) -> $primary {
        my ($pkey) = $primary.keys;
        my ($pval) = $primary.values;

        next if $pkey ne $pkey.flip;
        next if %seen_partitions{$pkey}:exists;

        $palindromes.[$index].push: $pkey;
        for %partitions.sort -> $secondary {
            my ($skey) = $secondary.keys;
            my ($sval) = $secondary.values;
            next if $skey ne $skey.flip;

            if $sval >= %partitions{$pkey} + $pkey.chars {
                $palindromes.[$index].push: $skey;
                %seen_partitions{$skey} = 1;
            }
        }
        $index++;
    }

    $palindromes.[$palindromes.elems] = $string
        if $string eq $string.flip;

    return $palindromes;
}
