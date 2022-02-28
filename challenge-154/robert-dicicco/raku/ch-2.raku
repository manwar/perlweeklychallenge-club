use v6;

# Author: Robert DiCicco
# Date: 28-FEB-2022
# Challenge #154 Padovan Prime ( Raku )

### Write a script to compute first 10 distinct Padovan Primes.

### Expected Output

### 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057

###

my @nums = (1,1,1);     ### starter for padovan sequence
my @out = ();           ### final output array
my $count = 10;         ### final output counter

while ($count >= 0 ) {
  my $len = @nums.elems;  ### get size of array
  my $padnum = @nums[$len-2] + @nums[$len-3];   ### calculate the Padovan number
  @nums.push($padnum);    ### and append it to the @nums array

  if $padnum.is-prime {   ### if the Padovan number is prime
    @out.push($padnum);   ### append it to our final output array
    $count--;
  }
}

### print the unique Padovan primes

@out.unique.say;
