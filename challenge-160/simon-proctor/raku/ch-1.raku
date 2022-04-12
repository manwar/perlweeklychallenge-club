#!/usr/bin/env raku

#| Given an integer between 1 and 9 print the four is magic chain for it
sub MAIN(
    Int() $a is copy where 0 < * < 10 #= Integer between 1 and 9
) {
    my @n=<<zero one two three four five six sever eight nine>>;
    my @o;
    while ( $a != 4 ) {
        my $l = @n[$a].codes;
        @o.push("{@n[$a]} is {@n[$l]}");
        $a=$l;
    }
    @o.push("four is magic.");
    @o.join(", ").tc.say
}
