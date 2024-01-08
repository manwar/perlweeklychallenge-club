#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
250-2: Alphanumeric String Value        Submitted by: Mohammad S Anwar
You are given an array of alphanumeric strings.

Write a script to return the maximum value of alphanumeric string in the
given array.

The value of alphanumeric string can be defined as

a) The numeric representation of the string in base 10 if it is made up of digits only.
b) otherwise the length of the string

Example 1
Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
Output: 6

"perl" consists of letters only so the value is 4.
"2" is digits only so the value is 2.
"000" is digits only so the value is 0.
"python" consits of letters so the value is 6.
"r4ku" consists of letters and digits so the value is 4.
Example 2
Input: @alphanumstr = ("001", "1", "000", "0001")
Output: 1

=end comment

my @Test =
    ("001", "1", "000", "0001"),                1,
    ("perl", "2", "000", "python", "r4ku"),     6,
    ("perl", "200", "000", "python", "r4ku"),   200,
    ("me", "1", "001"),                         2,
;
my @Die =
    (),
    (""),
    ("", ""),
    ( "" xx 10).List,
;

plan @Die + @Test ÷ 2;

multi func( $a where * ~~ Empty ) { die "Empty list." }
multi func( $a where * eqv '' ) { die "Empty string." }
multi func( $a --> Int) {
    # my $r = ($a».&{ $_ ~~ / ^ \d+ $ / ?? .Int !! .chars }).max;
    # $r == -Inf ?? Int !! $r;
    my $r
        = ( $a».&{
            when / ^ <:L>+  $ /     { .chars }
            when / ^ <:Nd>+ $ /     { given .Int {
                                        when -Inf { Int } 
                                        $_;
                                    }
            }
            when  '' { die "Empty string." }
        }).max;
}

for @Test -> $in, $exp {
    is func($in), $exp, ($exp // "(Int)") ~ " <- $in";
}
for @Die -> $in {
    dies-ok { func($in) }, "Dies with: $in.raku()";
}

done-testing;
my @alphanumstr = ("perl", "2", "000", "python", "r4ku");

say "\nInput: @alphanumstr = @alphanumstr.raku()\nOutput: ",
        &func( @alphanumstr);
exit;

