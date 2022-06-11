#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       happy-happy-joy-joy.pl
#
#         Happy Numbers
#         Submitted by: Robert DiCicco
#         Write a script to find the first 8 Happy Numbers in base 10. For
#         more information, please check out Wikipedia.
# 
#         Starting with any positive integer, replace the number by the sum
#         of the squares of its digits, and repeat the process until the
#         number equals 1 (where it will stay), or it loops endlessly in a
#         cycle which does not include 1.
# 
#         Those numbers for which this process end in 1 are happy numbers,
#         while those numbers that do not end in 1 are unhappy numbers.
# 
#         Example:
# 
#             19 is Happy Number in base 10, as shown:
#     
#             19 => 1^2 + 9^2
#                => 1   + 81
#                => 82 => 8^2 + 2^2
#                      => 64  + 4
#                      => 68 => 6^2 + 8^2
#                            => 36  + 64
#                            => 100 => 1^2 + 0^2 + 0^2
#                                   => 1 + 0 + 0
#                                   => 1
# 
#         commentary:

#             What makes a number happy? According to one theory, whose
#             origins are lost to history, it's the presence of a numeric
#             imperative; of a timeline; of eventual closure to its
#             existence. 
# 
#             In short, as we travel through life, we end up repeating
#             similar actions again and again. The particulars my change,
#             but the framework is what we know and how we know, and that
#             remains consistent. If that resolves then we get closure and
#             ultimately from this a sense of purpose, but if we find
#             ourselves in the same situation again and again, so much that
#             we know the outcome before we start, than we are unhappy,
#             stuck in a loop, going nowhere, without meaning for the
#             future and by extension the past. 
#             
#             This is a pretty heady philosophical position for a number,
#             unexpected as we generally consider the mathematical realm
#             removed from the internal conflicts the physical plane. 
# 
#             I personally have always considered the numbers to be above
#             such emotional tethers, otherwise engaged in cosmic
#             connections that we on Earth are only just beginning to
#             comprehend. 
# 
#             This in turn leads to questions of anthromophication of these
#             entities, and whether the idea itself of happiness transcends
#             the human condition, somehow wrapped in a larger concept of
#             unity and truth to a broader nature: that we experience what
#             we call happiness because we are somehow engaging in some
#             larger process without conflict. This brings to mind
#             questions abouut the apparent singular directionality of
#             time, and with that movement direction, of action combined
#             with data. 
# 
#             This last idea is modeled in container theory, providing
#             another bridge between the worlds, so the fundamental premise
#             seems somewhat less far-fetched.
# 
#             As stated before, the source of this philosophical premise
#             about happy, and by extension unhappy, numbers is itself
#             unknown, which is somehow consistent and ultimately fitting.
#             The nunbers themselves are notoriously tight-lipped on the
#             subject.

#         background:
# 

#             At the intersection of dynamical systems and number theory
#             lies the field of arithmetic dynamics, examining the evolving
#             state of parameters in an  transformation equation repeatedly
#             applied to the same mutating data. This process of
#             re-applying a mapping to a field of data points is known as
#             an iterated function. In arithmetic dynamics these methods
#             are used on number-theoretical functions, looking for
#             underlying structures behind these equation classes.
# 
#             The transformation of squaring and summing the coefficients
#             of a polynomial expansion of a representational number,
#             repeatedly applied until the result stabilizes into either a
#             set result of a known cyclic pattern is one such system, and
#             the determiniation of a number's happiness an analysis of
#             that system.
# 
#             The most familiar application of dynamical systems analysis
#             if the preparation of the Mandelbrot set, which is constucted
#             from points on the complex plane repeatedly iterated through
#             the transformation
# 
#             *z* = *z*² + *c*
# 
#             The set, visualized for a given constant *c*, is those points
#             where the reperated application of the iterated function is
#             determined to converge, versus those where the result is
#             unbounded, with emphasis placed on the properties of the edge
#             between the two possible outcomes and its particular fractal
#             nature.
# 
#             In general, the actual parameter ranges observed in a
#             dynamical system are known as the state space, and the
#             meta-analytical analysis and mapping of the possible
#             parameter states for a given equation is known as the phase
#             space. Constrained
# 
#             self-referential feedback systems metastable 
            
            


#         method:

#             To actually accompish the task we will revisit a technique we
#             developed back in PWC106, where we had to recognize a
#             repeating cycle of digits in a decimal representation of a
#             fraction. In identifying a reptend, we modeled long division,
#             and recognized that should a given remainder repeat once we
#             were carrying down 0s, then that cycle would continue
#             indefinitely. In a similar way, if one of our arthimetic
#             transformations produces a previously seen result then we
#             know that some repeating cycle will bring us around to that
#             point again, with no variance is allowed in the process.
# 
#             Thus we establish a "seen" hash of all results caluculated,
#             and after a transormation compare the result to the keys in
#             this hash; if the key is present we are trapped in a
#             repeating cycle an cannot escape.
# 
#             Alternately, if our reduction reaches 1 then we have won and
#             can stop the transformation loop.
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

use List::Util qw( sum );

my $q = shift // 8;
my @out;

while ( @out < $q and ++$_ ){
    push @out, $_ if happy($_);
}

{
    local $" = ', ';
    $_ = "@out";
    say;
}

sub happy ($num) {
    my %seen = ( $num => 1 );
    
    while ( $num != 1 ) {
        $num = sum map { $_ ** 2 } split //, $num;
        return 0 if $seen{$num};
        $seen{$num} = 1;
    }
    return $num;
}




__END__

the 10-happy number sequence up to 100:
1, 7, 10, 13, 19, 23, 28, 31, 32, 44, 49, 68, 70, 79, 82, 86, 91, 94, 97, 100

