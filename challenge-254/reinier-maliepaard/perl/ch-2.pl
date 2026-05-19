#!/usr/bin/perl
use strict;
use warnings;

sub reverse_vowels {
    my ($s) = @_;

    my @chars = split //, $s;
    my @vowel_index = grep { $chars[$_] =~ /[aeiouAEIOU]/ } 0..$#chars;

    my $i = 0;
    my $j = $#vowel_index;

    while ($i < $j) {
        @chars[@vowel_index[$i, $j]] = @chars[@vowel_index[$j, $i]];
        $i++;
        $j--;
    }

    return ucfirst(lc join '', @chars);
}

# Tests

my $s;

# Example 1
$s = "Raku";
print reverse_vowels($s),"\n"; # Output: Ruka

# Example 2
$s = "Julia";
print reverse_vowels($s),"\n"; # Output: Jaliu

# Example 3
$s = "Uiua";
print reverse_vowels($s),"\n"; #  Output: Auiu
