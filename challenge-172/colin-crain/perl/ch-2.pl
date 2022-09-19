#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       five-finger-stat-punch.pl
#
#       Five-number Summary
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers.
# 
#         Write a script to compute the five-number summary of the given
#         set of integers.
# 
#         You can find the definition and example in the 
#         [wikipedia page](https://en.wikipedia.org/wiki/Five-number_summary).
# 
#       BACKGROUND
# 
#         In statistics, mathematical analysis is performed on what are
#         large datasets. In this analysis, individual data points are
#         deemphasized, and we look beyond the individual values in an
#         effort to infer general statements about the collection as  a
#         whole. The data itself is usually empirical in origin, gathered
#         from real-world phenomena, and as such are always subject to some
#         degree of collection or recording error. Much of statistical
#         analysis addresses the precision within the dataset, assigning
#         numerical weights to the confidence in the values, which can be
#         mathematically extrapolated as a caveat onto any conclusions
#         made. The analysis, after all, can only be as good as the data it
#         comes from.
# 
#         Given some collection of data, when seeking a normal,
#         representative, middle value, it might not be immediately obvious
#         that this idea can be approached in more than one way. There are
#         in fact quite a few. We could for instance find an arithmetic
#         average, a mean value, summing and dividing, but that is only one
#         of several mean values available to us.  We explored this idea in
#         PWC157, calculating the Pythagorean Means. Ultimately the
#         derivation of the data itself determines the best fit for the
#         job.
# 
#         But even the average, an average, isn't necessarily meaningfully
#         representative. Another thing we could look at is what value
#         occurs most often. To take an extreme case, if the data isn't
#         numerically related at all this can be a better way to summarize,
#         obviously. If one number keeps showing up there is presumably
#         some reason to be inferred.
# 
#         One somewhat radical approach to select a representative sample
#         is to order the data and take the literal middle value.
#         Arithmetically this doesn't make much sense, but statistically it
#         does, as one unexpected benefit of this method is its remarkable
#         resiliency against spurious, outlier data points.
# 
#         Given a collection of values of human heights, one might expect a
#         range between extremes,  with babies at maybe 30cm and large
#         adults at somewhat over 200cm. Averaging all of these might tell
#         you something, but I'm not sure what. Depending on how many
#         babies are involved the number might be around say, 150cm?  Just
#         guessing here. However a single data entry error for the
#         kilometers traveled on business for a year: 5000km, would not
#         only make that average useless but also poison any further use of
#         the value downstream. Using a median, though, the bad outlier
#         data would only move the central element slightly, with about
#         equal probability up or down. Our monsterous error has been
#         transformed into a slight loss of precision.
# 
#         The quartitles are an extension of this data-levelling idea into
#         two more subdivisions on either side of the median, to slot in
#         and combine with the median to provide points at 25%, 50%, and
#         75%. Exactly how these points are arrived at is not universally
#         decided.
# 
#         The problem arrives when we wish to  take the median of one-half
#         the data. If the whole set has a discrete median, do we include
#         that when calculating one-half the data? Including it will make
#         each computed half slightly larger than a real half, and not
#         including it will make the cut smaller. There are more exact
#         methods to accommodate more even division but we have to stop and
#         consider the imprecision of the median itself before we make
#         things more unnecessarily more complicated. Uncertainty carries
#         over through the calculations, and the median is not the mean.
# 
#         It should be added that should we require a rigorous mathematical
#         certainty there are well-defined approaches to looking at the way
#         data is distributed within a range, such as the standard
#         deviation. So we have that if we want it. On the other hand if
#         we're looking for the middle, a representative low number, a
#         representative high number, and a set of outer boundaries that
#         all the data lies inside, then the 5-number summary has proven to
#         be a pretty practical start at getting the feel of a dataset Ñ
#         arithmetically imperfect as it may be.
# 
#       METHOD
# 
#         Depending on whether the number of elements under consideration
#         is even or odd, to find the median we either select the center
#         element from the list or average the two elements either side of
#         the center. In this simplest case of an arithmetic mean we add
#         the two values and divide by 2.
# 
#         Then, depending on whether the left and right Ñ equal Ñ sides
#         around the median have an even or odd count we need to again
#         select either a discrete center element or average the two
#         surrounding.
# 
#         Because again there oddly is no rigorous consistency in defining
#         the calculation of the 1st and 3rd quartiles, and these differing
#         approaches result in differing outcomes, we will need to pick
#         one. We will use the common method of halving the array if the
#         median point lies between two values, and if the median is a
#         discreet element not including it in the half-array length.
# 
#         We are left with four cases to evaluate, for each of the four
#         combinations of even and odd numbers of data points in both the
#         full dataset and our chosen determined half-size.
# 
#         I still find it exceedingly odd that the method for determining
#         the 25% and 75% medians, if you will, are not well-defined.
#         However in the statistical context of the summary, a closer look
#         suggests an essentially parallel ambiguity in what we want from
#         our middle value. So in a weird way the ambiguity is consistent.
# 
#         After all, the statistics are based on the median, not the mean.

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my @arr = @ARGV;

## default data array
@arr == 0 and @arr = (1,2,3,4,5,6,7,8,9);


## main
@arr = sort { $a <=> $b } @arr;
say " Data Values: [ @arr ]\n";
my @five = ( $arr[0], quartiles(\@arr), $arr[-1] );
my @names = ( "Minimum", "1st Quartile", "Median", "3rd Quartile", "Maximum" );
say sprintf "%12s: %-s", $names[$_], $five[$_] for (0..4);


## subs
sub quartiles ( $arr ) {
    my $count = scalar $arr->@*;
    my $half  = int($count/2);          ## note integer truncation
    
    my ($q1, $q2, $q3);
    if ( $count & 1 ) {                     ## odd num elements
        $q2 = $arr->[$half];
        if ( $half & 1 ) {                          ## odd halfway index
            $q1 = $arr->[$half/2];
            $q3 = $arr->[$half + $half/2 + 1];
        }
        else {                                      ## odd halfway index
            $q1 = avg($arr->[$half/2-1], $arr->[$half/2]);
            $q3 = avg($arr->[$half+$half/2], $arr->[$half+$half/2+1]);
       }
    }
    else {                                  ## even num elements
        $q2 = avg($arr->[$half-1], $arr->[$half]);
        if ( $half & 1 ) {                          ## odd halfway index
            $q1 = $arr->[$half/2];
            $q3 = $arr->[$half + $half/2];
        }
        else {                                      ## even halfway index 
            $q1 = avg($arr->[$half/2-1], $arr->[$half/2]);
            $q3 = avg($arr->[$half+$half/2-1], $arr->[$half+$half/2]);
        }
    }
    
    return ( $q1, $q2, $q3 );
}

sub avg( $n1, $n2 ) {
    return ($n1 + $n2)/2;
}

=cut

the four cases, broken down: 

(array length, computed half-array length)

ODD,EVEN
[0, 1, 2, 3,    4,    5, 6, 7, 8]           
count = 9
half  = 4
q2 = half
q1 = (1+2)/2 = avg(half/2-1, half/2)
q3 = (6+7)/2 = avg(half/2+half, half/2+half+1)

EVEN,EVEN
[0, 1, 2, 3,    4, 5, 6, 7]                 
count = 8
half  = 4
q2 = avg(half-1,half)
q1=(1+2)/2 = avg(half/2-1, half/2)
q3=(5+6)/2 = avg(half/2+half-1, half/2+half)
 
ODD,ODD
[0, 1, 2,    3,    4, 5, 6]                 
count = 7
half  = 3
q2 = 3 = half
q1 = 1 = half/2
q3 = 5 = half + half/2 + 1

EVEN,ODD
[0, 1, 2,     3, 4, 5]                      
count = 6
half  = 3
q2 = avg(half-1,half) 
q1 = 1 = half/2
q3 = 4 = half + half/2

