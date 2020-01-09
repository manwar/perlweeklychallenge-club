#!/usr/bin/env perl6

# ch-2.p6 - Balanced Braces
#
# Ryan Thompson <rjt@cpan.org>

# First, the generator
sub gen-str( Int $half-len ) { ('()' x $half-len).comb.pick(*).join }

# And now, the checker
sub balanced( Str $str is copy --> Bool ) {
    Nil while $str ~~ s:g/'()'//;
    $str.chars == 0
}

# Check a few
say "0 length - ", balanced('') ?? 'OK' !! 'NOT OK'; # No need to repeat this
for 1..5 -> $n {
    for (^5).map({ gen-str($n) }) -> $str {
        say "$str - ", balanced($str) ?? 'OK' !! 'NOT OK';
    }
}
