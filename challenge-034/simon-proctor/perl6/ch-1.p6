#!/usr/bin/env perl6

use v6;

# Making an array from a Sequence using a slice (^100 is the Range 0..100)
my @fibto100 = (1,1,*+*...*)[^100];

# Making a Hash by zipping the Array and some letters
my %fibhash = ("a".."z") Z=> @fibto100;

# Use a simple slice to get the first 5 Fibonacci numbers
say "First five Fibonacci numbers {@fibto100[^5].join(",")}";

# Use a complex slice to get the number with indicies divisible by 7
say "Fibonacci numbers whose index is divisible by 7 {@fibto100[(^100).grep( * %% 7 )].join(",")}";

# Combine slices (using a slip for the first 5 to get 1 list)
say "First and last 5 Fibonacci numbers {@fibto100[|(^5),*-5,*-4,*-3,*-2,*-1].join(",")}";

# Sub slices 
say "Sub slices to return sub lists {@fibto100[(1,2,3),(4,5,6),(7,8,9)].perl}";

# Hash Slice
say "Vowel indexed items {%fibhash{'a','e','i','o','u'}}";
