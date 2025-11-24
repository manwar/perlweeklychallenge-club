#!/usr/bin/perl
use 5.038;
use warnings;

my $str = shift;

my $mid = (length $str) / 2;
my $first = substr $str, 0, $mid;
my $second = substr $str, $mid;
my $vowels = qr/([aeiouAEIOU])/;
my $firstVowels = @{[ $first =~ /$vowels/g ]};
my $secondVowels = @{[ $second =~ /$vowels/g ]};

say 0+($firstVowels > 0 && $secondVowels > 0 && $firstVowels == $secondVowels)
    ? 'true'
    : 'false';

