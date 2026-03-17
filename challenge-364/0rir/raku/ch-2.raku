#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
364-2: Goal Parser          Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to interpret the given string using Goal Parser.

The Goal Parser interprets “G” as the string “G”, “()” as the string “o”, and “(al)” as the string “al”. The interpreted strings are then concatenated in the original order.

=end comment

my @Test =
    # in                exp
    "G()(al)",          "Goal",
    "G()()()()(al)",    "Gooooal",
    "(al)G(al)()()",    "alGaloo",
    "()G()G",           "oGoG",
    "(al)(al)G()()",    "alalGoo",
;
plan +@Test ÷ 2;

grammar Goal {
    rule TOP    { ^ <Char>+ $ }
    token Char  { [ <Gee> | <Pare> | <Al> ] }
    token Gee   { 'G'  }
    token Pare  { '()' }
    token Al    { '(al)' }
}
class Goal-str{
    method TOP($/)   { make ($/.values».made).join }
    method Char($/)  { make $/.values[0].made      }
    method Gee($/)   { make 'G'                    }
    method Pare($/)  { make 'o'                    }
    method Al($/)    { make 'al'                   }
}

sub task( Str:D() $a -->Str:D) {
    my $actions = Goal-str;
    my $m = Goal.parse( $a, :$actions );
    $m.made;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "(al)G()(al)(al)()G(al)";
say qq{\nInput: \$str = "$str"\nOutput: }, task( $str);
