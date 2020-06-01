#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Given a word made up of an arbitrary number of x and y characters, that word can be rotated as follows: For the ith rotation (starting at i = 1), i % length(word) characters are moved from the front of the string to the end. Thus, for the string xyxx, the initial (i = 1) % 4 = 1 character (x) is moved to the end, forming yxxx. On the second rotation, (i = 2) % 4 = 2 characters (yx) are moved to the end, forming xxyx, and so on. See below for a complete example.
Your task is to write a function that takes a string of xs and ys and returns the maximum non-zero number of rotations required to obtain the original string. You may show the individual rotations if you wish, but that is not required.
=cut








for my $string ( qw (xyxx xy xxyyyyy xxxyyyyy xyxyxx xxxxxxxy xyyyyyyy) )
{
     my $num = rotate($string);
     print $num, $/, $/;
}

sub rotate
{
     my $str = $_[0];

     my $orig = $str;
     my $len = length($str);
     my $n = 0;
     do
     {
          $n++;
          $str = substr($str, $n % $len) . substr($str, 0, $n % $len); 
          print "DEBUG: ${n}: ${str}$/";
     } 
     while ($str ne $orig);
     return $n;
}