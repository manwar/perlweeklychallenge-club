#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       prime-rime-ime-me-e.pl
#
#       Truncatable Prime
#         Submitted by: Mohammad S Anwar
# 
#         Write a script to generate first 20 left-truncatable prime
#         numbers in base 10.
# 
#         In number theory, a left-truncatable prime is a prime number
#         which, in a given base, contains no 0, and if the leading left
#         digit is successively removed, then all resulting numbers are
#         primes.
# 
#         Example
# 
#             9137 is one such left-truncatable prime since 9137, 137, 37
#             and 7 are all prime numbers.

#         analysis:
# 
#             Number Theory is so weird. Take two ideas, as tenuously
#             related as any you can come up with, and weld them together,
#             then look and see what Frankenstein's monster you've created,
#             just to see if anything can be inferred from the data.
# 
#             Which itself is likely to be another question, another
#             derivitive in search of a place in a greater fabric of
#             meaning.
# 
#             There's a certain devil-may-care undercurrent to it all,
#             consequence be damned: With my new rabbit-fish soldiers my
#             army will be unstoppable! I hold the powers of life and death
#             itself in my hands!
# 
#             The mad-scientist metaphor is particularly apropos as the
#             patterns detected will be nearly by definition unobvious.
#             After all, if it were obvious it would probably just be
#             absorbed into some sort of more mainstream mathematics. What
#             is being looked for in Number Theory are the deep
#             connections, tendrils left over from the creation of the
#             universe itself, or even before and beyond the creation.
#             After all, math exists, metaphysically, outside the universe.
# 
#             Or perhaps that premise too can be disputed. Nothing is off
#             the table. We are investigating the hairy edge-cases of
#             reality with a ferver that aligns with the mystical. Newton,
#             it is known now, was an alchemist.
# 
#                 "There are more things in heaven and earth, Horatio, 
#                 Than are dreamt of in your philosophy." 
#                 — Hamlet 
# 
#             Why would anyone do this? It's obvious: because it's there,
#             of course. If you could stare into the center of creation,
#             why wouldn't you?
# 
#             Bring sunglasses.
# 
#           method:
# 
#             As we have no idea of how many primes we will require, we'll
#             rework our prime generator as an iterator, maintaining an
#             internal list, computing and returning the next prime,
#             whatever that is, when called. These primes are then placed
#             in a hash for easy lookup, as we'll need to consult our list
#             of already-computed primes often, with random access.
# 
#             When we have a new prime, we hand it to a truncatable()
#             subroutine to see how it fares. Inside a loop the leftmost
#             digit is lopped off using substr() and the value is
#             rechecked. If at any time the lopped number is no longer
#             prime 0 is returned, and if it successfully runs the gauntlet
#             we return 1. This subroutine is used for a loop conditional
#             to try the next candidate prime. If the test is passed we add
#             the candidate to the list of left-trancatables and continue.
# 
#             We'll skip the trivial cases of single-digit primes as
#             uninteresting, and because our algorithm runs quickly we'll
#             compute a thousand instead of 20.
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub get_next_prime ( ) {
## an iterator that delivers the next prime
    state @primes;
    
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

my $prime_lookup;
my @lt_primes;

while ( @lt_primes <= 1000 ) { 
    my $candidate = get_next_prime();
    $prime_lookup->{ $candidate } = 1;
    next unless left_truncatable( $candidate, $prime_lookup );
    $candidate and push @lt_primes, $candidate;
}

say $_ for @lt_primes;

sub left_truncatable ( $val, $lookup ) {
    return 0 if $val =~ /0/;
    return 0 if $val =~ /^\d$/;
    
    while ( 1 ) {
        substr $val, 0, 1, '';
        last unless $val;
        return 0 unless $lookup->{$val};
    }
    return 1;
}


