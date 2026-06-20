#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
378-1: Second Largest Digit         Submitted by: Mohammad Sajid Anwar
You are given an alphanumeric string.

Write a script to find the second largest distinct digit in the given string. Return -1 if none found.
=end comment

my @Test =
    "aaaaa77777",           Int,
    "abcde",                Int,
    "9zero8eight7seven9",    8,
    "xyz9876543210",         8,
    "4abc4def2ghi8jkl2",     4,
    "9",                    Int,
    "0",                    Int,
    "1" ~ "abc" x 90 ~ 1,   Int,
    "1" ~ "abc" x 90 ~ 9,    1,
;
plan +@Test × 4 ÷ 2;

sub task( Str:D() $a -->Int) {
    given $a.comb.unique.grep( / <:Nd> /).sort[ *-2] {
        when ! .defined { Int  }
        .Int;
    }
}

sub task-set( Str:D() $a -->Int) {
#   my @a = ($a.comb.unique.grep: / <:Nd> /);
    my @a = $a.comb;
    my $max;
    for 9...0 -> \t {
        if t.Str ∈ @a {
            $max = t.Int;
            last;
        }
    }
    return Int if !$max.defined or $max == 0;
    for $max^...1 -> \t {
        return t.Int if t.Str ∈ @a;
    }
    Int;
}

sub task-any( Str:D() $a -->Int) {
    my @a = ($a.comb.unique.grep: / <:Nd> /);
    my $max;
    for 9...0 -> \t {
        with @a.first( :k, t) {
            $max = t.Int;
            last;
        }
    }
    return Int if !$max.defined or $max == 0;
    for $max^...1 -> \t{
            return t.Int with @a.first( :k, t);
    };
    Int;
}

sub task-str( Str:D() $a -->Int) {
    my $max;
    for 9...0 {
        if $a.contains: $_ {
            $max = $_.Int;
            last;
        }
    }
    return Int if !$max.defined or $max == 0;
    for $max^...1 {
            return $_.Int if $a.contains: $_;
    };
    Int;
}

for @Test -> $in, $exp {
    is task(     $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-set( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-any( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-str( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "9z8e7s9";
say qq{\nInput: \$str = "$str"\nOutput: }, task $str;

print "\n";

use Bench;
my $b = Bench.new;

$b.cmpthese(200, {
   set        => sub { task-any( "1" ~ "abc" x 500 ~ 9, );
                       task-any( "1" ~ "abc" x 500 ~ 1, );
          },
  any         => sub { task-any( "1" ~ "abc" x 500 ~ 9, );
                       task-any( "1" ~ "abc" x 500 ~ 1, );
          },
  str-contain => sub { task-str( "1" ~ "abc" x 500 ~ 9, );
                       task-str( "1" ~ "abc" x 500 ~ 1, );
          },
  task        => sub { task(     "1" ~ "abc" x 500 ~ 9, );
                       task(     "1" ~ "abc" x 500 ~ 1, );
          },
});
