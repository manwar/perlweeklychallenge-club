#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to display the first three self-descriptive numbers. As per wikipedia, the definition of Self-descriptive Number is: "In mathematics, a self-descriptive number is an integer m that in a given base b is b digits long in which each digit d at position n (the most significant digit being at position 0 and the least significant at position b−1) counts how many instances of digit n are in m".
Output 1210, 2020, 21200
=cut






=comment
In the challenge-043 I hardcoded the smallest numbers, now they are searched for.
After 1e9 the search would be very slow without further optimization concerning the first three digits.
However with the properties of the first three digits we can simply construct the numbers (as in challenge-043, also using letters in numbers of base > 10).
=cut


use List::Util qw(first sum reduce);

my $i = 1000;
NUM: while ($i < 1e9)
{

     if ( $i % 10 ) 
     { 
          $i = (1 + int($i/10)) * 10; 
     }
     my $length = length($i);
     $length == 6 and $i = 1_000_000 and next NUM;
     if ( $length > 5 and $i % 1000 ) 
     { 
          $i = (1 + int($i/1000)) * 1000; 
     }
     my @num_arr = split(//, $i);


     while ( defined first { $_ >= $length  } @num_arr )
     {
          for my $idx ( reverse 1 .. $#num_arr )
          {
               if ( $num_arr[$idx] >= $length )
               {
                    $num_arr[$idx] = 0;
                    $num_arr[$idx-1]++;

               }
          }

          if ( $num_arr[0] >= $length )
          {
               $_ = 0 for @num_arr;
               unshift @num_arr, 1;
          }

          $i = join('', @num_arr);
     }

     if (sum(@num_arr) > $length)
     {
          $i++;
          next NUM;
     }

     my $descr = description(@num_arr);
     print $descr, $/ if $descr == $i;
     $i++;
}

sub description
{
     my @num_arr = @_;

     my %freq;
     $freq{$_}++ for @num_arr;
     for my $i ( 0 .. $#num_arr )
     {
          if ( not exists $freq{$i} )
          {
               $freq{$i} = 0;
          }

     }
     my $description = reduce { $a . $b } 
          map { $freq{$_} }
          sort {$a <=> $b} keys %freq;

     return $description;
}