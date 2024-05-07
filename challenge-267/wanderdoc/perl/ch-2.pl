#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, and a 26-items array @widths containing the width of each character from a to z.

Write a script to find out the number of lines and the width of the last line needed to display the given string, assuming you can only fit 100 width units on a line.
Example 1

Input: $str = "abcdefghijklmnopqrstuvwxyz"
       @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
Output: (3, 60)

Line 1: abcdefghij (100 pixels)
Line 2: klmnopqrst (100 pixels)
Line 3: uvwxyz (60 pixels)

Example 2

Input: $str = "bbbcccdddaaa"
       @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
Output: (2, 4)

Line 1: bbbcccdddaa (98 pixels)
Line 2: a (4 pixels)

=cut

use constant LINE_LENGTH => 100;
use Test2::V0;

is(
     line_counts("abcdefghijklmnopqrstuvwxyz", [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]), 
     [3, 60],
     'Example 1');
is(
     line_counts("bbbcccdddaaa", [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]), 
     [2, 4],
     'Example 2');
     
done_testing();



sub line_counts
{
     my ($str, $wds_aref) = @_;


     my %width;
     @width{'a' .. 'z'} = @$wds_aref;

     my @letters = split(//,$str);
     my @output;
     my @this_line;
     my $this_length = 0;
     for my $idx ( 0 .. $#letters )
     {
          if ( $this_length + $width{ $letters[$idx] } <= LINE_LENGTH )
          {
               push @this_line, $letters[$idx];

               $this_length += $width{ $letters[$idx] };

               if ( $idx == $#letters )
               {
                    push @output, [ join('', @this_line), $this_length];
               }
          }
          else
          {
               push @output, [ join('', @this_line), $this_length];
               @this_line = ();
               $this_length = 0;
               redo;
          }
     }
     return [scalar @output, $output[-1][1]];
}