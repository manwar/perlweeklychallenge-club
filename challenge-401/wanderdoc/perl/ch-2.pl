#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing an out-of-order English representation of digits 0-9.

Write a script to return the digits in ascending order.
Example 1

Input: $str = "zroezerotwowtwotwo"
Output: "00222"

'z' appears two times => two "zero"
'w' appears three times => three "two"

Example 2

Input: $str = "esveeneinght"
Output: "78"

'g' appears one time => one "eight"
Removing the letters of "eight" leaves "esveen".
Now 'v' appears one time => one "seven"

Example 3

Input: $str = "oneenineeninefive"
Output: "1599"

'f' appears one time => one "five"
After removing "five", 'o' appears one time => one "one".
The remaining letters are "ninenine", where 'i' appears two times => two "nine".

Example 4

Input: $str = "zeroonetwothreeeightfivesixsevenninefour"
Output: "0123456789"

The input contains the scrambled letters of every single digit from 0 through 9 exactly once:
"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine".

Example 5

Input: $str = "ninenineninenine"
Output: "9999"

Character counts: 'n' = 8, 'i' = 4, 'e' = 4.
Every set of letters matches "nine", giving four 9s.

=cut







use Test2::V0 -no_srand => 1;

is(scrambled_digits("zroezerotwowtwotwo"), "00222", "Example 1");
is(scrambled_digits("esveeneinght"), "78", "Example 2");
is(scrambled_digits("oneenineeninefive"), "1599", "Example 3");
is(scrambled_digits("zeroonetwothreeeightfivesixsevenninefour"), "0123456789", "Example 4");
is(scrambled_digits("ninenineninenine"), "9999", "Example 5");
done_testing();


sub scrambled_digits
{
     my $str = lc $_[0];
     my @output;
     
     # first with unique letters: z w x g
     while ( $str =~ /z/ and $str =~ /e/ and $str =~ /r/ and $str =~ /o/ ) # zero
     {
          $str =~ s/z//;
          $str =~ s/e//;
          $str =~ s/r//;
          $str =~ s/o//;
          push @output, 0;
     }
     while ( $str =~ /t/ and $str =~ /w/ and $str =~ /o/) # two
     {
          $str =~ s/t//;
          $str =~ s/w//;
          $str =~ s/o//;
          push @output, 2;
     }
     while ( $str =~ /s/ and $str =~ /i/ and $str =~ /x/ ) # six
     {
          $str =~ s/s//;
          $str =~ s/i//;
          $str =~ s/x//;
          push @output, 6;
     }
     while ( $str =~ /e/ and $str =~ /i/ and $str =~ /g/ and $str =~ /h/ 
          and $str =~ /t/) # eight
     {
          $str =~ s/e//;
          $str =~ s/i//;
          $str =~ s/g//;
          $str =~ s/h//;
          $str =~ s/t//;
          push @output, 8;
     }

     # then with letter count: three, seven, nine
     while ( $str =~ /t/ and $str =~ /h/ and $str =~ /r/ and $str =~ /e/
          and ($str =~ tr/e/e/) > 1) # three
     {
          $str =~ s/t//;
          $str =~ s/h//;
          $str =~ s/r//;
          $str =~ s/e//;
          $str =~ s/e//;
          push @output, 3;
     }

     while ( $str =~ /s/ and $str =~ /e/ and $str =~ /v/ and $str =~ /n/ 
          and ($str =~ tr/e/e/) > 1) # seven
     {
          $str =~ s/s//;
          $str =~ s/e//;
          $str =~ s/v//;
          $str =~ s/e//;
          $str =~ s/n//;
          push @output, 7;
     }


     while ( $str =~ /n/ and $str =~ /i/ and $str =~ /e/ and 
          ($str =~ tr/n/n/) > 1) # nine
     {
          $str =~ s/n//;
          $str =~ s/i//;
          $str =~ s/n//;
          $str =~ s/e//;
          push @output, 9;
     }
     
     # then the rest with nonunique letters
     
     while ( $str =~ /o/ and $str =~ /n/ and $str =~ /e/ ) # one
     {
          $str =~ s/o//;
          $str =~ s/n//;
          $str =~ s/e//;
          push @output, 1;
     }


     
     
     while ( $str =~ /f/ and $str =~ /o/ and $str =~ /u/ and $str =~ /r/ ) # four
     {
          $str =~ s/f//;
          $str =~ s/o//;
          $str =~ s/u//;
          $str =~ s/r//;
          push @output, 4;
     }
     while ( $str =~ /f/ and $str =~ /i/ and $str =~ /v/ and $str =~ /e/ ) # five
     {
          $str =~ s/f//;
          $str =~ s/i//;
          $str =~ s/v//;
          $str =~ s/e//;
          push @output, 5;
     }     

     # print "<$str>$/";
     return join("", sort { $a <=> $b } @output);
}
