#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       super_bin_plus.pl
#
#         Add Binary
#         Submitted by: Mohammad S Anwar
#         You are given two decimal-coded binary numbers, $a and $b.
# 
#         Write a script to simulate the addition of the given binary numbers.
# 
#         The script should simulate something like $a + $b. (operator overloading)
# 
#         Example 1
#         Input: $a = 11; $b = 1;
#         Output: 100
#         Example 2
#         Input: $a = 101; $b = 1;
#         Output: 110
#         Example 3
#         Input: $a = 100; $b = 11;
#         Output: 111

#       method: 
#         Given two numbers in binary representation, we are asked to add
#         them. Specifically we are asked to simulate adding them, whatever
#         exactly that means.
# 
#         We could just add them: input each as binary stings prefixed by
#         '0b', add the values, then sprintf the result using "%b" again.
#         Dead simple. I think this is what is being requested. Provide a
#         function that takes two binary strings and returns a summed
#         result as a binary string.
# 
#         `+` after all is a function, and a function need not be infix,
#         that's just convention. In RPN we would, after all, write `+ 2 2`
#         instead of `2 + 2`. So we also need not call out summing function
#         `+`, but could use another name, like `super-bin-plus`, or maybe
#         just `binplus`. That's a little more normal. If we predeclare our
#         routine we can do away with parentheses.
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

sub binplus;

say binplus 1, 11 ;

sub binplus ($b1, $b2) {
    return sprintf "%b" , oct('0b' . $b1) + oct('0b' . $b2);
}

