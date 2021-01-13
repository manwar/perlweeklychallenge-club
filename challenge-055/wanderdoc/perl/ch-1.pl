#!perl
use strict;
use warnings FATAL => qw(all);



=prompt
You are given a binary number B, consisting of N binary digits 0 or 1: s0, s1, …, s(N-1).

Choose two indices L and R such that 0 ≤ L ≤ R < N and flip the digits s(L), s(L+1), …, s(R). By flipping, we mean change 0 to 1 and vice-versa.

For example, given the binary number 010, the possible flip pair results are listed below:

    L=0, R=0 the result binary: 110
    L=0, R=1 the result binary: 100
    L=0, R=2 the result binary: 101
    L=1, R=1 the result binary: 000
    L=1, R=2 the result binary: 001
    L=2, R=2 the result binary: 011

Write a script to find the indices (L,R) that results in a binary number with maximum number of 1s. If you find more than one maximal pair L,R then print all of them.
Continuing our example, note that we had three pairs (L=0, R=0), (L=0, R=2), and (L=2, R=2) that resulted in a binary number with two 1s, which was the maximum. So we would print all three pairs.
=cut



my $string = shift or die "Give a binary string!$/";
my $max_idx = find_max_pair($string);
print "[" . join("] [", @$max_idx) . "]", $/;



sub find_max_pair
{

     my $string = $_[0];
     my $len = length $string;
     my %pairs;


     for my $l ( 0 .. $len - 1 )
     {
          for my $r ( $l .. $len - 1 )
          {
               my $str2 = $string;
               substr($str2, $l, 1 - $l + $r) =~ tr/10/01/;
               my $cnt = $str2 =~ tr/1/1/;
               push @{ $pairs{ $cnt } }, "$l, $r";

          }
     }
     my ($max) = (sort { $b <=> $a } keys %pairs)[0];
     return $pairs{$max};

}