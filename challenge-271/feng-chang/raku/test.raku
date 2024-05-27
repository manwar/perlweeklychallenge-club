#!/bin/env raku

# The Weekly Challenge 271
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Maximum Ones
pwc-test './ch-1.raku', '[0,1],[1,0]',       1, 'Maximum Ones: [[0,1],[1,0]]       => 1';
pwc-test './ch-1.raku', '[0,0,0],[1,0,1]',   2, 'Maximum Ones: [[0,0,0],[1,0,1]]   => 2';
pwc-test './ch-1.raku', '[0,0],[1,1],[0,0]', 2, 'Maximum Ones: [[0,0],[1,1],[0,0]] => 2';

# Task 2, Sort by 1 Bits
pwc-test './ch-2.raku', <0 1 2 3 4 5 6 7 8>,   '0 1 2 4 8 3 5 6 7',   'Sort by 1 Bits: @ints=(0,1,2,3,4,5,6,7,8)   => (0,1,2,4,8,3,5,6,7)';
pwc-test './ch-2.raku', <1024 512 256 128 64>, '64 128 256 512 1024', 'Sort by 1 Bits: @ints=(1024,512,256,128,64) => (64,128,256,512,1024)';
