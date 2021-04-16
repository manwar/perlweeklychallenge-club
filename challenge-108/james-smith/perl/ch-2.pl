#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $ANSWER_10 = '1 1 2 5 15 52 203 877 4140 21147';
my $ANSWER_20 = '1 1 2 5 15 52 203 877 4140 21147 115975 678570 4213597 27644437 190899322 1382958545 10480142147 82864869804 682076806159 5832742205057';

is( "@{ bell_numbers(10) }", $ANSWER_10 );
is( "@{ bell_numbers(20) }", $ANSWER_20 );

done_testing();

## Bell numbers can be computed by using a bell triangle.
## The bell numbers are the last cell of each row of the table.
##
## To get one row from the next.
##  * We copy the previous "bell number" the last cell in
##    the previous row.
##  * Each other element of the row is computed by adding the number
##    to the left of it in this row and the element about (and to the
##    left of it)
##
## The solution...
##
## * We will use 2 arrays to represent the previous row and
##   the current row of the table. @a & @b;
##   We initialise the first row to just contain the number 1   #1
##
## * And at each iteration we remember this last element.       #2
##
## * When we have enough elements in our results array we       #3
##   return. We don't need to do last and then return outside
##   the loop as we can just return from the subroutine from
##   inside the loop!
##
## * In each iteration we initialise the row to contain the
##   previous last value...                                     #1
##   and then loop through all the elements in the previous     #4
##   array accumulating the total - the ability to get the
##   value of the last element of the array with [-1] is
##   very useful perl feature here...
##
## * Finally we copy the new row into the previous row and      #5
##   continue around the loop....

sub bell_numbers {
  my $N = shift;
  my @res = my @a = 1;                 #1
  while(1) {
    push @res, my @b = $a[-1];         #2
    return \@res if @res >= $N;        #3
    push @b, $b[-1] + $_ foreach @a;   #4
    @a = @b;                           #5
  }
}


