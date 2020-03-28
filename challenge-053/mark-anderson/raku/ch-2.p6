#!/usr/bin/env raku

sub MAIN($length where 1 <= $length <= 5) {
    my %next_letter = a => <e i>,
                      e => <i>,
                      i => <a e o u>,
                      o => <a u>,
                      u => <o e>;

    for <a e i o u> -> $first_letter {
        my @queue = Empty;
        @queue.push($first_letter);

        while @queue[0].chars < $length {
            my $str = @queue.shift;
            my $last_letter = $str.substr(*-1);
            for %next_letter{$last_letter}.Array -> $ltr {
                @queue.push($str ~ $ltr);
            }
        }

        say @queue.join("\n");
    }
}
