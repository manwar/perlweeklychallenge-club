#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Word Stickers 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of word stickers and a target word.
# Write a script to find out how many word stickers are needed to make up
# the given target word.
# Example 1: 
#    Input: @stickers = ('perl','raku','python'), $word = 'peon'
#    Output: 2
#  We just need 2 stickers i.e. 'perl' and 'python'.
#  'pe' from 'perl' and
#  'on' from 'python' to get the target word.
# Example 2:
#    Input: @stickers = ('love','hate','angry'), $word = 'goat'
#    Output: 3
#  We need 3 stickers i.e. 'angry', 'love' and 'hate'.
#  'g' from 'angry'
#  'o' from 'love' and
#  'at' from 'hate' to get the target word.
# Example 3:
#    Input: @stickers = ('come','nation','delta'), $word = 'accommodation'
#    Output: 4
#  We just need 2 stickers of 'come' and one each of 'nation' & 'delta'.
#  'a' from 'delta'
#  'ccommo' from 2 stickers 'come'
#  'd' from the same sticker 'delta' and
#  'ation' from 'nation' to get the target word.
# Example 4:
#    Input: @stickers = ('come','country','delta'), $word = 'accommodation'
#    Output: 0
#  as there's no "i" in the inputs.
##########
# The examples suggest that we should look for substrings, but really
# the stickers just create a big sack of letters that we can use.
# This is going to be a search over the possible combinations of stickers
# that satisfy each letter in turn (recursive depth-first search).
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

if ( @ARGV < 2 )
{
    say STDERR "Usage: $0 target sticker...";
    exit 1;
}
say wordSticker(shift, @ARGV);

my $MinCount;

sub wordSticker($target, @stickerWord)
{
    # Normalize everything to lowercase.
    $target = lc($target);

    # Set of starting words, can be re-used as needed.
    my @stickerPool = map { lc } @stickerWord;

    # Worst case is a new sticker for every letter.
    $MinCount = length($target);

    # Do all letters in $target occur somewhere in the stickers?
    # Conversely, does target consist entirely of letters from @stickerPool
    my $available = join("", @stickerPool);
    return 0 unless $target =~ m/^[$available]+$/;

    # Extract the first character and remove it from the target.
    my $char = substr($target, 0, 1, "");

    # Find a sticker from the pool that has $char
    for my $s ( 0 .. $#stickerPool )
    {
        next unless index($stickerPool[$s], $char) >= 0;

        # Start the list of stickers with a copy of this one.
        my $inUse = [ $stickerPool[$s] ];
        # Remove the letter from the new sticker.
        $inUse->[0] =~ s/$char//;

        # Start the recursion with one sticker in the list and
        # the first letter already removed from target.
        _stickerize(\@stickerPool, $target, $inUse, 1);
    }
    return $MinCount;
}

# Recursive function for depth-first search.
# $stickerPool -- our original list of sticker words, never changes.
# $target -- our target word, gets one letter smaller every recursion.
# $inUse -- an array of stickers used, with target letters elided
# $countSoFar -- number of stickers in use
sub _stickerize($stickerPool, $target, $inUse, $countSoFar) 
{
    if ( length($target) == 0 )
    {
        $MinCount = $countSoFar if $countSoFar < $MinCount;
        return;
    }

    # Extract the first character and remove it from the target.
    my $char = substr($target, 0, 1, "");

    # Can we satisfy this letter with a sticker already in use?
    if ( grep /$char/, @$inUse )
    {
        # If we're finished, check if this is a new best score.
        # No need to actually find the sticker or recurse.
        if ( length($target) == 0 )
        {
            $MinCount = $countSoFar if $countSoFar < $MinCount;
            return;
        }

        # Find stickers that have the letter and try each one
        for my $s ( 0 .. $inUse->$#* )
        {
            next unless index($inUse->[$s], $char) >= 0;

            # Make a copy of the used list.
            my $sticker = [ @$inUse ];

            # Eliminate the current letter from the sticker we found.
            $sticker->[$s] =~ s/$char//;

            # Recurse.  Our sticker count did not go up, but we modified
            # the inUse list, and target is now shorter by one letter.
            _stickerize($stickerPool, $target, $sticker, $countSoFar);
        }
        return;
    }

    # We need another sticker for this letter, so get one from the pool.
    for my $s ( 0 .. $#{$stickerPool} )
    {
        next unless index($stickerPool->[$s], $char) >= 0;

        # If we're done, we don't actually have to recurse, but we
        # do need to check if our score improved.
        if ( length($target) == 0 )
        {
            my $newScore = $countSoFar + 1; # We needed another sticker.
            $MinCount = $newScore if $newScore < $MinCount;
            return;
        }

        # Add a new sticker, but with the letter used up.
        my $sticker = [ @$inUse, $stickerPool->[$s] ];
        $sticker->[-1] =~ s/$char//;

        # Recurse.  target is shorter by one letter, and our count went up.
        _stickerize($stickerPool, $target, $sticker, $countSoFar+1);
    }
    return;
}

sub runTest
{
    use Test2::V0;

    is(wordSticker("peon"         , qw(perl raku python)  ), 2, "Example 1");
    is(wordSticker("goat"         , qw(love hate angry )  ), 3, "Example 2");
    is(wordSticker("accommodation", qw(come nation delta) ), 4, "Example 3");
    is(wordSticker("accommodation", qw(come country delta)), 0, "Example 4");

    done_testing;
}
