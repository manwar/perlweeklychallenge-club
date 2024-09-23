#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub closest_palindrome($str) {
    my $distance = 1;
    while (1) {
        for my $i ($str - $distance, $str + $distance) {
            next if $i < 0;
            return $i if $i == reverse $i;
        }
        ++$distance;
    }
}

sub closest_palindrome_opt($str) {
    if ($str < 12) {
        return 0 if $str < 0;
        return 1 if $str == 0;
        return 9 if $str == 11;
        return $str - 1
    }

    my $length = length $str;
    my $prefix   = substr $str, 0, $length % 2 + $length / 2;
    my @palindromes = ($prefix . reverse substr $str, 0, $length /2);

    my $prefix_plus_1 = $prefix + 1;
    my $length_p1 = $length;
    if ($prefix =~ /^9+$/) {
        ++$length_p1;
        $prefix_plus_1 = '1' . '0' x ($length / 2);
    }
    unshift @palindromes, $prefix_plus_1
        . reverse substr $prefix_plus_1, 0, $length_p1 % 2
                                            ? -1
                                            : length $prefix_plus_1;

    my $prefix_minus_1 = $prefix - 1;
    my $length_m1 = $length;
    if ($prefix =~ /^10+$/) {
        --$length_m1;
        $prefix_minus_1 = '9' x ($length / 2);
    }
    unshift @palindromes, $prefix_minus_1
        . reverse substr $prefix_minus_1, 0, $length_m1 % 2
                                             ? -1
                                             : length $prefix_minus_1;
    return (grep $_ != $str,
            sort { abs($str - $a) <=> abs($str - $b) || $a <=> $b }
            @palindromes)[0]
}

use Test::More tests => 2 * (4 + 6);

for my $closest_palindrome (\&closest_palindrome, \&closest_palindrome_opt) {
    is $closest_palindrome->('123'), '121', 'Example 1';
    is $closest_palindrome->('2'), '1', 'Example 2';
    is $closest_palindrome->('1400'), '1441', 'Example 3';
    is $closest_palindrome->('1001'), '999', 'Example 4';

    is $closest_palindrome->('-10'), '0', 'Negative';
    is $closest_palindrome->('99999'), '100001', '9 x odd';
    is $closest_palindrome->('9999'), '10001', '9 x even';
    is $closest_palindrome->('10000'), '9999', '1 0+ 1';
    is $closest_palindrome->('10001'), '9999', '1 . 0 x odd . 1';
    is $closest_palindrome->('11'), '9', 'eleven to nine';
}

for (1 .. 100_000) {
    my $n = int(rand 1_000_000);
    closest_palindrome($n) eq closest_palindrome_opt($n)
        or die "$n: ", closest_palindrome($n), ' ', closest_palindrome_opt($n);
}

use Benchmark qw{ cmpthese };
my @list = map int rand 1e6, 1 .. 10;
cmpthese(-3, {
    orig => sub { closest_palindrome($_) for @list },
    opt  => sub { closest_palindrome_opt($_) for @list },
});

__END__
        Rate  orig   opt
orig  1398/s    --  -97%
opt  47284/s 3283%    --
