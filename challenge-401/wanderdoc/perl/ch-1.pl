#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string representing an expression of fraction addition and substraction.

Write a script that returns the calculation result of given expression in string format. If final result is an integer, change it to the format of fraction that has a denominator 1.
Example 1

Input: $expr = "1/2+3/2"
Output: "2/1"

1/2 + 3/2 => 4/2 => 2

As specified by the rules, an integer result must be represented as a fraction with denominator 1, yielding "2/1".

Example 2

Input: $expr = "-5/2-3/2"
Output: "-4/1"

-5/2 - 3/2 => -8/2 => -4 => "-4/1".

Example 3

Input: $expr = "5/3-5/3"
Output: "0/1"

5/3 - 5/3 => 0/3
Zero divided by any valid non-zero denominator reduces to "0/1".

Example 4

Input: $expr = "10/10-1/10+2/5"
Output: "13/10"

10/10 - 1/10 + 2/5 => 9/10 + 4/10 => 13/10.
13/10 is already irreducible, so the output is "13/10".

Example 5

Input: $expr = "1/6+1/6+1/6"
Output: "1/2"

1/6 + 1/6 + 1/6 => 3/6 => 1/2

=cut

use List::Util qw(reduce);
use Test2::V0 -no_srand => 1;

is(fractional_math("1/2+3/2"), "2/1", "Example 1");
is(fractional_math("-5/2-3/2"), "-4/1", "Example 2");
is(fractional_math("5/3-5/3"), "0/1", "Example 3");
is(fractional_math("10/10-1/10+2/5"), "13/10", "Example 4");
is(fractional_math("1/6+1/6+1/6"), "1/2", "Example 5");
done_testing();


sub fractional_math
{
     my $str = $_[0];
     $str =~ tr/ //ds; # just in case.

     my @expr = split(/([-+])/, $str);
     my ( @fractions, @operations);
     for my $elm ( @expr )
     {
          next unless length($elm);
          if ( $elm =~ /[-+]/ )
          {
               push @operations, $elm;
          }
          else
          {
               my %hash;
               @hash{qw( num denom )} = 
                    $elm =~ /(\d+)\/(\d+)/;
               push @fractions, \%hash;
          }
     }

     if ( $str =~ /^\-/ ) # first number negative
     {
          $fractions[0]->{num} *= -1;
          shift @operations; # remove this '-'
     }
     
     my $lcm = 
          reduce { lcm($a, $b) }
          map { $_->{denom} }
          @fractions;

     for my $elm ( @fractions )
     {
          $elm->{num} *= $lcm / $elm->{denom};
          $elm->{denom} = $lcm;
     }
     
     my @numerators = map { $_->{num} } @fractions;
     my $result_num = shift @numerators;
     for my $idx ( 0 .. $#operations )
     {
          $result_num .= $operations[$idx];
          $result_num .= $numerators[$idx];
     }
     $result_num = eval $result_num;
     my $result_gcd = gcd($result_num, $lcm);
     $result_num /= $result_gcd;
     my $result_denom = $lcm / $result_gcd;
     return join("/", $result_num, $result_denom);
}


sub gcd # greatest common denominator
{
     my ($x, $y) = @_;
     $x = abs($x);
     $y = abs($y);

     while ($y != 0) 
     {
          ($x, $y) = ($y, $x % $y);
     }
    
     return $x;
}

sub lcm # least common multiple 
{
     my ($x, $y) = @_;
     return 0 if ($x == 0 or $y == 0);
     return abs($x * $y) / gcd($x, $y);
}
