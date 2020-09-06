#!/usr/bin/env perl6
# 
#
#       goldbach_variations.raku
#
#     TASK #1 › Prime Sum
#         Submitted by: Mohammad S Anwar
#         Reviewed by: Ryan Thompson
#         You are given a number $N. Write a script to find the minimum number
#         of prime numbers required, whose summation gives you $N.
# 
#         For the sake of this task, please assume 1 is not a prime number.
# 
#         Example:
#         Input:
#             $N = 9
# 
#         Ouput:
#             2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
#             2 + 7 = 9.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num where $num > 1 = 51) ;

## generate prime list and set
## NOTE: using a Set here is an excuse to use the Type and its operators more
##       than anything else. Checking individual elements for primeness using
##       .is-prime is a much better way of going about it. 
my @primes = (2..$num).grep: { .is-prime };
my $p = @primes.Set;

## descend through the cases, in increasing complexity
my $result = do given $num {
    when    @primes.tail    { $num.List }  
    when    $_ %% 2         { get_prime_pair($num) }
    when    $_ - 2 ∈ $p     { $num-2, 2 }       ## when ($_-2).is-prime {...} is better but less cool
    default                 { @primes.tail, |get_prime_pair($num - @primes.tail) }
};

## output
my $quan = $result.elems;
say "$quan\n\n$num can be summed from the $quan primes " ~ $result.join: ' + ';


multi get_prime_pair ($num, @primes) {
## calculates prime pairs that add to make number
## give it a prime list to avoid regenerating it
## NOTE: again checking for primeness directly is surely better but less fun, and
##       eliminates any need for a multi sub here as well. But multis are cool, too. 
    my $p = @primes.Set;
    my $i = @primes.end;
    while ($i > -1)  {
        return (@primes[$i], $num - @primes[$i]) if ($num - @primes[$i] ∈ $p);
        $i--;
    }
}

multi get_prime_pair ($num) {
## without a prime list it will make a new one
    my @p = (2..$num).grep: { .is-prime };
    get_prime_pair($num, @p);
}


