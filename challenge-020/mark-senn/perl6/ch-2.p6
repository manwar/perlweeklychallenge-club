#
# Perl  Weekly  Challenge  - 020
# Task #2
#
# See
#      engineering.purdue.edu/~mark/pwc -020 -2. pdf
# for  more  information.8

# Run  using  Perl v6.d.
use v6.d;

# Set  @sum[$i] to the sum of the  proper  divisors  of $i.
my int  @sum;

for 2 .. * ->$i {

    # The  proper  divisors  of a prime  is a set  consisting  only of 1.
    # All  primes  can be  skipped.
    ($i.is-prime)   and   next;

    # Compute  the sum of the  proper  divisors  of$i.
    my $sum = 1;
    # The  largest  proper  divisor  of$i is ($i/2). floor.
    for 2 .. ($i/2). Int  ->$j   {
        ($i %%$j)   and $sum +=$j;
    }

    # Remember  the sum of the  proper  divisors  of $i.
    @sum[$i] =$sum;

    # If$sum > $i , @sum[$sum] has  not  been  computed  yet  and
    # can't be used  for  comparision.
    # If $sum == $i the  pair of  numbers  would  be ($i ,$i),
    # a pair  using  two  different  numbers  is  needed.
    # In  either  case we can  skip  the  rest of the  loop.
    ($sum  >=$i)   and   next;

    if (@sum[$sum] ==$i)   {
        say "$sum $i";
        last;
    }
}
