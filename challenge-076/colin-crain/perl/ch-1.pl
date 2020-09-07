#! /opt/local/bin/perl
#
#       goldbach_variations.pl
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
#     method:
#         we'll need all the prime numbers up to the input, because we'll start
#         at the top. Look at highest lower prime, subtract and se if remainder
#         is prime, which is easy as we'll have the values. Continue until 1/2
#         way. Then assume smaller numbers will have fewer prime sums, so
#         largest prime and try and make 2-sums with smaller part. What's the
#         largest value, mathematically?
# 
# 
# 
# 
# 
#     
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use DDP;

## ## ## ## ## MAIN:

my $num = shift @ARGV // 57;
my ($primes, $lookup, $result);

$primes = make_prime_list($num);
$lookup = { map { $_ => 1 } $primes->@* };

## descend through the cases, in increasing complexity
if ($num == $primes->[-1]) {
    $result = [$num];
}
elsif ($num % 2 == 0 ) {
    $result = get_prime_pair($num, $primes, $lookup);
}
elsif (exists $lookup->{ $num-2 }) {
        $result = [$num-2, 2];
}
else {
    my $diff = $num - @{$primes}[-1];
    $result = [ $primes->[-1], get_prime_pair($diff)->@* ];
}

say "$num = ( ", (join ' + ', @$result), " )";


## ## ## ## ## SUBS:

sub make_prime_list {
## creates a list of all primes less than or equal to a given number
    my $max = shift;
    my @output = (2);
    CANDIDATE: for(  my $candidate = 3;  $candidate <= $max;  $candidate += 2  ) {
        my $sqrt_candidate = sqrt( $candidate );
        for(  my $test = 3; $test <= $sqrt_candidate; $test += 2  ) {
            next CANDIDATE if $candidate % $test == 0;
        }
        push @output, $candidate;
    }
    return \@output;
}

sub get_prime_pair {
## given an even number returns two primes that sum to it
## if $primes and $lookup are absent, makes new ones for $num
    my ( $num, $primes, $lookup ) = @_;
    if (not defined $primes) {
        $primes = make_prime_list($num);
        $lookup = { map { $_ => 1 } $primes->@* };
    };
   
    my $i = @$primes;
    while (--$i >= 0) {
        my $diff = $num - $primes->[$i];
        if ( exists $lookup->{ $diff } ) {
            return [$primes->[$i], $diff];
            last;
        }
    }
    return undef;
}