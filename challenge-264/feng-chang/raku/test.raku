#!/bin/env raku

# The Weekly Challenge 264
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

# Task 1, Greatest English Letter
pwc-test './ch-1.raku', 'PeRlwEeKLy', 'L', 'Greatest English Letter: PeRlwEeKLy => L';
pwc-test './ch-1.raku', 'ChaLlenge',  'L', 'Greatest English Letter: ChaLlenge  => L';
pwc-test './ch-1.raku', 'The',        '',  'Greatest English Letter: The        => ""';

# Task 2, Target Array
pwc-test './ch-2.raku', '0,1,2,3,4', '0,1,2,2,1', '0 4 1 3 2',
    'Target Array: @source=(0,1,2,3,4), @indices= (0,1,2,2,1) => (0,4,1,3,2)';
pwc-test './ch-2.raku', '1,2,3,4,0', '0,1,2,3,0', '0 1 2 3 4',
    'Target Array: @source=(1,2,3,4,0), @indices= (0,1,2,3,0) => (0,1,2,3,4)';
pwc-test './ch-2.raku', 1, 0, '1',
    'Target Array: @source=(1),         @indices= (0)         => (1)';
