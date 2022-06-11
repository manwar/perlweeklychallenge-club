#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Pernicious Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to permute first 10 Pernicious Numbers.
# 
#         A pernicious number is a positive integer which has prime number
#         of ones in its binary representation.
# 
#         The first pernicious number is 3 since binary representation of 3
#         = (11) and 1 + 1 = 2, which is a prime.
# 
#         Expected Output
#         3, 5, 6, 7, 9, 10, 11, 12, 13, 14
# 
#         Analysis
# 
#             Pernicious numbers are a product of the dark side of number
#             theory, or as I call it, dark number theory. And yes that is
#             a totally real thing I didn't just make up.
# 
#             In dark number theory half the numbers are plain evil. And
#             the numbers that are not evil are mearly odious. Numbers are
#             wicked, and in groups — angry mobs set in action, descending
#             on the castle — they can be monsterous. 
# 
#             The evil numbers have an even popcount, or binary Hamming
#             index, the odious the complementary odd fraction, and
#             therefore all positive numbers are either evil or odious. The
#             pernicious numbers have a prime Hamming weight, which makes
#             pernicious numbers to be generally, but not exclusively
#             odious, although some can still be said to be outright evil.
# 
#             The relative distribution between evil and odiousness in
#             numbers is quantified by their perfidy. 

#             Some numbers, it seems, cannot be trusted. 13, for example,
#             is obviously on the dark side, and perniciously odious; this is
#             so obvious that 1313 Mockingbird Place was the fictional
#             address fo the Munster's home, a television family of literal
#             monsters. "13.13" is also the name of a record release by the musician
#             Lydia Lunch. This recording is well produced, full of
#             wailing, dismal lyrics atop a psychedelic, even Beatlesque
#             sonic backdrop, but apparently the animosity between Lunch
#             and her backing band, members the LA punk group the Weirdos,
#             was so great that she chose to allow the work to languish and
#             refused to press more copies past the first run for literally
#             decades.
# 
#             Whole lot of evil going on there.  Hail Satan, Lydia.
# 
#             Oh, and now that we've brought up that particular being, in
#             the OEIS the sequence A051003, numbers containing the
#             digit-sequence 666, are known as the hateful numbers, and
#             furthermore numbers with 666 digits represent the apocalypes
#             numbers. I will now make a conjecture that for every person
#             who has existed and will exist throughout history, somewhere
#             there is a unique apocalypse number with their name on it.
# 
#             How's that for representing the dark side?
# 
#         Method
# 
#             To find the pernicious numbers we will need some sort of
#             popcount function to count the population of 1s in a binary
#             representation. We first visited this idea in PWC 114,
#             Integer Set Bits.
# 
# 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my $request = shift || 30;

my @perns;
my $candidate = 0;
my $p = prime_generator();
my @primes = $p->();
my %primes = ( $primes[-1] => 1 );

while (@perns <= $request) {
    my $pop = popcount( $candidate );
    push @primes, $p->() and $primes{$primes[-1]}++ until $primes[-1] > $pop;
    push @perns, $candidate if $primes{$pop};
    $candidate++;
}

say "@perns";



sub popcount ( $num, $sum = 0 ) {
    $sum += $_ for split '', sprintf "%b", $num;
    return $sum;
}

sub prime_generator {
## returns an iterator closure that once started always delivers the next prime
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








# use Test::More;
# 
# is 
# 
# done_testing();
