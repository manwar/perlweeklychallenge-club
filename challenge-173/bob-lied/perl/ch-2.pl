#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 173 Task 2 Sylvester's Sequence 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to generate first 10 members of Sylvester's sequence.
# For more informations, please refer to the wikipedia page.
# https://en.wikipedia.org/wiki/Sylvester%27s_sequence
# In number theory, Sylvester's sequence is an integer sequence in which
# each term is the product of the previous terms, plus one.
#
# Output
# 2
# 3
# 7
# 43
# 1807
# 3263443
# 10650056950807
# 113423713055421844361000443
# 12864938683278671740537145998360961546653259485195807
# 165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
#=============================================================================

use v5.36;

my $max = shift @ARGV // 10;

use bigint;
my $s = 2;
say $s;
foreach (1 .. ($max-1) )
{
    $s = $s * ($s - 1) + 1;
    say $s;
}
