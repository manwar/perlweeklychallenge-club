#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited.
393-Task 2: Prime Step      Submitted by: Ulrich Rieke
You are given a string with English alphabetic characters only.
What is the absolute difference of the sum of the ASCII values of the
characters in the string to the nearest prime number?

=end comment



my @Test =
    # in           exp
    "hello",        9,
    "football",     2,
    "a",            0,
    "challenge",    2,
    "perl",         2,
;
plan @Test ÷ 2;

# Return an array with the two nearest primes or just the input itself.
sub primary-primes( Int:D() $n  --> Array) {

    return [$n] if $n.is-prime;

    my ($lo, $hi)  = $n xx 2;
    if $n %% 2 { ++$lo, --$hi; }

    repeat { $lo -= 2 } until $lo.is-prime;
    repeat { $hi += 2 } until $hi.is-prime;

    return [$lo, $hi];
}


sub task( Str:D() $a --> Int:D) {
     given [+] $a.comb».ord {
        when not .is-prime {
            my ( $lo, $hi) = primary-primes $_;
            return min $hi-$_, $_-$lo;
        }
        default { return 0; }
     }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in";
}
done-testing;

my $str = "TimeToTakeOutThePerl";
say qq{\nInput: \$str = "$str"\n Output: }, task $str;

