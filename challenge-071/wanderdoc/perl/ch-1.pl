#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given positive integer $N (>1). 
Write a script to create an array of size $N with random unique elements between 1 and 50.
In the end it should print peak elements in the array, if found.
An array element is called peak if it is bigger than it's neighbour.

Example 1
When array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ] Output Peak: [ 48, 45, 21 ]

Example 2
When array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ] Output Peak: [ 47, 32, 39, 36 ]

=cut

use List::Util qw(shuffle);

my $N = shift || 10;
my @array = 1 .. 50;
my @selection = (shuffle @array)[0 .. $N - 1];
print join(" ", @selection), $/;
print join(" ", find_peaks(@selection)), $/;

sub find_peaks
{
     my @arr = @_;
     my $i = 0;
     my @peaks;

     while ( $i < scalar @arr )
     {
          push @peaks, $arr[$i] if ( 
               (0 == $i and $arr[$i] > $arr[$i+1]) or 
               ($#arr == $i and $arr[$i] > $arr[$i-1]) or 
               ( $i > 0 and $i < $#arr and $arr[$i] > $arr[$i+1] and $arr[$i] > $arr[$i-1]) );


          $i++; 
     }
     return @peaks;

}