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

    multi sub append_letter($ltr where $length == 1) {
        say $ltr;
    }

    multi sub append_letter($str) {
        my $last_letter = $str.substr(*-1);

        for %next_letter{$last_letter}.Array -> $ltr {
            my $new_str = $str ~ $ltr;
        
            if ($new_str.chars == $length) {
                say $new_str;
            }

            else {
                append_letter($new_str);
            }
        }
    }
}
