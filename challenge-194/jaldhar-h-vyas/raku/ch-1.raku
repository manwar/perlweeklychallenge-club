#!/usr/bin/raku

sub MAIN (
    $time #= time in the format hh:mm with one missing digit replaced by '?'
) {
    given $time.index('?') {
        when 0 { 
            given ($time.substr(1, 1)) {
                when 0 .. 3 { say 2; }
                default { say 1; }
            }
        }
        when 1 {
            given $time.substr(0, 1) {
                when 0 .. 1 { say 9; }
                when 2 { say 3; }
                default { die "Illegal time\n"; }
            }
        }
        when 3 { say 5; }
        when 4 { say 9; }
        default { die "No ? or ? is in an illegal position.\n"; }
    }
}
