#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given three array of integers. Write a script to return all the elements that are present in at least 2 out of 3 given arrays.

Example 1
Input: @array1 = (1, 1, 2, 4)
       @array2 = (2, 4)
       @array3 = (4)
Ouput: (2, 4)

Example 2

Input: @array1 = (4, 1)
       @array2 = (2, 4)
       @array3 = (1, 2)
Ouput: (1, 2, 4)

=cut

use Test2::V0;

sub are_in_at_least_n
{
     my $n = shift ; # $_[0];
     my @aoa = @_;
     my %count;
     for my $aref ( @aoa )
     {
          my ($ref_nr) = $aref . '';

          for my $elm ( @$aref )
          {
               $count{$elm}{$ref_nr} = undef;
          }
     }


     my @output = sort { $a <=> $b }
          grep { scalar keys %{$count{$_}} >= $n } keys %count;
     return @output;
}

is([are_in_at_least_n(2, [1, 1, 2, 4], [2, 4], [4])], [2, 4], 'Example 1');
is([are_in_at_least_n(2, [4, 1], [2, 4], [1, 2])], [1, 2, 4], 'Example 2');
is([are_in_at_least_n(3, [1 .. 9], [7 .. 20], [5 .. 10], [18 .. 25], [17 .. 19])], [7, 8, 9, 18, 19], 'Example 3');


done_testing();