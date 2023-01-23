#! /usr/bin/perl
# Robbie Hatley's Perl solution to The Weekly Challenge #200-2

=pod

Task 2: Seven Segment 200
Submitted by: Ryan J Thompson
A seven segment display is an electronic component, usually used to display
digits. The segments are labeled 'a' through 'g' as shown:

    a
  f   b
    g
  e   c
    d

The encoding of each digit can thus be represented compactly as a truth table:
my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
$truth[1] would thus be "bc", indicating that the digit 1 would have segments
"b" and "c" enabled. Write a program that accepts any [non-negative integer 
of 1-9 digits] and draws that number as a horizontal sequence of seven-segment
digit displays, similar to the following:
  -------  -------  -------
        |  |     |  |     |
        |  |     |  |     |
  -------
  |        |     |  |     |
  |        |     |  |     |
  -------  -------  -------
Note that each row consists of 7 lines of 9*n characters, where n is the number
of digits to be displayed.

=cut

# NOTE: Input is by @ARGV and should be a single integer in the range
#       0 to 999999999.

# NOTE: Output is to stdout and will be a row of 7-segment digit displays for
#       the digits of the input number.

# PRELIMINARIES:
use v5.36;

# SUBROUTINES:
sub display_row($x)
{
   my $l = length($x);
   my @digits = split //,$x;
   my @lines =
   (' 'x(9*$l),' 'x(9*$l),' 'x(9*$l),' 'x(9*$l),' 'x(9*$l),' 'x(9*$l),' 'x(9*$l));
   for ( my $idx = 0; $idx < $l ; ++$idx )
   {
      if ( '0' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '|     |';
         substr $lines[2], 9*$idx+2, 7, '|     |';
         substr $lines[3], 9*$idx+2, 7, '       ';
         substr $lines[4], 9*$idx+2, 7, '|     |';
         substr $lines[5], 9*$idx+2, 7, '|     |';
         substr $lines[6], 9*$idx+2, 7, '-------';
      }
      elsif ( '1' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '       ';
         substr $lines[1], 9*$idx+2, 7, '      |';
         substr $lines[2], 9*$idx+2, 7, '      |';
         substr $lines[3], 9*$idx+2, 7, '       ';
         substr $lines[4], 9*$idx+2, 7, '      |';
         substr $lines[5], 9*$idx+2, 7, '      |';
         substr $lines[6], 9*$idx+2, 7, '       ';
      }
      elsif ( '2' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '      |';
         substr $lines[2], 9*$idx+2, 7, '      |';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '|      ';
         substr $lines[5], 9*$idx+2, 7, '|      ';
         substr $lines[6], 9*$idx+2, 7, '-------';
      }
      elsif ( '3' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '      |';
         substr $lines[2], 9*$idx+2, 7, '      |';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '      |';
         substr $lines[5], 9*$idx+2, 7, '      |';
         substr $lines[6], 9*$idx+2, 7, '-------';
      }
      elsif ( '4' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '       ';
         substr $lines[1], 9*$idx+2, 7, '|     |';
         substr $lines[2], 9*$idx+2, 7, '|     |';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '      |';
         substr $lines[5], 9*$idx+2, 7, '      |';
         substr $lines[6], 9*$idx+2, 7, '       ';
      }
      elsif ( '5' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '|      ';
         substr $lines[2], 9*$idx+2, 7, '|      ';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '      |';
         substr $lines[5], 9*$idx+2, 7, '      |';
         substr $lines[6], 9*$idx+2, 7, '-------';
      }
      elsif ( '6' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '|      ';
         substr $lines[2], 9*$idx+2, 7, '|      ';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '|     |';
         substr $lines[5], 9*$idx+2, 7, '|     |';
         substr $lines[6], 9*$idx+2, 7, '-------';
      }
      elsif ( '7' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '      |';
         substr $lines[2], 9*$idx+2, 7, '      |';
         substr $lines[3], 9*$idx+2, 7, '       ';
         substr $lines[4], 9*$idx+2, 7, '      |';
         substr $lines[5], 9*$idx+2, 7, '      |';
         substr $lines[6], 9*$idx+2, 7, '       ';
      }
      elsif ( '8' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '|     |';
         substr $lines[2], 9*$idx+2, 7, '|     |';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '|     |';
         substr $lines[5], 9*$idx+2, 7, '|     |';
         substr $lines[6], 9*$idx+2, 7, '-------';
      }
      elsif ( '9' eq $digits[$idx] )
      {
         substr $lines[0], 9*$idx+2, 7, '-------';
         substr $lines[1], 9*$idx+2, 7, '|     |';
         substr $lines[2], 9*$idx+2, 7, '|     |';
         substr $lines[3], 9*$idx+2, 7, '-------';
         substr $lines[4], 9*$idx+2, 7, '      |';
         substr $lines[5], 9*$idx+2, 7, '      |';
         substr $lines[6], 9*$idx+2, 7, '       ';
      }
   }
   say for @lines;
}

# SCRIPT BODY:
my $x = 200;
if (@ARGV) {$x=$ARGV[0]}
die if $x !~ m/^\d{1,9}$/;
display_row($x);
