#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment

231-2: Senior Citizens          Submitted by: Mohammad S Anwar
Given a list of passenger details in the form “9999999999A1122”, where
9 denotes the phone number, A the sex, 1 the age and 2 the seat number;
return the count of all senior citizens (age >= 60).

Example 1

The age of the passengers in the given list are 75, 92 and 40.
So we have only 2 senior citizens.
Example 2
Input: @list = ("1313579440F2036","2921522980M5644")
Ouput: 0
=end comment

my @Test =
    2, ("7868190130M7522","5303914400F9211","9273338290F4010"),
    0, ("1313579440F2036","2921522980M5644")
;
plan @Test ÷ 2;

sub func( @l) {
    my $ret = 0;
    for @l { m/ (\d\d)..$/; ++ $ret if +$0 ≥ 60; }
    $ret;
}

for @Test -> $exp, @in {
    is func(@in), $exp, "$exp <- @in.raku()";
}
done-testing;

my @list = ("7868190130M7522","5303914400F9211","9273338290F4010");

say "\n\nInput: @list = @list[]\nOutput: ", func(@list);

