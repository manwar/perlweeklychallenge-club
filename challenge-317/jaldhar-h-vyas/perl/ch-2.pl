#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

my ($str1, $str2) = @ARGV;

my @chars = split //, $str1;
my $result = false;

my $length = length $str1;

for my $i (0 .. $length - 1) {
    for my $j (($i + 1) .. $length - 1) {
        my @temp = @chars;

        ($temp[$i], $temp[$j]) = ($temp[$j], $temp[$i]);

        if ((join q{}, @temp) eq $str2) {
            $result = true;
            last;
        }
    }
}

say $result ? 'true' : 'false';

