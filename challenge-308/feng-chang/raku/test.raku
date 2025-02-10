#!/bin/env raku

# The Weekly Challenge 308
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

# Task 1, Count Common
pwc-test './ch-1.raku', 'perl weekly challenge', 'raku weekly challenge', 2,
    'Count Common: @str1=<perl weekly challenge>, @str2=<raku weekly challenge> => 2';
pwc-test './ch-1.raku', 'perl raku python', 'python java', 1,
    'Count Common: @str1=<perl raku python>,      @str2=<python java>           => 1';
pwc-test './ch-1.raku', 'guest contribution', 'fun weekly challenge', 0,
    'Count Common: @str1=<guest contribution>,    @str2=<fun weekly challenge>  => 0';

# Task 2, Decode XOR
pwc-test './ch-2.raku', <1 2 3>,   1, '1 0 2 1',   'Decode XOR: @encoded=<1 2 3>,   $initial=1 => 1,0,2,1';
pwc-test './ch-2.raku', <6 2 7 3>, 4, '4 2 0 7 4', 'Decode XOR: @encoded=<6 2 7 3>, $initial=4 => 4,2,0,7,4';
