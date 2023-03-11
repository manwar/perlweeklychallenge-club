#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 207 Task 1 Keyboard Words
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of words.
# Write a script to print all the words in the given array that can be types
# using alphabet on only one row of the keyboard.
# Let us assume the keys are arranged as below:
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm
#
# Example 1 Input: @words = ("Hello","Alaska","Dad","Peace")
#          Output: ("Alaska","Dad")
# Example 2 Input: @array = ("OMG","Bye")
#          Output: ()
#=============================================================================

use v5.36;

no warnings "experimental::builtin";
use builtin qw/trim/;

use List::Util qw/any/;


use Getopt::Long;
my $DoTest  = 0;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say "(", join(", ", map { qq("$_") } keyboardWord(\@ARGV)->@*), ")";


sub isKeyboardWord($word)
{
state @Keyboard = ( qr/[qwertyuiop]+/, qr/[asdfghjkl]+/, qr/[zxcvbnm]+/ );
    return any { $word =~ /\A$_\Z/ } @Keyboard;
}

sub keyboardWord($list)
{
    my @result = grep { isKeyboardWord(lc trim $_) } $list->@*;
    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( keyboardWord([qw(Hello Alaska Dad Peace)]), [qw(Alaska Dad)], "Example 1");
    is( keyboardWord([qw(OMG Bye)]),                [qw()],           "Example 2");

    done_testing;
}

