#!/usr/bin/env perl6
use v6;

use MONKEY-SEE-NO-EVAL;

# Note all sorts of bad things can still be done with this code - like a
# user might pass in the name of an existing variable, might start a
# variable name with a number, etc.

sub MAIN(Str:D $var-name, $value) {
    die "Invalid variable name" if $var-name !~~ m/^ \w+ $/;  # Doesn't catch everything
    EVAL("my \$OUR::$var-name = { $value.perl }");
    EVAL("say '\$$var-name is set to: ' ~ \$OUR::$var-name");
}


