#!/usr/bin/raku

sub levenshtein(Str $from, Str $to) {
    my $fromLength = $from.chars;
    my $toLength = $to.chars;

    if $toLength == 0 {
        return $fromLength;
    }

    if $fromLength == 0 {
        return $toLength;
    }

    my $fromTail = $from.substr(1, $fromLength - 1);
    my $toTail = $to.substr(1, $toLength - 1);

    if $from.substr(0, 1) eq $to.substr(0, 1) {
        return levenshtein($fromTail, $toTail);
    }

    return 1 + (
        levenshtein($from, $toTail),    # Insert
        levenshtein($fromTail, $to),    # Remove
        levenshtein($fromTail, $toTail) # Replace
    ).min;
}

sub MAIN(
    Str $S1, #= string to convert from
    Str $S2, #= string to convert to
) {
    say levenshtein($S1, $S2);
}