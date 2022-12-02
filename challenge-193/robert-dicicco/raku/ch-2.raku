#!/usr/bin/env raku

=begin comment

AUTHOR: Robert DiCicco

DATE: 2022-11-30

Challenge 193 Odd String ( Raku )

 

You are given a list of strings of same length, @s.

 

Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

 

Find the difference array for each string as shown in the example. Then pick the odd one out.

------------------------------------------------------------

SAMPLE OUTPUT

 

raku .\OddString.rk

Input: @n = [adc wzy abc]

Output: abc

 

Input: @n = [aaa bob ccc ddd]

Output: bob

 

=end comment

 

use v6;

 

my @ss = [["adc", "wzy", "abc"],["aaa", "bob", "ccc", "ddd"]];

my @out = [];

 

sub StringValue($mystr) {

  my $val1 = substr($mystr,1,1);

  my $val0 = substr($mystr,0,1);

  my $val2 = substr($mystr,2,1);

  my $x = ord($val1) - ord($val0);

  my $y = ord($val2) - ord($val1);

  push(@out, "$x:$y");

}

 

sub MAIN() {

  for @ss -> @n {

    put "Input: @n = \[" ~ @n ~ "]";

    for 0..(@n.elems - 1) -> $x {

      StringValue(@n[$x]);

    }

    for 0..(@n.elems - 1) -> $x {

      my $cnt = @out.grep(@out[$x]).elems;

      if $cnt == 1 {

        print("Output: @n[$x]\n\n");

      }

    }

    @out = [];

  }

}
