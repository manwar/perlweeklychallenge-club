#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N. Write a script to produce Hash-counting string of that length.
The definition of a hash-counting string is as follows:
- the string consists only of digits 0-9 and hashes, ‘#’
- there are no two consecutive hashes: ‘##’ does not appear in your string
- the last character is a hash
- the number immediately preceding each hash (if it exists) is the position of that hash in the string, with the position being counted up from 1
It can be shown that for every positive integer N there is exactly one such length-N string.


=cut



sub hash_counting_string
{
     my $length = $_[0];
     my $string = '#' x $length;

     return $string  if $length == 1;
     return '2#'     if $length == 2;

     my $offset = $length - 1;
     
     while ( $offset > 1 )
     {
          my $hash_sign_idx = rindex($string, '#', $offset);
          my $idx_1_based = $hash_sign_idx + 1;
          my $idx_width = length($idx_1_based);
          my $begin = $hash_sign_idx - $idx_width;

          substr($string, $begin, $idx_width, $idx_1_based);
          $offset = $begin;
     }


     return $string;
}


for my $length ( 1 .. 100 )
{
     print join(" ", $length, hash_counting_string($length)), $/;
}