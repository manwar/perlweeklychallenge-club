#!/usr/bin/env raku

#| Given a time string in am/pm convert to 24hr clock
multi sub MAIN( $t where $t ~~ /^ \d\d ":" \d\d " "? "am"/) {
    given $t {
        when /^ "12:" (\d\d) " "? "am" $/ {
            (S/^ "12:" (\d\d) " "? "am" $/00:$0/).say
        }
        default {
            (S/^ (\d\d ":" \d\d) " "? "am" $/$0/).say
        }
    }
}

multi sub MAIN( $t where $t ~~ /^ \d\d ":" \d\d " "? "pm"/) is hidden-from-USAGE {
    given $t {
        when /^ "12:" (\d\d) " "? "pm" $/ {
            (S/^ "12:" (\d\d) " "? "pm" $/12:$0/).say
        }
        default {
            (S/^ (\d\d) ":" (\d\d) " "? "pm" $/{$0+12}:$1/ given $t).say
        }
    }
}

#| Given a time in 24hr clock convert to am/pm
multi sub MAIN( $t ) {
    given $t {
        when /^ "00:" (\d\d) $/ {
            (S/^ "00:" (\d\d) $/12:{$1}am/).say
        }
        when /^ "12:" (\d\d) $/ {
            (S/^ "12:" (\d\d) $/12:{$1}pm/).say
        }
        default {
            ($_ ~~ /^ (\d\d) ":" (\d\d) $/);
            sprintf( "%02d:%02d%s", $0 > 12 ?? $0-12 !! $0, $1, $0 > 12  ?? "pm" !! "am").say;
        }
    }
}
