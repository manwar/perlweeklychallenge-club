#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a set of $n integers (n1, n2, n3, ….). Write a script to divide the set in two subsets of n/2 sizes each so that the difference of the sum of two subsets is the least. 
If $n is even then each subset must be of size $n/2 each. In case $n is odd then one subset must be ($n-1)/2 and other must be ($n+1)/2.

Example
Input:        Set = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
Output:  Subset 1 = (30, 40, 60, 70, 80)
         Subset 2 = (10, 20, 50, 90, 100)

Input:        Set = (10, -15, 20, 30, -25, 0, 5, 40, -5)
         Subset 1 = (30, 0, 5, -5)
         Subset 2 = (10, -15, 20, -25, 40)

=cut


use List::Util qw(sum max min);
use Algorithm::Combinatorics qw(combinations);
use List::MoreUtils qw(zip);

use ntheory qw(primes);

sub divide
{
     my @arr = @_;
     my @idx = 0 .. $#arr;

     my $difference = max(@arr);
     my $sum = sum(@arr); 

     my $count = scalar @idx; 
     my $even = $count % 2 ? 0 : 1;

     my $half = int($count/2);


     @arr = sort {$a <=> $b} @arr;
     my @h1 = @arr[0 .. $half - 1];
     my @h2 = @arr[reverse $half .. $#arr];

     @arr = grep defined $_ , zip(@h1, @h2);
     @h1 = @h2 = ();
     my $iter = combinations(\@idx, $half );
     my %output;

     my %seen; # for even sets only.

     while ( my $p = $iter->next )
     {
          next if ( $even == 1 and (exists $seen{join('',sort {$a <=> $b} @$p)}));
          my %choice;
          @choice{@$p} = undef; 
          my @idx_2 = grep {not exists $choice{$_}} @idx;

          if ( $even == 1 )
          {
               $seen{join('',sort {$a <=> $b} @idx_2)} = undef;
          }
          my @subset_1 = @arr[@$p];
          my @subset_2 = @arr[@idx_2];

          my $diff = abs( sum(@subset_1) - sum(@subset_2) );

          if ( $diff < $difference )
          {
               $difference = $diff;
               $output{1} = join(', ', @subset_1);
               $output{2} = join(', ', @subset_2);
          }
          if ( 0 == $difference ) {last;}
          if ( $sum % 2 and 1 == $difference ) {last; }

     }
     return "Subset 1: (", $output{1}, ")$/Subset 2: (", $output{2}, 
               ")$/Difference: ${difference}$/";
}

print divide(10, 20, 30, 40, 50, 60, 70, 80, 90, 100), $/;
print divide(10, -15, 20, 30, -25, 0, 5, 40, -5), $/;
print divide(1 .. 100), $/;

print divide(5, 10, 15, 20, 25), $/;
print divide(@{primes(1, 500)}), $/;
srand(15);
print divide(map { rand() > 0.5 ? $_ * -1 : $_; } @{primes(1, 500)}), $/;
print divide(1, -2, 3, -4, 5, -6, 7, -8, 9, -10), $/; 