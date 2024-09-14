=begin
Compute the number of ways to make change for given amount in cents. By using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many distinct ways can the total value equal to the given amount? Order of coin selection does not matter.

A penny (P) is equal to 1 cent.
A nickel (N) is equal to 5 cents.
A dime (D) is equal to 10 cents.
A quarter (Q) is equal to 25 cents.
A half-dollar (HD) is equal to 50 cents.
Example 1
Input: $amount = 9
Ouput: 2

1: 9P
2: N + 4P
Example 2
Input: $amount = 15
Ouput: 6

1: D + 5P
2: D + N
3: 3N
4: 2N + 5P
5: N + 10P
6: 15P
Example 3
Input: $amount = 100
Ouput: 292
=cut

use strict;
use Data::Dumper;

use Test::More tests => 3;

is(makeChange(9),2,'Test 1');
is(makeChange(15),6,'Test 2');
is(makeChange(100),292,'Test 3');


my @amount = (9,15,100);

foreach(@amount){
  my $_last_coin;
  my $combination = makeChange($_,$_last_coin);
  print "Number of Combinations for $_ is: $combination\n";
}

sub makeChange { 
  my ($reamaining,$last_coin) = @_;
  my $combinations = 0;
  my @denomination = (1,5,10,25,50);
  #print "$reamaining,$last_coin\n";
  foreach my $coin (@denomination){
    if($last_coin and $last_coin < $coin){
      #print "$last_coin < $coin next\n";
      last;
    }elsif($coin == $reamaining){
      $combinations += 1;
    }elsif($coin < $reamaining){
      $combinations += makeChange($reamaining-$coin,$coin);
    }
  }

  return $combinations;

}