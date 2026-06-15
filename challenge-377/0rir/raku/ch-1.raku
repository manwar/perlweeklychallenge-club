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
    when $a.chars ≤  1  { False }
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

# do Benchmarks?

my $timeout-seconds = 5;
my $input-promise = start { prompt "For Benchmarks Enter y in 5 seconds: " };
my $timeout-promise = Promise.in($timeout-seconds);

await Promise.anyof($input-promise, $timeout-promise);

if $input-promise.status == Kept {
    my $user-input = $input-promise.result;
    say "Running benchmarks:";
} else {
    say "Done!";
    exit;
}

# For each implementation, bench against 26 and 2600 chars Strs, with a single reversable.
my $b = Bench.new;

my $abc = ('a'...'z').join;
my ($short-ct, $long-ct) = 5000, 1000;                   # Bench repetitions
my $mult = 100;

my $s-len = $abc.chars;
my $l-len = $s-len × $mult;

my $short-worst = $abc;
my $long-worst  = $abc x $mult;
$long-worst  ~~ s/ yz $ / zz /;
$short-worst ~~ s/ yz $ / zz /;

my $short-mid = "abcdefghijkl" ~ "XX" ~ "opqrstuvwxyz";
my $long-mid =  "abcdefghijklmnopqrstuvwxyz" xx $mult div 2;
$long-mid ~~ s/ z $/ a /;
$long-mid ~= "abcdefghijklmnopqrstuvwxyz" xx $mult div 2;

say "\nWorst case";
$b.cmpthese($short-ct, {
  ('regx-short'  ~ $s-len) => sub { task-regx  $short-worst },
  ('str-short'   ~ $s-len) => sub { task-str   $short-worst },
  ('arry-short'  ~ $s-len) => sub { task-arry  $short-worst },
  ('brief-short' ~ $s-len) => sub { task-brief $short-worst },
});

say "\nWorst case";
$b.cmpthese($long-ct, {
  ('regx-long'  ~ $l-len) => sub { task-regx  $long-worst },
  ('str-long'   ~ $l-len) => sub { task-str   $long-worst },
  ('arry-long'  ~ $l-len) => sub { task-arry  $long-worst },
  ('brief-long' ~ $l-len) => sub { task-brief $long-worst },
});

say "\nMid case";
$b.cmpthese($short-ct, {
  ('regx-short'  ~ $s-len) => sub { task-regx(  $short-mid); },
  ('str-short'   ~ $s-len) => sub { task-str(   $short-mid); },
  ('arry-short'  ~ $s-len) => sub { task-arry(  $short-mid); },
  ('brief-short' ~ $s-len) => sub { task-brief( $short-mid); },
});

say "\nMid case";
$b.cmpthese($long-ct, {
  ('regx-long'  ~ $l-len) => sub { task-regx(  $long-mid); },
  ('str-long'   ~ $l-len) => sub { task-str(   $long-mid); },
  ('arry-long'  ~ $l-len) => sub { task-arry(  $long-mid); },
  ('brief-long' ~ $l-len) => sub { task-brief( $long-mid); },
});
