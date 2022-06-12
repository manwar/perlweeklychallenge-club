#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @perrin = (3, 0, 2);
my %perrin_primes = (
    3 => 1,
    2 => 1
);
my $num = 13;

while(scalar(keys(%perrin_primes)) < $num){
    next_perrin(\@perrin, 1);
    $perrin_primes{$perrin[$#perrin]} = 1
        if(is_prime($perrin[$#perrin]));
}

print("\n");
printf(
    "f(%d) = [%s]\n",
    $num,
    join(", ", sort({ $a <=> $b } keys(%perrin_primes)))
);
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the next number in the Perrin sequence, adding it to an existing
# list of Perrin numbers; see https://en.wikipedia.org/wiki/Perrin_number for
# details about this type of number
# Takes one or two arguments:
# * A ref to a list of Perrin numbers; upon first call to this function, this
#   list must be [ 3, 0, 2 ]
# * An agument that, if defined, will cause the first member of the list to be
#   removed after the new one is added, preventing the list from growing
# Returns no meaningful value
################################################################################
sub next_perrin{
    my $perrin = shift();

    # Add the next number in the sequence
    push(
        @{$perrin},
        $perrin->[$#$perrin - 2] + $perrin->[$#$perrin - 1]
    );

    # If specified, toss out the oldest number
    shift(@{$perrin})
        if(defined(shift()));

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



