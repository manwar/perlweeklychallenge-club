#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N (<= 10).
Write a script to print number of trailing zeroes in $N!.
Example 1
Input: $N = 10 Output: 2 as $N! = 3628800 has 2 trailing zeroes
Example 2 Input: $N = 7 Output: 1 as $N! = 5040 has 1 trailing zero
Example 3 Input: $N = 4 Output: 0 as $N! = 24 has 0 trailing zero
=cut




# Variant #1. A factorial number gets a trailing zero after 4*5 and 9*10.
use List::Util qw(max);

my %zeroes = (1 => 0, 5 => 1, 10 => 2);

sub find_zeroes_1
{
     my ($num, $hr) = @_;
     return exists $hr->{$num} ? $hr->{$num} : $hr->{max(grep $_ < $num, keys %$hr)};

}

for my $i ( 1 .. 10 )
{
     print join("->", $i, find_zeroes_1($i, \%zeroes)), $/;
}


# Variant 2. Calculate factorials for 1 .. 10 (or just save the results in a hash).
# I could use a factorial subroutine from "Mastering Perl" again :-)
my %factorials = (1 => 1, 2 => 2, 3 => 6, 4 => 24, 5 => 120,
6 => 720, 7 => 5040, 8 => 40320, 9 => 362880, 10 => 3628800);


sub find_zeroes_2
{
     my $num = $_[0];

     my $trailing_zeroes;
     if ( $num =~ /[^0]([0]+)$/ )
     {
          $trailing_zeroes = $1;
     }
     return length($trailing_zeroes) || 0;
}

for ( 1 .. 10 ) 
{ 
     print join('->', $_, find_zeroes_2($factorials{$_})), $/; 
}