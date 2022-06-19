#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 20;

print("\n");
print(join(", ", calculate_achilles_numbers($n)), "\n");
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate a specified quantity of the first Achilles numbers- that is to say,
# numbers that are powerful but not perfect; see
# https://en.wikipedia.org/wiki/Achilles_number for information about this type
# of number
# Takes one argument:
# * The number, N, of Achilles numbers to calculate
# Returns:
# * A list of N Achilles numbers
################################################################################
sub calculate_achilles_numbers{
    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my $a = 1;
    my @styx;

    # Loop until there are enough Achilles
    # numbers in the Styx
    while(scalar(@styx) < $n){
        my %factor_table = ();

        $a++;

        # Get a table of prime factors and their
        # exponents (powers)
        prime_factorize_as_table($a, \%factor_table);

        # Skip $a if any of the powers of its prime
        # factors are less than two (2), which would
        # mean it isn't a powerful number
        next
            unless(
                eval{
                    my $x = 1;

                    foreach(keys(%factor_table)){
                        if($factor_table{$_} < 2){
                            $x = 0;
                            last;
                        }
                    }
                    $x;
                }
            );

        # Skip $a if the greatest common divisor
        # among the powers of its prime factors is
        # greater than one (1), which would mean it's
        # a perfect power
        next
            if(
                gcd_list(
                    map($factor_table{$_}, keys(%factor_table))
                ) > 1
            );

        # $a is an Achilles number; push it into the
        # Styx
        push(@styx, $a);
    }

    return(@styx);

}



################################################################################
# Find the greatest common divisor (GCD) among a list of positive integers
# Takes one argument:
# * The list of integers to examine
# Returns on success:
# * The GCD of all the integers in the list
# Returns on error:
# * undef if any of the integers provided were less than 1
################################################################################
sub gcd_list{

    my $gcd = $ARG[0];

    for my $i (1 .. $#ARG){
        $gcd = gcd($gcd, $ARG[$i]);

        # In case gcd() hit an error...
        return(undef)
            unless(defined($gcd));
    }

    return($gcd);

}



################################################################################
# Calculate the greatest common divisor (GCD) of a pair of positive integers
# Takes two arguments:
# * The pair of integers to examine
# Returns on success:
# * The GCD of the integers provided
# Returns on error:
# * undef if either of the integers provided was less than 1
################################################################################
sub gcd{
    my $a = int(shift());
    my $b = int(shift());

    return(undef)
        if(($a < 1) || ($b < 1));

    while($b){
        my $c = $b;

        $b = $a % $b;
        $a = $c;
    }

    return($a);

}



################################################################################
# Find the prime factorization of a given integer, in table form
# Takes two arguments:
# * The integer N to examine and factor (e.g. 50)
# * A ref to a hash that will be populated with prime factors and their
#   exponents (e.g. { 2 => 1, 5 => 2 } ); any previous contents will be deleted
# Returns no meaningful value
################################################################################
sub prime_factorize_as_table{
    my $n = int(shift());
    my $factor_table = shift();

    my @factors;

    # Clobber existing table contents if any
    %{$factor_table} = ();

    # Calculate the factors
    prime_factorize($n, \@factors);

    # Count the power of each factor
    foreach(@factors){
        if($factor_table->{$_}){
            $factor_table->{$_}++;
        } else{
            $factor_table->{$_} = 1;
        }
    }

}



################################################################################
# Find the prime factorization of a given integer
# Takes two arguments:
# * The integer N to examine and factor (e.g. 50)
# * A ref to a list that will be populated with prime factors in ascending
#   order (e.g. [ 2, 5, 5 ] ); any previous contents will be deleted
# Returns no meaningful value
################################################################################
sub prime_factorize{
    use POSIX;

    my $n = int(shift());
    my $factors = shift();

    # Clobber existing list contents if any
    @{$factors} = ();

    # Loop until $n is prime
    until(is_prime($n)){
        # $n is not prime; set an upper bound on
        # our factor search
        my $i;
        my $max = ceil(sqrt($n));

        # Loop until we find prime $i that
        # divides evenly into $n
        for($i=2; $i<=$max; $i++){
            next unless(is_prime($i));
            last unless($n % $i);
        }

        # Store the new prime factor $i and
        # divide $n by it
        push(@{$factors}, $i);
        $n /= $i;

    }

    # Store $n, which by now is the last prime
    # factor of the originally-supplied argument
    push(@{$factors}, $n);

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



