#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 375 Task 1  Single Common Word
#=============================================================================
# You are given two array of strings.  Write a script to return the number
# of strings that appear exactly once in each of the two given arrays.
# String comparison is case sensitive.
# Example 1 Input: @array1 = ("apple", "banana", "cherry")
#                  @array2 = ("banana", "cherry", "date")
#           Output: 2
# Example 2 Input: @array1 = ("a", "ab", "abc")
#                  @array2 = ("a", "a", "ab", "abc")
#           Output: 2
#   "a" appears once in @array1 but appears twice in @array2, therefore, not counted.
# Example 3 Input: @array1 = ("orange", "lemon")
#                  @array2 = ("grape", "melon")
#           Output: 0
# Example 4 Input: @array1 = ("test", "test", "demo")
#                  @array2 = ("test", "demo", "demo")
#           Output: 0
# Example 5 Input: @array1 = ("Hello", "world")
#                  @array2 = ("hello", "world")
#           Output: 1
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

my @arr1 = split(" ", shift);
my @arr2 = split(" ", shift);
say "As refs:   ", scw( \@arr1, \@arr2);

# Syntactic sugar: allow passing arrays, not references, as in examples
sub scw2 :prototype(\@\@) ($arr1,$arr2) { scw($arr1, $arr2) }
say "As arrays: ", scw2(@arr1, @arr2);

#=============================================================================
sub scw($arr1, $arr2)
{
    use List::MoreUtils qw/frequency/;

    my %f = frequency($arr1->@*);
    delete @f{ grep { $f{$_} != 1 } keys %f};

    $f{$_}++ for $arr2->@*;

    return scalar grep { $_ == 2 } values %f;
}

sub runTest
{
    use Test2::V0;

    is( scw( ["apple", "banana", "cherry"], ["banana", "cherry", "date"]), 2, "Example 1");
    is( scw( ["a", "ab", "abc"], ["a", "a", "ab", "abc"]), 2, "Example 2");
    is( scw( ["orange", "lemon"], ["grape", "melon"]), 0, "Example 3");
    is( scw( ["test", "test", "demo"], ["test", "demo", "demo"]), 0, "Example 4");
    is( scw( ["Hello", "world"], ["hello", "world"]), 1, "Example 5");

    done_testing;
}
