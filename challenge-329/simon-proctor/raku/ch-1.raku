#!/usr/bin/env raku

# Tests fired if called with test parameter
multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is counter-string("the1weekly2challenge2"), (1,2);
    is counter-string("go21od1lu5c7k"), (21,1,5,7);
    is counter-string("4p3e2r1l"), (4,3,2,1);
    done-testing;
}

subset ValidInput of Str where /^ <[a..z 0..9]>+ $/;

sub counter-string( ValidInput $in is copy ) {
    $in ~~ s:g/ (<[a..z]>) / /;
    return $in.split(/" "+/).grep(* !~~ "").unique.map(*.Int);
}

#|(Given a string made of lowercase letter and numbers
print a list of the unique numbers in it in order)
multi sub MAIN (
    ValidInput $str #= A string made up of lowercase letters and number
) {
    counter-string($str).join(", ").say;
}
