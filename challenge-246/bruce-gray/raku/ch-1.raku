# One-line solution:
#
#   raku -e 'put (1..49).pick(6)'
#
# Example output: 42 18 15 6 49 47

# Oh, you want tests as well? Here you go!
constant $lottery_balls = 6;
constant $lottery_range = 1..49; 

sub German_lottery ( --> Seq ) { $lottery_range.pick($lottery_balls) }

use Test; plan 2;
constant $test_draws = 1_000;
my %faults;
my SetHash $ball_seen;
for ^$test_draws {
    my Int @win = German_lottery();
    $ball_seen{$_} = True for @win;

    sub bad ($t) { ++%faults{$t}; diag "Failed $t: @win[]" }

    bad 'bad_count'      if @win != $lottery_balls;
    bad 'not_unique'     if @win.repeated;
    bad 'exceeded_max'   if @win.any > $lottery_range.max;
    bad 'lower_than_min' if @win.any < $lottery_range.min;
}
is $ball_seen.elems, $lottery_range.elems,
    "In $test_draws draws, all balls {$lottery_range.raku} were drawn at least once.";
is-deeply %faults, {},
    "In $test_draws draws, no faults were found.";
