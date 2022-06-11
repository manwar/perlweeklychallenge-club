#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       padovans-dog.pl
#
#       Padovan Prime
#         Submitted by: Mohammad S Anwar
#         A Padovan Prime is a Padovan Number that’s also prime.
# 
#         In number theory, the Padovan sequence is the sequence of
#         integers P(n) defined by the initial values.
# 
#                 P(0) = P(1) = P(2) = 1
#     
#         and then followed by
# 
#             P(n) = P(n-2) + P(n-3)
#     
#         First few Padovan Numbers are as below:
# 
#             1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, ...
# 
#         Write a script to compute first 10 distinct Padovan Primes.
# 
#         Expected Output
# 
#             2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057
# 
#       analysis
# 
#         The Padovan numbers are defined by a recurrence relation similar
#         to that of the Fibonacci numbers, only in this case not using the
#         sum of the two previous values but rather the result of skipping
#         over the previous value and summing the two sequential positions
#         previous to that.
# 
#         There is one additional twist, however, in the unusual selection
#         of the starting conditions. There are other equivalent extensions
#         of the Fibonacci number recurrence relation, first as a
#         generalized Lucas sequence and then later as the basis of what is
#         known as the Perrin sequence. These differ only from the Padovan
#         numbers in their initializaion parameters.
# 
#         Once curious property of many found in the Fibonacci numbers is
#         the ability to assange a construction of squares, with side
#         lengths the values of the Fibonacci numbers, to form a
#         space-filling gemometric pattern. By inscibing an arc within each
#         square with the side as radius the arcs can be connected to form
#         a spiral that closely mimics and converges on the gloden spiral,
#         a logarithmic spiral with a growth factor of φ. This parallels
#         the property that the ratio of sucessive Fibonaci numbers also
#         converges to φ, the ratio (a + b)/a = b/a .
# 
#         I personally find the space-filling aspect of the construction
#         one of the most fascinating aspects of the sequence; that by
#         circling around the area can be expanded indefinitely without
#         gaps, and without repeating any elements beyond the initial
#         conditions. Although the construction can be continued
#         indefinitely using fraction smaller sizings, if we wish to keep
#         the values whole we need to duplicate the first 1, to provide a
#         complete 1 + 1 = 2 sized wall to start the spiral.
# 
#         Once we have that kernal established we can add new, larger
#         squares in a circular rotation indefinitely.
# 
#         The selection of the initial conditions of the Padovan numbers
#         allows us to construct a similar figure, only based on
#         equilateral triangles with side lengths corresponding to the
#         sucessive elements of the sequence. This construction is also
#         space-filling and can be expanded indefinitely.
# 
#         A logarithmic spiral can also be inscribed in the construction,
#         analogous to the Fibonaci spiral, that mimics the spiral with a
#         growth factor of the convergence of that sequence. This number,
#         known as the "plastic number", or commonly just p, is
#         approximately 1.32471, and corresponds to the real solution to
#         the equation
# 
#         x^3 = x + 1
# 
#         which in turn is analogous to φ again, as the solution to the
#         experssion
# 
#         x^2 = x + 1
# 
#         The selection of the initial conditions (3, 0, 2) with the same
#         recurrence relation yields what is known as the Perrin sequence,
#         which has a curious association with prime numbers: for all prime
#         numbers p, P(p) % p = 0. Which is to say all primes are divisors
#         of their Perrin number. This would make for aquick test of
#         primality except for the existence of what are known as Perrin
#         pseudoprimes, which are conmposite numbers the share this same
#         propery. The first such number was only discovered in 1982 and is
#         521^2 = 271441. There are an infiite number of pesudoprimes,
#         although they are still reletively infrequent.
# 
#         The association, or near-association, of Perrin numbers with the
#         primes is a good example of why, given a sequence, some
#         mathematician of another is going to come along and check its
#         membership for primality. You never know what if you might find
#         something new and interesting. THis is what we're doing today.
# 
#       method
# 
#         As no better scheme presents itself, we'll solve the task by
#         constructing a sequence of Padovan numbers using the recurrence
#         relation, checking new values for primality. We can save some
#         space by discarding obsolite members of the sequence and only
#         maintaining a queue of the last three elements constructed.
# 
#         One troublesome qualifier was that the returned results be
#         distinct. In order for the final count to be correct this
#         selection needed to be before the output as assembled, so an
#         extra conditional was inserted. 
# 
#         Determning more than the requested 10 values is problematic, as
#         the final result of the 10 is the value 3,093,215,881,333,057
#         already. As t turns out, thanks to Raku, the next result is 
# 
#         1363005552434666078217421284621279933627102780881053358473
# 
#         our manual method of checking for primality is going to break
#         even if we arranged to be able to handle the required integer. 
# 
#       observation
# 
#         The Padovan numbers, for all their interesting geometric
#         associations, don't seem to have much if anything to do with the
#         primes. Hence the title.
# 
#         Perhaps a kinder take than the pejorative would be to say it's a
#         reference to the way dogs will run in circles when excited. The
#         spiral mimics that. 
# 
#         Yea, we're going to go with that instead. Thinking about happy
#         dogs is always better than... most anything. 4
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

MAIN: {
    my @out = ();

    while ( @out < 10) {
        my $c = next_pad();
        next if (defined $out[-1] and $out[-1] == $c);
        push @out, $c if is_prime( $c ) ;
    }

    say "@out";
}

sub is_prime ($n) {
    my $sqrt = int sqrt $n;
    return 0 unless $n % 2 or $n == 2;
    
    for (my $x = 3; $x <= $sqrt; $x += 2) {
        return 0 unless $n % $x;
    }
    return 1;
}

sub next_pad {
    state @p = (1,1,1);
    push @p, $p[1] + shift @p;
    return $p[-1];
}


