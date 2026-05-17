#!/bin/env raku

# The Weekly Challenge 373
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

# Task 1, Equal List
pwc-test './ch-1.raku', '<a bc>',         '<ab c>',        'True',  'Equal List: @arr1=<a bc>,  @aar2=<ab c>          => true';
pwc-test './ch-1.raku', '<a b c>',        '<a bc>',        'True',  'Equal List: @arr1=<a b c>, @aar2=<a bc>          => true';
pwc-test './ch-1.raku', '<a bc>',         '<a c b>',       'False', 'Equal List: @arr1=<a bc>, @aar2=<a c b>          => false';
pwc-test './ch-1.raku', '"ab", "c", ""',  '"", "a", "bc"', 'True',  'Equal List: @arr1="ab","c","", @aar2="","a","bc" => true';
pwc-test './ch-1.raku', '<p e r l>',      '<perl>',        'True',  'Equal List: @arr1=<a bc>, @aar2=<a c b>          => true';

# Task 2, List Division
pwc-test './ch-2.raku', '1 2 3 4 5',            2, '(1,2,3),(4,5)',                  'List Division: @list=(1,2,3,4,5), $n=2            => (1,2,3),(4,5)';
pwc-test './ch-2.raku', '1 2 3 4 5 6',          3, '(1,2),(3,4),(5,6)',              'List Division: @list=(1,2,3,4,5,6), $n=2          => (1,2),(3,4),(5,6)';
pwc-test './ch-2.raku', '1 2 3',                2, '(1,2),(3)',                      'List Division: @list=(1,2,3), $n=2                => (1,2),(3)';
pwc-test './ch-2.raku', '1 2 3 4 5 6 7 8 9 10', 5, '(1,2),(3,4),(5,6),(7,8),(9,10)', 'List Division: @list=(1,2,3,4,5,6,7,8,9,10), $n=5 => (1,2),(3,4),(5,6),(7,8),(9,10)';
pwc-test './ch-2.raku', '1 2 3',                4, '-1',                             'List Division: @list=(1,2,3), $n=4                => -1';
