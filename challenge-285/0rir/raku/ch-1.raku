#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
285-1: No Connection        Submitted by: Mohammad Sajid Anwar

You are given a list of routes, @routes.  Write a script to find the destination with no further outgoing connection.
Example 1
Input: @routes = (["B","C"], ["D","B"], ["C","A"])
Output: "A"

"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".
Example 2
Input: @routes = (["A","Z"])
Output: "Z"

=end comment

=begin comment
The routes are not bidirectional or 'D' would be an answer in the
first example.
It is not clear that route lists are constrained to two elements.
But the question suggests that any intersection of paths defines
a end-point for all routes intersecting.
=end comment

my @Test =
    (<B C>, <D B>, <C A>),          ("A"),
    (<A Z>,),                       ("Z"),
    (<A a b c Z>,),                 ("Z"),
    (<A D>, <B C>, <D B>, <C A>),   (),
    (< A>, < A>),                   (),
    (<A Z>, <Z A>),                 (),
    (<A Z>, <B Z>),                 "Z",
    (<A Z>, <B C>),                 <Z  C>.sort,
    (<A B>, <B C>, <B D>, <B E>, <E F>),
                                    <C D F>.sort,
    ;

plan @Test ÷ 2;

only task( List:D $a --> List) {
    my @head = @$a.map( *.[0]);
    my @tail = @$a.map( *.[*-1]);
    (@tail ∖ @head).keys.List;
}

for @Test -> $in, $exp {
    is task($in).sort, $exp, "$exp <- $in.raku()";
}

done-testing;

my @route = (["B","C"], ["D","D"], ["D","E"], ["F","G"]);

say "\nInput: @routes = @route.raku()\nOutput: { task @route }";


