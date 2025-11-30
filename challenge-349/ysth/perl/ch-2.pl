use 5.040;
use List::Util 1.29;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK2

# meeting_point
# instructions: series of U/L/D/R characters indicating movement
# return true if movement returns to origin at any step, otherwise false
sub meeting_point($instructions) {
    my $x = my $y = 0;
    my $met_origin = true;
    while (true) {
        if ($instructions =~ /\GU/gc) {
            last unless ++$x or $y;
        }
        elsif ($instructions =~ /\GD/gc) {
            last unless --$x or $y;
        }
        elsif ($instructions =~ /\GR/gc) {
            last unless ++$y or $x;
        }
        elsif ($instructions =~ /\GL/gc) {
            last unless --$y or $x;
        }
        else {
            $met_origin = false;
            last;
        }
    }
    return $met_origin;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { meeting_point($inputs) ? "true" : "false" },
        '"ULD"',
        '{"type":"string","pattern":"^[UDRL]*$"}'
    );
}
