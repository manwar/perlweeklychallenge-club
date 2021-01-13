#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Given an array @L of integers. Write a script to find all unique triplets such that a + b + c is same as the given target T. Also make sure a <= b <= c.
Example: @L = (-25, -10, -7, -3, 2, 4, 8, 10);
One such triplet for target 0 i.e. -10 + 2 + 8 = 0.
=cut




my @L = (-25, -10, -7, -3, 2, 4, 8, 10);
my $target = 0;

my @triplets = find_triplets(\@L, $target);
print_result(@triplets);


sub find_triplets
{
     my @arr = sort { $a <=> $b } @{$_[0]};
     my $t = $_[1];
     my @result;

     for my $pt1 ( 0 .. $#arr )
     {
          next if $pt1 > 0 and $arr[$pt1] == $arr[$pt1 - 1];
          my $pt2 = $pt1 + 1;
          my $pt3 = $#arr;
          while ( $pt2 < $pt3 )
          {
               if ( $arr[$pt1] + $arr[$pt2] + $arr[$pt3] == $t )
               {
                    push @result, [$arr[$pt1], $arr[$pt2], $arr[$pt3]];
                    $pt2++; 
               }


               elsif ( $arr[$pt1] + $arr[$pt2] + $arr[$pt3] < $t )
               {
                    $pt2++;
               }
               else
               {
                    $pt3--;
               }

          }
     }
     return @result;
}

sub print_result
{
     my @arr = @_;

     if ( 0 == @arr )
     {
          print "No elements!\n";
     }

     else
     {
          print join(" ", @$_), $/ for @arr;

     }
}