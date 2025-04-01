#!/bin/env raku

# The Weekly Challenge 314
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

# Task 1, Equal Strings
pwc-test './ch-1.raku', <abc abb ab>,  2,  'Equal Strings: $s1="abc", $s2="abb", $s3="ab"  => 2';
pwc-test './ch-1.raku', <ayz cyz xyz>, -1, 'Equal Strings: $s1="ayz", $s2="cyz", $s3="xyz" => -1';
pwc-test './ch-1.raku', <yza yzb yzc>, 3,  'Equal Strings: $s1="yza", $s2="yzb", $s3="yzc" => 3';

pwc-test './ch-1a.raku', <abc abb ab>,  2,  'Equal Strings: $s1="abc", $s2="abb", $s3="ab"  => 2';
pwc-test './ch-1a.raku', <ayz cyz xyz>, -1, 'Equal Strings: $s1="ayz", $s2="cyz", $s3="xyz" => -1';
pwc-test './ch-1a.raku', <yza yzb yzc>, 3,  'Equal Strings: $s1="yza", $s2="yzb", $s3="yzc" => 3';

# Task 2, Sort Column
pwc-test './ch-2.raku', <swpc tyad azbe>, 2, 'Sort Column: "swpc","tyad","azbe" => 2';
pwc-test './ch-2.raku', <cba daf ghi>,    1, 'Sort Column: "cba","daf","ghi"    => 1';
pwc-test './ch-2.raku', <a b c>,          0, 'Sort Column: "a","b","c"          => 0';
