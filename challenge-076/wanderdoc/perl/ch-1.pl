#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a number $N. Write a script to find the minimum number of prime numbers required, whose summation gives you $N. For the sake of this task, please assume 1 is not a prime number.
Example: Input: $N = 9. Output: 2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number. 2 + 7 = 9.

=cut







use ntheory qw(primes);


my %primes;
my $sorted_primes = primes(1000);
@primes{@{$sorted_primes}} = undef;

for my $NUM ( 5 .. 1_000 )
{

     if ( $NUM % 2 == 0 )
     {
          my ($first, $second) = check_even($NUM);
          print "${NUM} = ${first} + ${second}$/" unless $first == 0;
          print "Something went wrong, probably too big number.$/" if $first == 0;
     }
     else
     {
          my @answer = sort {$a<=>$b} check_odd($NUM);
          print "${NUM} = ", join(' + ', @answer), $/ unless $answer[0] == 0;
          print "Something went wrong, probably too big number.$/" if $answer[0] == 0;
     }


}



# Algorithm: https://stackoverflow.com/questions/35755825
sub check_even
{
     my $num = $_[0];

     for my $prim ( @{$sorted_primes} )
     {
          if ( exists $primes{$num - $prim} )
          {

               return ($prim, $num - $prim);
          }
     }

     return (0, 0);
}

sub check_odd
{
     my $num = $_[0];
     if ( exists $primes{$num - 2} )
     {

          return ($num - 2, 2);
     }
     else
     {
          my ($first, $second) = check_even($num - 3);
          if ( exists $primes{$first} )
          {
               return ($first, $second, 3);

          }
          else
          {
               return (0, 0, 0);
          }
     }
}