#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Bench;
use Test;

=begin comment
May be edited for space.
377-1: Reverse Existence            Submitted by: Mohammad Sajid Anwar
You are given a string.  Write a script to find whether any substring
of length 2 is also present in the reverse of the given string.
=end comment

my @Test =
    "abcba",        True,
    "racecar",      True,
    "abcd",         False,
    "banana",       True,
    "hello",        True,
    "ll",           True,
    'xy',           False,
;
plan +@Test × 2;

sub task-brief( Str:D() $a where *.chars > 1 -->Bool:D) {
    my @r = ($a.comb( 2 )».flip).unique;
    so $a.contains: @r.any;
}
sub task-regx( Str:D() $a where *.chars > 1 -->Bool:D) {
     so $a ~~ m/ (.)  {} :my $zed = $0;
                 [ $zed ||  . $zed ]
               /;
}

sub task-arry( Str:D() $a where *.chars > 1 -->Bool:D) {
    my @a = $a.comb;
    when @a.elems ≤  1 {  False }
    when @a.elems == 2  {
        return @a[0] eq @a[1] ?? True !! False
    }
    my $idx = 0;
    while $idx < @a - 2 {
        return True if @a[$idx]  eq @a[$idx +1]     #center
                    or @a[$idx]  eq @a[$idx +2];    #right
        $idx +=1;
    }
    False;
}


sub task-str( Str:D() $a where $a.chars > 1 -->Bool:D) {
    when $a.chars ≤  1 {  False }
    when $a.chars == 2  {
        return $a.substr(0,1) eq $a.substr(1,1) ?? True !! False
    }
    my $ori = 0;
    while $ori < $a.chars -2 {                  # implicit 3 char window
        my $left   = $a.substr( $ori, 1  );
        return True if $left  eq $a.substr( $ori +1, 1)   #center
                    or $left  eq $a.substr( $ori +2, 1);   #right
        $ori +=1;
    }
    False;
}

for @Test -> $in, $exp {
    is task-regx(  $in), $exp, "str   $exp <- $in.raku()";
    is task-str(   $in), $exp, "str   $exp <- $in.raku()";
    is task-arry(  $in), $exp, "arry  $exp <- $in.raku()";
    is task-brief( $in), $exp, "brief $exp <- $in.raku()";
}
done-testing;

my $str = "abcdefghijklmnopqrstvvwxyz";
say qq{\nInput: \$str = "$str"\nOutput: }, task-arry( $str);


# Benchmarks? -------------------------
my $timeout-seconds = 5;
my $input-promise = start { prompt "For Benchmarks Enter y in 5 seconds: " };
my $timeout-promise = Promise.in($timeout-seconds);

await Promise.anyof($input-promise, $timeout-promise);

if $input-promise.status == Kept {
    my $user-input = $input-promise.result;
    say "Running benchmarks:";
} else {
    say "Exiting";
    exit;
}

# For each implementation, bench against 26 and 2600 chars Strs, with a single
my $b = Bench.new;

my ($short, $long) = 5000, 1000;                   # Bench repetitions
my $short-str = "abcdefghijklmnopqrstuvwxzz";      
my $mult = 100;
my $long-str =  $short-str x $mult;
my $s-len = $short-str.chars;
my $l-len = $s-len × $mult;

say '--------------------------------------------------';
say "\nWorse case";
$b.cmpthese($short, {
  ('regx-short'   ~ $s-len) => sub { task-regx( $short-str); },
  ('str-short'   ~ $s-len) => sub { task-str(   $short-str); },
  ('arry-short'  ~ $s-len) => sub { task-arry(  $short-str); },
  ('brief-short' ~ $s-len) => sub { task-brief( $short-str); },
});
$long-str =  ('a'...'z').join x $mult;
$long-str ~~ s/.. $/ zz /;
$b.cmpthese($long, {
  ('regx-long'  ~ $l-len) => sub { task-regx(  $long-str); },
  ('str-long'   ~ $l-len) => sub { task-str(   $long-str); },
  ('arry-long'  ~ $l-len) => sub { task-arry(  $long-str); },
  ('brief-long' ~ $l-len) => sub { task-brief( $long-str); },
});
say '--------------------------------------------------';
say "\nMid case";
$long-str =  "abcdefghijklmnopqrstuvwxyz" xx $mult div 2
     ~ 'z' ~ "abcdefghijklmnopqrstuvwxyz" xx $mult div 2;
$short-str = "abcdefghijklnnopqrstuvwxyz";

$b.cmpthese($short, {
  ('regx-short'  ~ $s-len) => sub { task-regx( $short-str); },
  ('str-short'   ~ $s-len) => sub { task-str(   $short-str); },
  ('arry-short'  ~ $s-len) => sub { task-arry(  $short-str); },
  ('brief-short' ~ $s-len) => sub { task-brief( $short-str); },
});

say '--------------------------------------------------';
say "\nMid case";
$b.cmpthese($long, {
  ('regx-long'  ~ $l-len) => sub { task-regx(  $long-str); },
  ('str-long'   ~ $l-len) => sub { task-str(   $long-str); },
  ('arry-long'  ~ $l-len) => sub { task-arry(  $long-str); },
  ('brief-long' ~ $l-len) => sub { task-brief( $long-str); },
});
