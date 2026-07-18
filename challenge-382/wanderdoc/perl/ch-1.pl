#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a target number.

Write a script to arrange all the whole numbers from 1 up to the given target number into a circle so that every pair of side-by-side numbers adds up to a perfect square. Please make sure, the last number and the first must also add up to a square.
Example 1

Input: $n = 32
Output: 1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15

1  + 8  = 9
8  + 28 = 36
28 + 21 = 49
21 + 4  = 25
4  + 32 = 36
32 + 17 = 49
17 + 19 = 36
19 + 30 = 49

so on, all the way through the sequence.

Example 2

Input: $n = 15
Output: ()

No valid circular list of numbers exists.

Example 3

Input: $n = 34
Output: 1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2, 14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3

=cut





my $n = $ARGV[0]  or die '$n is not defined!'; 
my @arr = 1 .. $n;
# Precalculate squares:
my %squares;
my $max = $n * 3;
my $sq = 2;

while ( $sq <= int(sqrt($max)) )
{
     $squares{ $sq * $sq } = undef;
     $sq++;
}

my $start_idx = 0;
my @path;

my %used;
my %output;

my $start = $arr[0];
push @path, $start;
$used{$start} = 1;

hamiltonian_path(0);

my $counter = 1;
for my $this_path ( keys %output )
{
     print "[Path ${counter}]: $this_path$/";
     $counter++;
}

print "No valid circular list of numbers exists." unless scalar keys %output;

sub hamiltonian_path
{
     my $pos = $_[0];
     if ( $pos == $n - 1 
          and exists $squares{ $path[0] + $path[-1] } 
          )
     {
          $output{ join(', ', @path) } = undef; 

          return; # ! (all solutions)
     }
     else
     {
          my $prev = $path[-1];
          for my $elm ( @arr )
          {
               next if $used{$elm};
               if (exists $squares{$prev + $elm}) 
               {
                    push @path, $elm;
                    $used{$elm} = 1;
                    if ( hamiltonian_path($pos + 1 ) )
                    {
                         return 1;
                    }
                    delete $used{$elm};
                    pop @path;
               }
          }
     }
     return 0;
}
