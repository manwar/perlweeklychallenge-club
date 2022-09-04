#!/usr/bin/raku

sub MAIN(
    Str $s  #= a string in quotation marks
) {
    my %chars;

    for $s.comb.antipairs -> $c {
        if %chars{$c.key}:exists {
            %chars{$c.key} = ∞;
        } else {
            %chars{$c.key} = $c.value;
        }
    }

    say (%chars.sort({ $^a.value <=> $^b.value})).first.value;
}