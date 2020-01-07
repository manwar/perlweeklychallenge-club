use v6;

#       PWC 41
#       TASK #1
#           Write a script to display attractive number between 1 and 50. A
#           number is an attractive number if the number of its prime factors is
#           also prime number.
#
#           The number 20 is an attractive number, whose prime factors are 2, 2
#           and 5. The total prime factors is 3 which is also a prime number.
#
#       notice: first sexy primes, now attractive numbers. So many numbers,
#           so many looks. I am a little concerned that all this objectifying
#           might give certain less-confident numbers quantity quality issues.
#           Let's not forget the truism that "all numbers are interesting"; whether
#           amicable, betrothed, deficiant or slightly defective they are all
#           Pythagorus' children and deserve love.
#
#           So anyways, we will pull out our prime decomposition engine from PWC23,
#           which we also saw in challenges 29 and 34.
#
#           Unable to leave well enough alone, we've tuned and tightened it,
#           replacing the origianal prime generating subfunction with a list of
#           all primes less or equal to the upper bound, which have been made a
#           user defined variable with a default of 50, and a lower bound of 2,
#           the smallest prime number.
#
#           We need to know the prime decomposition, but only briefly enough to
#           sum it and compare this to our prime list. As we have the prime list
#           already present in the function we could do the comparison then and
#           there, return true or false, grep the list of calling it from 1 to
#           50 and call it a day. But merely presenting the numbers without
#           demonstrating their attractiveness seemed a bit off the mark, like
#           talking about a fashion show on the radio instead of going to a
#           fashion show to see the runway. So a table is produced of all the
#           numbers, their decompositions, and finally judgement on their
#           attractiveness. It appears the group of numbers between 1 and 50,
#           taken as a whole are a pretty good-looking bunch.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN ( Int:D $max where {$max > 2} = 50 ) {

    my @primes   = make_prime_list($max);
    my $primeset = Set.new(@primes);

    for (2..$max) {
        my @decomp = decompose($_, @primes);
        printf "%-5d --> %-20s     %s\n", $_, (@decomp.join: ', '), (@decomp.elems ∈ $primeset) ?? "$_ is attractive" !! "";
    }
}


## ## ## ## ## SUBS

sub make_prime_list ( Int:D $max where {$max > 2} = 50 ) {
## creates a list of all primes less than or equal to a given number
    my @output = [2];
    CANDIDATE: loop (  my $candidate = 3;  $candidate <= $max;  $candidate += 2  ) {
        my $sqrt_candidate = $candidate.sqrt;
        loop (  my $test = 3; $test <= $sqrt_candidate; $test += 2  ) {
            next CANDIDATE if $candidate % $test == 0;
        }
        @output.push: $candidate;
    }
    return @output;
}


sub decompose ( $extnum, @primes) {
## given a number and a list of primes less than n/2,
## returns an array list of prime decomposition factors of the number
    my @decomp;
    my $num = $extnum;
    my @primelist = @primes;
    my $prime = shift @primelist;

    while ( $prime <= $num ) {
        while ($num %% $prime) {
            $num /= $prime;
            @decomp.push: $prime;
        }
        last unless @primelist.elems;
        $prime =  @primelist.shift;
    }
    return @decomp;
}
