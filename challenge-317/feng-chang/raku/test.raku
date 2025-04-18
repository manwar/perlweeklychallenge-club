#!/bin/env raku

# The Weekly Challenge 317
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

# Task 1, Acronyms
pwc-test './ch-1.raku', <Perl Weekly Challenge>, 'PWC', 'True',  'Acronyms: @array = <Perl Weekly Challenge>, $word ="PWC" => true';
pwc-test './ch-1.raku', <Bob Charlie Joe>,       'BCJ', 'True',  'Acronyms: @array = <Bob Charlie Joe>,       $word ="BCJ" => true';
pwc-test './ch-1.raku', <Morning Good>,          'MM',  'False', 'Acronyms: @array = <Morning Good>,          $word ="MM"  => false';

# Task 2, Friendly Strings
pwc-test './ch-2.raku', <desc dsec>,     'True',  'Friendly Strings: $str1 = "desc",   $str2 = "dsec"   => true';
pwc-test './ch-2.raku', <fuck fcuk>,     'True',  'Friendly Strings: $str1 = "fuck",   $str2 = "fcuk"   => true';
pwc-test './ch-2.raku', <poo eop>,       'False', 'Friendly Strings: $str1 = "poo",    $str2 = "eop"    => false';
pwc-test './ch-2.raku', <stripe sprite>, 'True',  'Friendly Strings: $str1 = "stripe", $str2 = "sprite" => true';
