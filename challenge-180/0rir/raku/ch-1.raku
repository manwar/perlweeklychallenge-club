#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;
constant TEST=False;

=begin comment
Task 1: First Unique Character      Submitted by: Mohammad S Anwar

Given a string, $s, find the first unique character in the
string and print its index (0-based).

Examples:
Input: $s = "Perl Weekly Challenge"
Output: 0 as 'P' is the first unique character

Input: $s = "Long Live Perl"
Output: 1 as 'o' is the first unique character
=end comment

sub first-unique-char ( Str $s is copy, Bool :$i --> Int ) {
    $s = $s.fc if $i;
    my $b = Bag.new:   my @c = $s.comb();
    @c.first( { $b{$_} === 1}, :k );
}

if TEST {
    my @Test = 
        { in => 'abcdeA',        exp => 0, iexp =>  1 },
        { in => 'abcdeabcD',     exp => 3, iexp =>  4 },
        { in => 'abcddefabcEfg', exp => 5, iexp => 12 },
    ;

    plan 2 × @Test.elems;
    for @Test -> %t {
        is first-unique-char(%t<in>),      %t<exp>, "%t<in>";
        is first-unique-char(%t<in>, :i ), %t<iexp>, "%t<in> :i";
    }
    done-testing;
    exit;
}

sub MAIN( Str $s = 'Raku Yearly Challenge' ) {
    my $k = first-unique-char($s);
    say qq{Input: \$s = "$s"\n},
        qq{Output: $k as '$s.substr($k, 1)' is the first unique character};
    $k = first-unique-char($s, :i );
    say qq{Or    : $k as '$s.substr($k, 1)' is 1st if case is ignored.};
}

