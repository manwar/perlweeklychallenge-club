#!perl6 
# Task 2 Challenge 051 Solution by kevincolyer
# Colourful Number
# Write a script to display all Colorful Number with 3 digits.
# A number can be declare Colorful Number where all the products 
# of consecutive subsets of digit are different.
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 
# 2x6x3 are unique.

sub Colourful3Digits(Int $number where   *.chars == 3 ) {
    # we could count the number of products in lots of ways including sets and arrays
    my %seen;
    # polymod does multiple modular division and helpfully splits number into hundereds, tens and ones
    my ($a,$b,$c) = $number.polymod(10,10);
    # stuff into hash - if products are the same then there will be fewer keys
    %seen{$a}++;
    %seen{$b}++;
    %seen{$c}++;
    %seen{$a*$b}++;
    %seen{$b*$c}++;
    %seen{$a*$b*$c}++;
    # a colourful number will have six entries in the hash table
    return %seen.elems==6 ?? True !! False;
}

# display 3 digit colourful numbers
for 100..999 -> $n {
    say "$n is colourful" if Colourful3Digits($n);
}

