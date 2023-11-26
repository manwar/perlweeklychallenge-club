#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
242-1: Missing Members              Submitted by: Mohammad S Anwar

You are given two arrays of integers.
Write a script to find out the missing members in each other arrays.

Example 1
Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
Example 2
Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
(1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
=end comment

=begin comment
Often, I resist the idea that a string is the desired output.  The given
output is ambiguous for example 2, i.e. the @ary1 and @ary2 could be in
@ary2, @ary1 order.

=end comment

my @Test =
    # @a            @b              @exp                @exp-shortened
    (1, 2, 3),      (2, 4, 6),      ((1, 3), (4, 6)),   ((1, 3), (4, 6),),
    (1, 2, 3, 3),   (1, 1, 2, 2),   ((3,),()),          ((3,),),
    (1, 1, 2, 2),   (1, 2, 3, 3),   ((), (3,)),         ((3,)),
    (1, 1, 2, 2),   (1, 1, 2, 2),   ((),()),            (),
    (),             (1,),           ((), 1),            (1,),
    (1,),           (),             (1, ()),            (1,),
    (),             (),             ((),()),            (),
    ;

plan @Test ÷ 2;

# the logical change
sub l-and-r-oj( @a, @b ) {      # oj ~ outer join
    ((@a (-) @b).keys.sort.List // () ),                # Empty is a Slip ?
            ((@b (-) @a).keys.sort.List // () );
}

# the presentation
sub delete-empty( @l-and-r is copy --> List) {
    if @l-and-r[1] ~~ ()  { @l-and-r.pop }
    if @l-and-r[0] ~~ ()  { @l-and-r.shift }
    @l-and-r;
}


for @Test -> @a, @b, @exp, @exp-shortened {
    is l-and-r-oj(@a, @b), @exp, 'test';
    is delete-empty(l-and-r-oj(@a, @b)), @exp-shortened, 'test';
}
done-testing;

my @arr1 = (1, 2, 3, 3);
my @arr2 = (1, 1, 2, 2);
say "\nInput: @arr1 = @arr1.raku()\n       @arr2 = @arr2.raku()\nOutput = ",
    delete-empty(l-and-r-oj(@arr1, @arr2));
exit;
