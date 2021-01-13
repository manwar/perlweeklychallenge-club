#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two integers $m and $n. Write a script print all possible combinations of $n numbers from the list 1 2 3 ... $m. Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is not.
Example

Input: $m = 5, $n = 2

Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
=cut




use Algorithm::Combinatorics qw(combinations);


my $m = shift // 5;
my $n = shift // 2;
die "Two positive integers, m and n, where m > n!$/" unless 
($m =~ /^[0-9]+$/ and $n =~ /^[0-9]+$/ and $n > 0 and $m > $n);



my @memoize; # For the factorial function (s. below).
# This, in turn, only to mimic the output with commas.
$memoize[1] = 1;
my $num_com = factorial($m) /( factorial($n) * factorial($m - $n ) );
my $iter = combinations([1 .. $m], $n);
my $counter;
while (my $c = $iter->next) 
{
    print "[", join(",", @$c), "]";
    $counter++;
    print ", " if $counter < $num_com;
}


sub factorial # From "Mastering Perl".
{
     my $num = $_[0]; 

     return $memoize[$num] if $memoize[$num];
     for ( @memoize .. $num )
     {
          $memoize[$_] = $memoize[$_ - 1] * $_;

     }
     return $memoize[$num];
}