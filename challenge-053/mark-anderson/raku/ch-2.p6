#!/usr/bin/env perl6

sub MAIN($length where 1 <= $length <= 5) {
    my @connections = ["ae", "ai", "ei", "ia", "ie", 
                       "io", "iu", "oa", "ou", "uo", "ue"];

    for <a e i o u> -> $first_letter {
        my @queue = Empty;
        @queue.push($first_letter);

        while @queue[0].chars < $length {
            my $str = @queue.shift;
            my $last_letter = $str.substr(*-1);
            for @connections.grep(/^$last_letter/).map(*.substr(*-1)) -> $ltr {
                @queue.push($str ~ $ltr);
            }
        }

        say @queue;
    }
}
