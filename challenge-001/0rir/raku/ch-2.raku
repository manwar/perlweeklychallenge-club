#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
001-2
Write a one-liner to solve the FizzBuzz problem and print the numbers 1 through 20. However, any number divisible by 3 should be replaced by the word ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both divisible by 3 and 5 become ‘fizzbuzz’.
=end comment

my $exp =
    "1 2 fizz 4 buzz fizz 7 8 fizz buzz 11 fizz 13 14 fizzbuzz 16 17 fizz 19 buzz"
;

sub fizzbuzz($sentinel = 20) {
    my $ret;
    for 1..$sentinel -> $n {
        given $n {
            when $n %% 3 {
                $ret ~= 'fizz';
                if $n %% 5 { $ret ~= 'buzz' }
                $ret ~= ' ';
            }
            when $n %% 5 { $ret ~= 'buzz ' }
            default { $ret ~= "$n " }
        }
    }
    $ret.trim-trailing;
}

plan 1;
is fizzbuzz(), $exp, 'fizzy';

done-testing;

say "\nfizzbuzzing: &fizzbuzz()";

exit;

