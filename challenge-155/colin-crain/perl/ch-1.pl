#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       fortunate-son.pl
#
#       Fortunate Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to produce first 8 Fortunate Numbers (unique and
#         sorted).
# 
#         According to Wikipedia
# 
#         A Fortunate number, named after Reo Fortune, is the smallest
#         integer m > 1 such that, for a given positive integer n, pn# + m
#         is a prime number, where the primorial pn# is the product of the
#         first n prime numbers.
# 
#         Expected Output
# 
#           3, 5, 7, 13, 17, 19, 23, 37
# 
#         analysis
# 
#             We recently had a discussion on the squarefree numbers, and
#             how they pop up unexpectedly all over topics in numbet
#             theory. I will take the time to notice that the product of
#             the first n prime numbers is the same as a prime degeneration
#             with a maximal amount of discrete factors, with no exponents.
#             So in other words we are talking about the largest squarefree
#             number that we can create from n number of factors.
# 
#             Sow how about that?
# 
#             To rephrase the description then, the fortunate numbers
#             correspond to a list of positive deltas required to make the
#             largest squarefree number with that many factors prime.
# 
#             So we need to produce a list of primes, and from that list of
#             cumulative products as we multiply in each successive term.
#             Then from each of these products we need to first add 3 to
#             make it odd and check for primality.
# 
#             Because the promorial will always be have 2 as a factor it
#             will always be even. We would make this odd by adding 1, but
#             1 is always excluded from the fortunate numbers so we
#             immediately jump to 3.
# 
#             Likewise for testing a number for primality we can skip the
#             calculation for 2, because we know we've made the candidate
#             odd already. So we can start at 3 and increment upwards by 2s
#             from there. We test repeatedly until we are prime.
# 
#             There's one last step though, which is to find 8 distinct
#             terms and sort them. We'll need to gather terms until we have
#             enough. As it's evident the list is not necessarily ordered,
#             this raises the possibility that somewhere along the line the
#             value 11 may arise, say at position 1142 or such. I don't see
#             that happening but at the moment I don't see any reason to
#             exclude the possiblity.
# 
#             What we will do though is assume it will not, and interpret
#             the directive as "the first 8 distinct terms, sorted", which
#             is slightly different and less absolute. We will collect
#             terms until we find 8 values and then dump the buffer. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my $pgen = prime_generator();
my @primes;
my $primorial = 1;              ## multiplicative identity
my %fortunate;

while ( keys %fortunate < 8 ) {
    push @primes, $pgen->();
    $primorial *= $primes[-1];

    ## loop through values for $f until a prime number is found
    my $f = 1;
    my $candidate;
    FORTUNATE: while ( $f += 2 ) {
        $candidate = $primorial + $f;
        my $sqrt_candidate = int sqrt( $candidate );
        for ( my $test = 3; $test <= $sqrt_candidate; $test += 2 ) {
            next FORTUNATE if $candidate % $test == 0;
        }
        $fortunate{$f}++;
        last FORTUNATE;
    }
}
    
say join ', ', sort {$a<=>$b} keys %fortunate;


sub prime_generator ( ) {
## returns an iterator closure that always delivers the next prime
    state @primes;
    
    return sub {
        if ( @primes < 2 ) {
            push @primes, @primes == 0 ? 2 : 3;
            return $primes[-1];
        }
    
        my $candidate = $primes[-1] ;
        CANDIDATE: while ( $candidate += 2 ) {
            my $sqrt_candidate = sqrt( $candidate );
            for my $test ( @primes ) {
                next CANDIDATE if $candidate % $test == 0;
                last if $test > $sqrt_candidate;
            }
            push @primes, $candidate;
            return $candidate;
        }
    }
}


__END__


2
6
30
210
2310
30030
510510
9699690
223092870
6469693230
200560490130
7420738134810
304250263527210
13082761331670030
614889782588491410
3, 5, 7, 13, 23, 17, 19, 23, 37, 61, 67, 61, 71, 47, 107
