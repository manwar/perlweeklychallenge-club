#!/usr/bin/env raku

sub MAIN($length where 1 <= $length <= 5) {
    my %next_letter = a => <e i>,
                      e => <i>,
                      i => <a e o u>,
                      o => <a u>,
                      u => <o e>;

    for <a e i o u> -> $first_letter {
        append_letter($first_letter);
    }

    sub append_letter($str) {
        if ($str.chars == $length) {
            say $str;
        }

        else {
            my $last_letter = $str.substr(*-1);

            for %next_letter{$last_letter}.Array -> $ltr {
                append_letter($str ~ $ltr);
            }
        }
    }
}
