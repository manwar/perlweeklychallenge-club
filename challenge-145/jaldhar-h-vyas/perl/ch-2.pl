#!/usr/bin/perl
use 5.020;
use warnings;

sub isPalindrome {
    my ($word) = @_;

    return $word eq join q{}, reverse split //, $word;
}

my $s = shift // die "Need a word.\n";
my @palindromes;

for my $i (0 .. length($s) - 1) {

    my $char = substr $s, $i, 1;
    if (!scalar grep { $_ eq $char; } @palindromes) {
        push @palindromes, $char;
    }

    my $distance = length($s) - $i;
    while ($distance > 1) {
        my $part = substr $s, $i, $distance;
        if (isPalindrome($part) && !scalar grep { $_ eq $part; } @palindromes) {
            push @palindromes, $part;
            last;
        } else {
            $distance--;
        }
    }
}

say join q{ }, @palindromes;
