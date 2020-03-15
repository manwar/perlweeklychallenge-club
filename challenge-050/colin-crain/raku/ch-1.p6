use v6.d;

#
#       merge.raku
#
#       PWC 50 - TASK #1
#             Merge Intervals
#             Write a script to merge the given intervals where ever possible.
#
#                 [2,7], [3,9], [10,12], [15,19], [18,22]
#
#             The script should merge [2, 7] and [3, 9] together to return [2, 9].
#
#             Similarly it should also merge [15, 19] and [18, 22] together to return [15, 22].
#
#             The final result should be something like below:
#
#                 [2, 9], [10, 12], [15, 22]
#
#         analysis: Intervals can be merged if the start or end of one interval is
#             contined within the span of another. If the other boundry of the
#             second interval is outside the range of the first, a new interval
#             is created encompassing the combined span of the two.*
#
#             *If the outer boundry is also contained within the range of the
#             first, the second interval is swallowed whole into the larger and
#             disappears.
#
#             This process of integration can be chained, with the new interval
#             becoming increasingly larger, as long as there are intervals that
#             overlap the aggregate. Amoeba-like, the intervals expand as we
#             consolidate the intersecting areas, resulting in a remaining field
#             of discontinuous elements.
#
#             We will choose to to interpret the intervals expressed as an
#             absolute value, a scalar without a vector. The interval [6,4] will
#             be considered equivalent to the interval [4,6] as they encompass
#             the same span; the quantity of difference is what is being
#             measured, rather than a specific sequential progression. With this
#             stipulation the intervals can be always be coerced into ascending
#             order; without it, it's difficult to understand how the idea of
#             merging the intervals can meaningfully done without damaging the
#             data. That task would be more akin to summing vectors, or perhaps
#             finding the area under a graph. In any case it's outside the
#             purview of this challenge.
#
#         method: In preparation for merging, the interval pairs are sorted
#             ascending, first internally and then by their lower bound.
#             Stepwise, the lowest-bounded (leftmost) interval is shifted off
#             the list. If the next interval start is contained within the
#             existing, it is shifted off the list and the upper bound of the
#             current interval is increased or retained acordingly. This process
#             is continued until the next interval lower bound is outside the
#             range of the current. The current, expanded interval is then
#             output, and the process is begun again with the next, until we run
#             out of data.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {
    my @intervals = [ [2,7], [3,9], [19,15], [18,22], [10,12] ];

    ## present the raw input intervals
    say @intervals;

    @intervals .= map( {$_[1] > $_[0] ?? $_ !! [$_.reverse]} );
    @intervals .= sort( { $^a[0] <=> $^b[0] } );
    my @output;

    ## take a peek after transformation but before amalgamation
    say @intervals;


    while @intervals.elems {

        ## shift the first element and establish the bounds
        my $current = @intervals.shift;

        ## iterate through the intervals until a lower is greater than the current upper bound
        while @intervals.elems && (@intervals[0][0] <= $current[1]) {
            my $next = @intervals.shift;
            $current[1] = $next[1] if $next[1] > $current[1];
        }

        ## once out of there we add to the output list and start again with the next discontinuous interval
        @output.push( $current );
    }

    ## output the combined intervals
    say  (map {"[" ~ .join(', ') ~ "]"}, @output).join(' ');

}
