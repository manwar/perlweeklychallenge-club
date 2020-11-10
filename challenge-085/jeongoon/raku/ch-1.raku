#!/usr/bin/env raku

# test with:
# raku ch-1.raku 0.1 0.2 0.5 2.4 1.2 0.8
# or
# raku ch-1.raku --alt 0.1 0.2 0.5 2.4 1.2 0.8

multi sub MAIN ( *@r where { @r.elems > 0 and
                             @r.all ~~ Rat and @r.all > 0.0 } ) {
    @r.
    grep(* < 2.0).
    combinations(3).
    lazy.
    first( 1.0 < *.sum < 2.0 )
    andthen say("1.0 < "
               ~ "({join(' + ', $_.List)})"
               ~ " < 2.0")
    orelse say "0";
}

multi sub MAIN ( Bool:D :$alt, *@r where { @r.elems > 0 and
                                           @r.all ~~ Rat and @r.all > 0.0 } ) {
    $*ERR.say( "alternative solution using iterator ..." );
    my $triplet-it = @r.sort.combinations(3).lazy.iterator;

    my $found = False;
    loop ( my $t := $triplet-it.pull-one;
        ($t =:= IterationEnd).not
        ; $t := $triplet-it.pull-one ) {
        if 1.0 < $t.sum < 2.0 {
            $found = True;
            say("1.0 < "
               ~ "({join(' + ', $t.List)})"
               ~ " < 2.0");
            last;
        }
    }

    say 0 unless $found;
}
