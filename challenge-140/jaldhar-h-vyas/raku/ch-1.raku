#!/usr/bin/raku

# A simple way to add two binary numbers
# raku -e '(@*ARGS[0].parse-base(2) + @*ARGS[1].parse-base(2)).base(2).say;' $@ 

multi sub infix:<+>(
    IntStr:D $a,
    IntStr:D $b
) {
    say 'overload!';
    return ($a.parse-base(2) + $b.parse-base(2)).base(2);
}

sub MAIN(
    Str $a,
    Str $b
) {
     say $a + $b;
}
