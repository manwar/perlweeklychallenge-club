# This is just my translation of https://leetcode.com/problems/minimum-cost-for-tickets/editorial/
# into Raku. I should receive reduced street-cred for it. :^)
sub task2 ( @costs, @days ) {
    constant @duration = 1, 7, 30;
    die if   @costs != @duration;
    my @cd = @costs Z  @duration;

    warn "No advantage to  7-day ticket over 1-day" if @costs[0] *  7 <= @costs[1];
    warn "No advantage to 30-day ticket over 1-day" if @costs[0] * 30 <= @costs[2];
    warn "No advantage to 30-day ticket over combo" if @costs[1] *  4
                                                     + @costs[0] *  2 <= @costs[2];

    my Set  $dayset = @days.Set;
    my UInt $max    = @days.max;

    my sub dp ( $i ) {
        return $i > $max    ?? 0
            !! $i ∉ $dayset ?? dp($i + 1)
            !!                 @cd.map({ dp($i + .[1]) + .[0] }).min;
    }

    return dp(1);
}


my @tests = map { %( <expected costs days> Z=> .list ) },
    ( 11, (2, 7, 25), (1, 5, 6, 7, 9, 15) ),
    ( 20, (2, 7, 25), (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31) ),
;
use Test;
plan +@tests;
is task2(.<costs>, .<days>), .<expected> for @tests;
