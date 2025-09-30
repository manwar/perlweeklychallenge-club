#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 340 Task 2: Ascending Numbers
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( all );

sub ascending_numbers( $str ) {
    my @numbers = $str =~ /(\d+)/g;
    return all { $numbers[$_] > $numbers[$_-1] } 1..$#numbers;
}

use Test2::V0 qw( -no_srand );

is ascending_numbers( "The cat has 3 kittens 7 toys 10 beds" ), T,
    'Example 1: ascending_numbers( "The cat has 3 kittens 7 toys 10 beds" ) is true';
is ascending_numbers( "Alice bought 5 apples 2 oranges 9 bananas" ), F,
    'Example 2: ascending_numbers( "Alice bought 5 apples 2 oranges 9 bananas" ) is false';
is ascending_numbers( "I ran 1 mile 2 days 3 weeks 4 months" ), T,
    'Example 3: ascending_numbers( "I ran 1 mile 2 days 3 weeks 4 months" ) is true';
is ascending_numbers( "Bob has 10 cars 10 bikes" ), F,
    'Example 4: ascending_numbers( "Bob has 10 cars 10 bikes" ) is false';
is ascending_numbers( "Zero is 0 one is 1 two is 2" ), T,
    'Example 5: ascending_numbers( "Zero is 0 one is 1 two is 2" ) is true';

done_testing;
