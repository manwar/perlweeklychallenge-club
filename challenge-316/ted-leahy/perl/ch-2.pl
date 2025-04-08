#!/usr/bin/env perl
use v5.36;

my @inputs = (
    ['uvw', 'bcudvew'],
    ['aec', 'abcde'],
    ['sip', 'javascript'],
);

foreach my $input (@inputs) {
    printf "Input: [%s]\n", join ', ', @$input;
    say is_subsequence(@$input) ? 'true' : 'false';
}

# Checks whether the characters from $str1 occur in $str2 in the same order
sub is_subsequence($str1, $str2) {
    # split str1 into chars and insert '\w*' between each char
    my $str1_pattern = join '\w*', split(//, $str1);

    return $str2 =~ /$str1_pattern/;
}
