#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary string $B and an integer $S. Write a script to split the binary string $B of size $S and then find the minimum number of flips required to make it all the same.
Example 1: Input: $B = “101100101”, $S = 3
Output: 1
Binary Substrings: "101": 0 flip "100": 1 flip to make it "101" "101": 0 flip
Example 2: Input $B = “10110111”, $S = 4
Output: 2 
Binary Substrings: "1011": 0 flip "0111": 2 flips to make it "1011"

=cut


use List::Util qw(min sum);
use Test::More;

sub count_flips
{
     my ($str, $int) = @_;
     my $length = length($str);

     die "Size mismatch!$/" if ($length % $int or $length <= $int);

     my $format = "a${int}" x ($length/$int);

     my @arr = unpack $format, $str;

     my $min = $length;
     for my $idx ( 0 .. $#arr )
     {
          my $comparing = $arr[$idx];
          my $sum = sum( map { unpack '%32b*', $comparing ^ $_ } 
                         @arr[grep $_ != $idx, 0 .. $#arr] ); 
          $min = $sum if $sum < $min;
     }


     return $min;
}


is(count_flips(qw(101100101), 3), 1, 'Example 1');
is(count_flips(qw(10110111),  4), 2, 'Example 2');
is(count_flips(qw(100111110), 3), 2, 'My Example');


done_testing();