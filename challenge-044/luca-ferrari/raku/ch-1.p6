#!env perl6

# Perl Weekly Challenge 44
# Task 1
# You are given a string “123456789”.
# Write a script that would insert ”+” or ”-” in between
# digits so that when you evaluate, the result should be 100.
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-044/>

my $string    = '123456789';
my @digits    = $string.comb;
my @operators = [ ' + ', ' - ', '' ] xx @digits.elems;



# produce a set of strings by combining all possible operators
# into all possible digits.
# Explaination:
# @digits Z @operators creates a list of elements
# with all the digits and applicable signs, something like (1 [+ - ]) (2 [+ - ])
#
# then the slip flattens the list and remap it to another list
#
# then the hyperoperator concatenates everything as a single string
#
# In the loop the spaces are removed, then the string is split by the sign
# and the .Int method computes the value of every part.
for [X~] map { .Slip },  (@digits Z @operators) {

    # remove extra spaces
    my $expression = .Str.subst( ' ', '', :g );

    my $sum = 0;
    for $expression ~~ m:g/ (<[- + ]>\d+)/ {
        $sum += .Int;
    }


    say "Expression [$expression] = $sum" if $sum == 100;

}
