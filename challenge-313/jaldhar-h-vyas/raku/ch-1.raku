#!/usr/bin/raku

sub breakup($str) {
    return $str.match(/( (.) $0* )/, :g).List;
}

sub MAIN(
    Str $name,
    Str $typed
) {
    my @nameParts = breakup($name);
    my @typedParts = breakup($typed);
    my $result = True;

    for @typedParts Z @nameParts -> ($t, $n) {
        unless $t.match(/$n/) {
            $result = False;
            last;
        } 
    }

    say $result;
}
