#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Any array N of non-unique, unsorted integers can be arranged into a wave-like array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.
For example, given the array [1, 2, 3, 4], possible wave arrays include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 ≥ 1 ≤ 4 ≥ 3 and 4 ≥ 1 ≤ 3 ≥ 2. This is not a complete list.
Write a script to print all possible wave arrays for an integer array N of arbitrary length.
When considering N of any length, note that the first element is always greater than or equal to the second, and then the ≤, ≥, ≤, … sequence alternates until the end of the array.
=cut




my $counter = 1;

sub find_waved # Permutation code: BrowserUk.
{
     my ($aref, $result) = ( @_, [] );
     return unless is_waved($result);
     print $counter++, ': ', join (" ", @$result), $/ unless @$aref;
     for my $i (0 .. $#$aref)
     {
          find_waved( [ @{ $aref }[ 0 .. $i - 1, $i + 1 .. $#$aref ] ],
                   [ @$result, $aref->[ $i ] ]); 

     }
}

find_waved( [1..6] );

sub is_waved
{
     my $aref = $_[0];
     my $max_idx = $#$aref;

     for (my $i= 0; $i <= ($max_idx - 1); $i++ )
     {


          if ( 0 == $i % 2 and $aref->[$i] < $aref->[$i+1] )
          {
               return 0;
          }
          elsif ( 1 == $i % 2 and $aref->[$i] > $aref->[$i+1])
          {
               return 0;
          }

     }
     return 1;
}