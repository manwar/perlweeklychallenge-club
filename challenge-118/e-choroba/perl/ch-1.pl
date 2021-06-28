#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ none };

sub binary_palindrome_reverse {
    my ($n) = @_;
    my $bin = sprintf '%b', $n;
    $bin =~ s/^0+//;
    return $bin eq reverse $bin
}

sub binary_palindrome {
    my ($n) = @_;
    my $highest_exp = int(log($n) / log 2);
    return none {
        ! ($n & (2 ** $_)) ^ ! ($n & (2 ** ($highest_exp - $_)))
    } 0 .. ($highest_exp / 2) - ! ($highest_exp & 1);
}

use Test::More;

ok   binary_palindrome(5), 'Example 1';
ok ! binary_palindrome(4), 'Example 2';

ok   binary_palindrome(2 ** 20 - 1), 'large pal';
ok ! binary_palindrome(2 ** 20), 'large non-pal';

is binary_palindrome(oct $_), binary_palindrome_reverse(oct $_), $_
    for qw( 0b1001001 0b10011001 0b101101 0b10101 );
is binary_palindrome(oct $_), binary_palindrome_reverse(oct $_), $_
    for qw( 0b11010111001011101011 );

my @r = map 1 + int rand 2 ** 20, 1 .. 2000;
is binary_palindrome($_), binary_palindrome_reverse($_), "random $_"
    for @r;

done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    reverse   => sub { binary_palindrome_reverse($_) for @r },
    calculate => sub { binary_palindrome($_) for @r },
});

__END__
           Rate calculate   reverse
calculate 216/s        --      -68%
reverse   674/s      212%        --
