#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 500;
my @square_frees = find_square_free_integers($n);

printf("\nThe smallest positive square-free integers <= %d are:\n", $n);
output_data_table(\*STDOUT, ceil(log($n)/log(10)), 80, \@square_frees);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine which integers, up to a specified value, have no squares in their
# factorization (that is to say, no numbers are repeated in their prime
# factorization)
# Takes one argument:
# * An integer N; all numbers from one to N, inclusive, will be examined
# Returns on success:
# * A list of integers from 1 to N, inclusive, that have no squares in their
#   factorization
# Returns on error:
# * undef if N <= 0
################################################################################
sub find_square_free_integers{
    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my $primes = sieve_of_eratosthenes($n, 1);
    my %factors;

    # Cheat (a little) and pre-load the list
    # with 1 so we don't have to check it
    my @square_frees = (1);
    my $i;

    for($i=2; $i<=$n; $i++){
        # Clear the factor table for each
        # iteration
        %factors = ();

        # If this number seems to have no square
        # factors, store it
        if(_prime_factorize_number($i, $primes, \%factors)){
            push(@square_frees, $i);
        }
    }

    return(@square_frees);

}



################################################################################
# Find the prime factorization of a number via a recursive method
# Takes three arguments:
# * The number N to examine and factor
# * A ref to a string that acts as a table of prime numbers; see the
#   documentation for sieve_of_eratosthenes() for details
# * A ref to a hashtable that will be used to keep track of factors previously
#   seen; this must be empty upon the call to this function, but after it
#   returns, if the number had no squares in its factorization (see below) the
#   keys from this hash will make up the number's prime factorization 
# Returns:
# * 0 if a square was found during prime factorization
# * 1 if no square was found during prime factorization
# NOTE: This function should ONLY be called by find_square_free_integers()
################################################################################
sub _prime_factorize_number{
    use POSIX;

    my $n = shift();
    my $primes = shift();
    my $factors = shift();

    my $i;
    my $max;

    if(substr($$primes, $n, 1)){
        # $n is prime
        if($factors->{$n}){
            # $n is a factor we've seen before
            return(0);
        } else{
            # $n is not a factor we've seen before
            $factors->{$n} = 1;
            return(1);
        }
    }

    # $n is not prime; set an upper bound on
    # our factor search
    $max = ceil(sqrt($n));

    # Loop until we find prime $i that
    # divides evenly into $n
    for($i=2; $i<=$max; $i++){
        next unless(substr($$primes, $i, 1));
        last unless($n % $i);
    }

    if($factors->{$i}){
        # $i is a factor we've seen before
        return(0);
    } else{
        # $i is not a factor we've seen before
        $factors->{$i} = 1;
        return(
            _prime_factorize_number(
                $n / $i,
                $primes,
                $factors
            )
        );
    }

}



################################################################################
# Write the values stored in an array to a specified filehandle, in the form of
# a set of rows organized into aligned columns (e.g.
#     An array ref (see below) of:
#     [ 1 2 3 4 5 6 7 ]
#
#     might yield an output of:
#     1 2 3 4 5
#     6 7
#
#     with the right parameters
# ).  The formating is automatic based on the parameters supplied in the
# arguments; the individual members of the array should already be formatted
# for printing. 
# Takes four arguments:
# * The filehandle to which the table should be written
# * The length, in characters, of the longest item in the array
# * The maximum width of the output desired; data will be offset at least four
#   characters from each end of the output line
# * A ref to the array that contains the data to output
# Returns no meaningful value
################################################################################
sub output_data_table{
    use POSIX;

    my $filehandle = shift();
    my $item_width = int(shift());
    my $max_width = int(shift());
    my $data = shift();

    my $row_entries = floor(($max_width - 8) / ($item_width + 2));
    my $format =
        "    "
        .
        join(
            "  ",
            map("%".$item_width."s", 1 .. $row_entries)
        )
        .
        "\n";
    my $row_start = 0;
    my $pad_length = $row_entries - scalar(@{$data}) % $row_entries;

    # If the data set fits evenly into the
    # columns we have, no padding will be
    # necessary at the end...
    $pad_length = 0
        unless($row_entries - $pad_length);

    # Loop while there are still data to
    # output
    print("\n");
    while($row_start < $#$data){
        my $row_end = $row_start + ($row_entries - 1);

        # If the end of the row is past the end
        # of the data, trim it back
        if($row_end > $#$data){
            $row_end = $#$data;
        }

        # Output a row; padding will be added
        # for the last row if it's not the full
        # length
        printf(
            $filehandle
            $format,
            @{$data}[$row_start .. $row_end],
            $row_end == $#$data ? map(" ", 1 .. $pad_length) : ()
        );

        $row_start += $row_entries;
    }
    print("\n");

}



################################################################################
# Use the Sieve of Eratosthenes to find a quantity of prime numbers
# Takes one required argument and one optional argument:
# * A positive integer N (e.g. 20)
# * An optional value that, if present and evaluates as true, will instruct
#   this function to return a stringified table of prime and non-prime values
#   (see below)
# Returns on success:
# * A list of all prime numbers less than or equal to N (e.g. (2, 3, 5, 7, 11,
#   13, 17, 19)) if the second argument is missing or false
# -- OR --
# * A ref to a string of ones and zeros representing a table of prime and
#   non-prime numbers, respectively, from 0 to N, inclusive (e.g.
#   $$ref == "001101010001010001010") if the second argument is present and
#   true; this is used internally for sieving primes, and it may be of use to
#   the caller if N is large, as it will take up far less memory than an array
#   of the actual values
# Returns on error:
# * undef if N is not a positive integer
################################################################################
sub sieve_of_eratosthenes{
    use POSIX;

    my $n = int(shift());
    my $return_table = shift();

    return(undef)
        unless($n > 0);

    my $max = floor(sqrt($n));
    my $i;
    my $j;
    my $k;
    my $table;
    my @primes;

    # Initialize the table to contain
    # (mostly...) true values
    $table = "00" . "1" x ($n - 1);

    # Loop over $i not exceeding the square
    # root of $n
    for($i = 2; $i <= $max; $i++){
        # If the $i'th cell is true, we haven't
        # examined the multiples of $i yet
        if(substr($table, $i, 1) eq "1"){
            $k = 0;
            # Assignment in expression is deliberate
            while(($j = $i ** 2 + $k++ * $i) <= $n){
                # $j is not prime; set its cell in the
                # table to false
                substr($table, $j, 1) = "0";
            }
        }
    }

    if($return_table){
        # Hand a ref to the completed table
        # back to the caller
        return(\$table);

    } else{
        # Build a list of indices for which
        # the corresponding members of the
        # table are true
        for($i = 2; $i <= $n; $i++){
            push(@primes, $i)
                if(substr($table, $i, 1) eq "1");
        }

        return(@primes);

    }

}



