#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;
use Ez-lit;

=begin comment
308-Task 2: Decode XOR              Submitted by: Mohammad Sajid Anwar
You are given an encoded array and an initial integer.

Write a script to find the original array that produced the given encoded array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].

Example 1
Input: @encoded = (1, 2, 3), $initial = 1
Output: (1, 0, 2, 1)

Encoded array created like below, if the original array was (1, 0, 2, 1)
$encoded[0] = (1 xor 0) = 1
$encoded[1] = (0 xor 2) = 2
$encoded[2] = (2 xor 1) = 3
Example 2
Input: @encoded = (6, 2, 7, 3), $initial = 4
Output: (4, 2, 0, 7, 4)

=end comment

my @Test =
    # init/key  encoded         clr/exp
    20,          (),            ∘( 20,),
    1,          ∘< 1 2 3>,      ∘< 1 0 2 1>,
    4,          ∘< 6 2 7 3>,    ∘< 4 2 0 7 4>,
;
my $plan = @Test ÷ 3;

multi encode( [] --> List ) { die 'No input' }
multi encode( @clear where +* == 1 --> List ) { @clear }
multi encode( @clear --> List ) {
    my @value = do for (0,@clear).flat.rotor( 2 => -1) { $_[0] +^ $_[1] }
    @value.push: @value.shift;
    return  @value;
}

multi task( @encoded where * ~~ [], Int:D $key --> Array) { [$key,] }
multi task( Int @encoded is copy, Int:D $key --> Array) {
    my Int @ret.append: $key;
    while @encoded { @ret.push: @ret.tail +^ @encoded.shift }
    @ret;
}
my $t = 10;
plan 2 × @Test ÷ 3 + $t;

my &decode = &task;

for @Test -> $key, @in, @clr {
    is decode( @in, $key ), @clr, "@clr.raku() <- $key ∘ @in[]";
    is encode( @clr), (@in, $key).flat, 'and back';
}

for ^$t { 
        my Int @clear = (-10^..^10).roll: (3...7).roll;
        my Int @coded = encode( @clear);
        my $k = @coded.pop;
        is decode( @coded, $k), @clear, "@clear[] <- $k ∘ @coded[]";
}
done-testing;

my Int @encoded = (-3, 6, 2, 7, 3, -7);
my $initial = 4;
say "\nInput: @encoded = @encoded[], \$initial = $initial\n"
    ~ "Output: ", task @encoded,$initial ;

