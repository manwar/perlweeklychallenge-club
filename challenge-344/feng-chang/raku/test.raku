#!/bin/env raku

# The Weekly Challenge 343
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

# Task 1, Array Form Compute
pwc-test './ch-1.raku', <1 2 3 4 12>,     '1 2 4 6',   'Array Form Compute: (1,2,3,4),12     => (1,2,4,6)';
pwc-test './ch-1.raku', <2 7 4 181>,      '4 5 5',     'Array Form Compute: (2,7,4),181      => (4,5,5)';
pwc-test './ch-1.raku', <9 9 9 1>,        '1 0 0 0',   'Array Form Compute: (9,9,9),1        => (1,0,0,0)';
pwc-test './ch-1.raku', <1 0 0 0 0 9999>, '1 9 9 9 9', 'Array Form Compute: (1,0,0,0,0),9999 => (1,9,9,9,9)';
pwc-test './ch-1.raku', <0 1000>,         '1 0 0 0',   'Array Form Compute: (0),1000         => (1,0,0,0)';

# Task 2, Array Formation
pwc-test './ch-2.raku', '[2,3],[1],[4]',   '1,2,3,4',   'True',  'Array Formation: @source=[2,3],[1],[4],   @target=(1,2,3,4)   => true';
pwc-test './ch-2.raku', '[1,3],[2,4]',     '1,2,3,4',   'False', 'Array Formation: @source=[1,3],[2,4],     @target=(1,2,3,4)   => false';
pwc-test './ch-2.raku', '[9,1],[5,8],[2]', '5,8,2,9,1', 'True',  'Array Formation: @source=[9,1],[5,8],[2], @target=(5,8,2,9,1) => true';
pwc-test './ch-2.raku', '[1],[3]',         '1,2,3',     'False', 'Array Formation: @source=[1],[3],         @target=(1,2,3)     => false';
pwc-test './ch-2.raku', '[7],[4],[6]',     '7,4,6',     'True',  'Array Formation: @source=[7],[4],[6],     @target=(7,4,6)     => true';
