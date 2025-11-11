#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
147-Task 2: Format Phone Number         Submitted by: Mohammad Sajid Anwar
You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

1. Removing all spaces and dashes
2. Grouping digits into blocks of length 3 from left to right
3. Handling the final digits (4 or fewer) specially:
   - 2 digits: one block of length 2
   - 3 digits: one block of length 3
   - 4 digits: two blocks of length 2
4. Joining all blocks with dashes

=end comment

my @Test =
    '12',               '12',
    '1 2',              '12',
    '1 2 -  3 4',         '12-34',
    "1-23-45-6",        "123-456",
    "1234",             "12-34",
    "12 345-6789",      "123-456-789",
    "123 4567",         "123-45-67",
    "123 456-78",       "123-456-78",
;
my @Dead = ' -1', '', ' ', '1', '1+1';
plan +@Dead + +@Test ÷ 2;

sub task( Str:D $a is copy where / ^ [ <[- 0..9]> | ' ' ]+ $ / -->Str:D) {
    my @w = $a.trans( [0..9] => '', :complement).comb;
    die "Multiple digits required got '$a'" if @w < 2;
    given +@w {
        when 2 { return @w.join }
        when 4 { return (@w[0..1].join, @w[2..3].join).join: '-' }
        default {
            @w.=rotor( 3, :partial);
            if  1 == +@w[*-1] { @w[*-1].=Array.unshift: @w[*-2].=Array.pop; }
            return (@w».join).join: '-';
        }
    }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in";
}
for @Dead -> $in {
    dies-ok { task( $in) }, "$in.raku() dies";
}
done-testing;

my $phone = "123 456-78";
say qq{\nInput: \$phone = "$phone"\nOutput: "&task($phone)"};

