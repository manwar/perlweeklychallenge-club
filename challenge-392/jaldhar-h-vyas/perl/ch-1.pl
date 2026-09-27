#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;
my $palindrome = $str;
my $len = 1;

while ($palindrome ne reverse $palindrome) {
    $palindrome = reverse(substr($str, -($len), $len)) . $str;
    $len++;
}

say $palindrome;
