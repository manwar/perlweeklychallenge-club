#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
A strobogrammatic number is a number that looks the same when looked at upside down.
You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.
Write a script to print all strobogrammatic numbers between the given two numbers.
Example
Input: $A = 50, $B = 100
Output: 69, 88, 96
=cut


my $cnt = 1;

my $start = shift || 50;
my $end = shift || 10**10; # 10**15;
my $number = $start;
while ( $number <= $end )
{
     if ( $number =~ /[23457]/ )
     {
          while ( $number =~ /[23457]/ )
          {

               my @num_array = split(//,$number);
               @num_array = map { 
                    my $digit = $_; 
                    if ( $digit =~ /[23457]/ ) 
                    {
                         $digit++; 
                    }; 
                    $digit; } 
                    @num_array;
               $number = join('', @num_array);
          }
     }


     elsif ( $number =~ /0$/ )
     {
          $number++;

     }
     else
     {
          print join(": ", $cnt++, $number), $/ if ( $number == make_sgn($number));

          $number++;
     }
}
# 4_995 numbers if $start == 50 and $end == 10**10.
sub make_sgn
{
     my $str = $_[0];
     $str = reverse $str;

     $str =~ tr/69/96/;
     return $str;
}