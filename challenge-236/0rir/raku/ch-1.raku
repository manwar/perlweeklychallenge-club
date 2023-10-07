#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
236-1: Exact Change         Submitted by: Mohammad S Anwar
You are asked to sell juice each costs $5. You are given an array of bills. You can only sell ONE juice to each customer but make sure you return exact change back. You only have $5, $10 and $20 notes. You do not have any change in hand at first.

Write a script to find out if it is possible to sell to each customers with correct change.

Example 1
Input: @bills = (5, 5, 5, 10, 20)
Output: true

From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.
Example 2
Input: @bills = (5, 5, 10, 10, 20)
Output: false

From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bill.
For the last customer, we can not give the change of $15 back because we only have two $10 bills.
Since not every customer received the correct change, the answer is false.
Example 3
Input: @bills = (5, 5, 5, 20)
Output: true

=end comment

my @Test =
    (5, 5, 5, 20),                  True,
    (5, 5, 10, 10, 20),             False,
    (5, 5, 5, 10, 20),              True,

    (10,),                          False,
    (20,),                          False,
    (5,5,5,5,5,5,10,20,20,20),      False,
    (5,5,5,5,5,5,5,10,20,20),       True,
    (5,10),                         True,
    (5,5,5,5,5,5,10,20,20),         True,
    (5,5,5,5,5,5,10,20,10,10),      True,
;
plan @Test ÷ 2;


# Return True if correct change can be given all customers, else False.
# We have a juice bar and no cash on hand (cash only exists as 5s, 10s,
# and 20s. All sales are for 1 juice @ 5.  The @a array is an ordered
# sequence of th𝑒 bills the customers present.

sub func( @a --> Bool ) {                           # ?
    my UInt %h =  5 => 0, 10 => 0, 20 => 0;
    for @a {
        when 5 { ++ %h<5> }
        when 10 {
            return False unless %h<5> > 0;
            -- %h<5>;
            ++ %h<10>;
        }
        when 20 {
            return False if %h<5> == 0;
            when %h<10> > 0 {
                -- %h<5>;
                -- %h<10>;
            }
            return False unless %h<5> > 2;
            %h<5> -= 3;
            ++ %h<20>;
        }
    }
    True;
}

for @Test -> @in, $exp {
    is func(@in), $exp, "$exp <- @in.raku()";
}
my @bill = (5,5,5,5,5,5,10,20,10,10);
say "\nInput: @bill = @bill.raku()\nOutput: &func(@bill)";

done-testing;
exit;

