#!/usr/bin/env perl
#
# You are given two array of languages and its popularity.
# 
# Write a script to sort the language based on popularity.
# Example 1
# 
# Input: @lang = ('perl', 'c', 'python')
#        @popularity = (2, 1, 3)
# Output: ('c', 'perl', 'python')
# 
# Example 2
# 
# Input: @lang = ('c++', 'haskell', 'java')
#        @popularity = (1, 3, 2)
# Output: ('c++', 'java', 'haskell')
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [ ['perl', 'c', 'python'],    [2, 1, 3] ],
    [ ['c++', 'haskell', 'java'], [1, 3, 2] ],
];

sub sort_language
{
    my $lang = shift;
    my $popularity = shift;

    my %langpop = map { $lang->[$_] => $popularity->[$_] } (0..$#$lang);
    return [ sort { $langpop{$a} <=> $langpop{$b}} keys %langpop ];    
}

is_deeply(sort_language($cases->[0]->@*), ['c', 'perl', 'python'],    "['perl', 'c', 'python'], [2, 1, 3]");
is_deeply(sort_language($cases->[1]->@*), ['c++', 'java', 'haskell'], "['c++', 'haskell', 'java'], [1, 3, 2]");
done_testing();

exit 0;


