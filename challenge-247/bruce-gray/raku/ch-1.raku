# This code is a hot mess, and lots of corner cases are not covered.
# Also, the task examples showed mutual (paired) exchange,
# but that is not how Secret Santa is usually played,
# so I have a boolean PAIR flag for that.

use Adverb::Eject;
# constant $PAIR = True;
constant $PAIR = False;

proto     task1 ( |          ) { * }
multi sub task1 ( @n where 0 ) { Empty }
multi sub task1 ( @n where 1 ) { @n[0] => @n[0] }
multi sub task1 ( @n where 2 ) { @n[0] => @n[1],
                                 @n[1] => @n[0] }
multi sub task1 ( @n where 3 ) { @n[0] => @n[1],
                                 @n[1] => @n[2],
                                 @n[2] => @n[0] }

multi sub task1 (@names) {
    my @c = @names.classify(*.words[1]).map({ .value.pick(*).Array }).pick(*).flat;

    my @ret;
    if @c.elems !%% 2 {
        my $first = @c.shift;
        my $last  = @c.pop;
        my $half  = @c.end div 2;
        my $mid   = @c[$half];      @c[$half]:eject;

        @ret.append: |samewith([$first, $mid, $last]);
    }

    # @n.elems is now even.
    @ret.append: |pair_or_chain(@c);

    return @ret;
}
sub pair_or_chain ( @names ) {
    die unless @names %% 2;

    # @a is passed in grouped order.
    # By creating with pairings half-the-size-of-the-list distance away,
    # we minimize the number of inter-group pairings
    my $half = @names.elems div 2;
    my @a = @names.head($half);
    my @b = @names.tail($half);

    return |(@a Z=> @b), |(@b Z=> @a) if $PAIR;

    my @cycle = (@a Z @b).flat;
    push @cycle, @a.head;

    return @cycle.rotor(2 => -1).map({ .[0] => .[1] });
}
my @examples =
  (
    'Mr. Wall',
    'Mrs. Wall',
    'Mr. Anwar',
    'Mrs. Anwar',
    'Mr. Conway',
    'Mr. Cross',
  ),
  (
    'Mr. Wall',
    'Mrs. Wall',
    'Mr. Anwar',
  ),
  # Example from Peter Campbell Smith
  (
    'Rudolph Reindeer',
    'Dasher Reindeer',
    'Dancer Reindeer',
    'Prancer Reindeer',
    'Vixen Reindeer',
    'Comet Reindeer',
    'Cupid Reindeer',
    'Donner Reindeer',
    'Blitzen Reindeer',
    'Santa Claus',
    'Mrs. Claus',
    'Subordinate Claus',
  ),
;

# XXX Not really testing this time, just exercising the examples.
# use Test; plan @tests;
for @examples -> @names {
    say '';
    .say for task1(@names);
}
