#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
209-1: Special Bit Characters       Submitted by: Mohammad S Anwar
Given an array of binary bits that ends with 0.

Valid sequences in the bit string are:
[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c"

Write a script to print 1 if the last character is an “a” otherwise print 0.

Example 1
Input: @bits = (1, 0, 0)
Output: 1

The given array bits can be decoded as 2-bits character (10) followed by 1-bit character (0).
Example 2

Input: @bits = (1, 1, 1, 0)
Output: 0

Possible decode can be 2-bits character (11) followed by 2-bits character (10) i.e. the last character is not 1-bit character.

=end comment

=begin comment
A […,0,0] indicates a final 'a'.
A […,1,0] is ambiguous. That _one_ can be considered the end of a sequence of
ones. The sequence's length being odd or even, determines if the one belongs
to a final 'b' or a penultimate 'c'.
=end comment

constant $V-end = 'a';

my @Data = do for 1..10000 {
    my $w = .base(3);
    ($w ~~ tr/0..2/a..c/).Str;
}

# validate input word
sub abc-a-valid( $str --> Bool ) {
    so $str ~~ / ^ <[abc]>* $V-end $/;
}

# convert a test word to array of 1's and 0's
sub abc-encode( $str is copy --> Array ) {
    $str.=subst( 'c', '11', :g);
    $str.=subst( 'b', '10', :g);
    $str.=subst( 'a',  '0', :g);
    $str.comb.Array;
}

enum State <SizeQ Small Large DoneQ Done>;

# For empirical verification. Not the solution.
sub abc-decode ( @bit --> Str ) {

    # STATE vars
    my $return;
    my $idx = 0;

    my %transition  = 
        SizeQ => -> { @bit[$idx] == 0 ?? "Small" !! "Large" },  # First state.
        Small => -> { $return ~= 'a';  ++$idx; "DoneQ" },
        Large => -> { 
            $return ~= @bit[$idx+1] == 0 ?? 'b' !! 'c';
            die 'ilformed input' if $idx > @bit.end;
            $idx += 2;
            'DoneQ';
        },
        DoneQ => -> { if $idx ≤ @bit.end { "SizeQ" } else { 'Done' }},
        Done  => "End marker for the state machine.",
    ;

    my $state = 'SizeQ';
    while $state ne 'Done' {
        $state = %transition{$state}();
    }
    $return;
}

# calc correct answer
sub abc-expect( $str --> Bool) {
    when $str ~~ / a $/  { True  }
    False;
}

multi sub ends-with-a( @bit where @bit.end < 3 --> Bool ) {
    given @bit { 
            # a, aa, ba, aaa, ca
        when [[0],   [0,0], [1,0,0], [0,0,0], [1,1,0],].any { True }
            # b,  c, ab, a,c
        when [[1,0], [1,1], [0,1,0], [0,1,1],         ].any { False }
            # splat
        when [ [], [1], [0,1], [0,0,1], [1,0,1], [1,1,1],].any { fail }
    }
}

multi sub ends-with-a( @bit --> Bool ) {

    fail if @bit.tail ≠ 0;

    return True if @bit[*-2] == 0;

    return so (
         @bit.end - 1
        -
        ( @bit[0..*-2].first( * !~~ 1, :k, :end) // -1)
    ) %% 2;
}

my @Test = @Data.grep: *  ~~ / a $ /;

plan 2 × @Test;

for @Test -> $in {
    my $exp = abc-expect( $in);
    my @bit = abc-encode( $in);
    my $uncode = abc-decode( @bit);
    is $uncode, $in, "$in to bits and back";
    is ends-with-a(@bit), $exp, "$uncode -> @bit[] -> $exp";
}
done-testing;

my @bit = 1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1, 0;

say "\nInput: @bits = @bit[]\nOutput: ", &ends-with-a( @bit) ?? 1 !! 0;

exit;

