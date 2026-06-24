#!/bin/env raku

# The Weekly Challenge 379
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

# Task 1, Reverse String
pwc-test './ch-1.raku', '', '',
    'Reverse String: "" => ""';
pwc-test './ch-1.raku', 'reverse the given string', 'gnirts nevig eht esrever',
    'Reverse String: "reverse the given string" => "gnirts nevig eht esrever"';
pwc-test './ch-1.raku', 'Perl is Awesome', 'emosewA si lreP',
    'Reverse String: "Perl is Awesome" => "emosewA si lreP"';
pwc-test './ch-1.raku', 'v1.0.0-Beta!', '!ateB-0.0.1v',
    'Reverse String: "v1.0.0-Beta!" => "!ateB-0.0.1v"';
pwc-test './ch-1.raku', 'racecar', 'racecar',
    'Reverse String: "racecar" => "racecar"';

# Task 2, Armstrong Number
pwc-test './ch-2.raku', 10, 1000, '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407',
    'Armstrong Number: $base=10,$limit=1000 => "0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407"';
pwc-test './ch-2.raku', 7,  1000, '0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250',
    'Armstrong Number: $base=7,$limit=1000 => "0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250"';
pwc-test './ch-2.raku', 16, 1000, '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645',
    'Armstrong Number: $base=16,$limit=1000 => "0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645"';
pwc-test './ch-2.raku', 3,  1000, '0, 1, 2, 5, 8, 17',
    'Armstrong Number: $base=3,$limit=1000 => "0, 1, 2, 5, 8, 17"';
pwc-test './ch-2.raku', 4,  1000, '0, 1, 2, 3, 28, 29, 35, 43, 55, 62, 83, 243',
    'Armstrong Number: $base=4,$limit=1000 => "0, 1, 2, 3, 28, 29, 35, 43, 55, 62, 83, 243"';
pwc-test './ch-2.raku', 5,  1000, '0, 1, 2, 3, 4, 13, 18, 28, 118, 289, 353, 419',
    'Armstrong Number: $base=5,$limit=1000 => "0, 1, 2, 3, 4, 13, 18, 28, 118, 289, 353, 419"';
pwc-test './ch-2.raku', 6,  1000, '0, 1, 2, 3, 4, 5, 99, 190',
    'Armstrong Number: $base=6,$limit=1000 => "0, 1, 2, 3, 4, 5, 99, 190"';
pwc-test './ch-2.raku', 8,  1000, '0, 1, 2, 3, 4, 5, 6, 7, 20, 52, 92, 133, 307, 432, 433',
    'Armstrong Number: $base=8,$limit=1000 => "0, 1, 2, 3, 4, 5, 6, 7, 20, 52, 92, 133, 307, 432, 433"';
pwc-test './ch-2.raku', 9,  1000, '0, 1, 2, 3, 4, 5, 6, 7, 8, 41, 50, 126, 127, 468, 469',
    'Armstrong Number: $base=9,$limit=1000 => "0, 1, 2, 3, 4, 5, 6, 7, 8, 41, 50, 126, 127, 468, 469"';
