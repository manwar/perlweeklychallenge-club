#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $S. Write a script to print the series of first non-repeating character for the given string. Print # if none found.
Example 1: Input: $S = 'ababc' Output: 'abb#c'
Pass 1: "a", the FNR character is 'a'
Pass 2: "ab", the FNR character is 'b'
Pass 3: "aba", the FNR character is 'b'
Pass 4: "abab", no FNR found, hence '#'
Pass 5: "ababc" the FNR character is 'c'

Example 2: Input: $S = 'xyzzyx' Output: 'xyzyx#'
Pass 1: "x", the FNR character is "x"
Pass 2: "xy", the FNR character is "y"
Pass 3: "xyz", the FNR character is "z"
Pass 4: "xyzz", the FNR character is "y"
Pass 5: "xyzzy", the FNR character is "x"
Pass 6: "xyzzyx", no FNR found, hence '#'
=cut



use Test::More;


sub fnr
{
     my $string = $_[0];
     my @letters = split(//,$string);
     my $output;

     for my $i ( 0 .. $#letters )
     {
          my @pass = @letters[0 .. $i];
          my %count;
          $count{$_}++ for @pass; 


          my $fnr = (grep {1 == $count{$_}} @pass)[-1] || '#';
          $output .= $fnr
     }

     return $output;
}



is(fnr('ababc'),  'abb#c',  'Example 1');
is(fnr('xyzzyx'), 'xyzyx#', 'Example 2');
done_testing();