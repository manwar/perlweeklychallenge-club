#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my %padovan_primes;
my $n = 10;

while(scalar(keys(%padovan_primes)) < $n){
    my $padovan = next_padovan();

    $padovan_primes{$padovan} = 1
        if(!$padovan_primes{$padovan} && is_prime($padovan));
}

printf(
    "\nThe first %d Padovan primes are:\n    %s\n\n",
    $n,
    join(", ", sort({ $a <=> $b } keys(%padovan_primes)))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Calculate the next number in the Padovan sequence- starting with P(0) (or 1)
# when the function is first called.  There is no way to reset the sequence
# once it has begun.
# Takes no arguments.
# Returns:
# * The next number in the Padovan sequence, after the one returned in the
#   previous call to this function, if any; P(0), which has a value of 1, is
#   returned upon the first call to this function
################################################################################
sub next_padovan{
    use v5.10;

    state @sequence;
    state $calls = 0;

    unless(@sequence){
        # This only happens the first time this
        # function is called
        @sequence = (1, 1, 1);
    }

    if($calls < 3){
        $calls++;
        return(1);
    }
    
    # Calculate a new number in the sequence,
    # and delete an old one
    push(@sequence, $sequence[1] + $sequence[0]);
    shift(@sequence);

    return($sequence[2]);

}



################################################################################
# Determine whether a given integer N is prime
# Takes one argument:
# * The integer N
# Returns on success:
# * 1 if N is prime
# * 0 if N is not prime
# NOTE: If N is less than zero, it will always be considered nonprime
################################################################################
sub is_prime{
    my $n = int(shift());

    my $i;

    # Take care of a few easy cases
    return(1)
        if(($n == 2) || ($n == 3));
    return(0)
        if(($n <= 1) || !($n % 2) || !($n % 3));

    # See if certain factors divide evenly
    for($i = 5; $i * $i <= $n; $i += 6){
        if(!($n % $i) || !($n % ($i + 2))){
            return(0);
        }
    }

    return(1);

}



