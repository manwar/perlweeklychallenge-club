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
# 
#=============================================================================

use v5.36;

use lib "lib";
use SubstringIterator;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub allSubstrings($str)
{
    my @substr;

    my $size = length($str);
    for my $len ( 1 .. $size )
    {
        for ( my $pos = 0; $pos + $len <= $size ; $pos++ )
        {
            push @substr, substr($str, $pos, $len);
        }
    }

    return \@substr;
}

sub wordSticker($target, @stickerWord)
{
    # Normalize everything to lowercase.
    $target = lc($target);
    @stickerWord = map { lc } @stickerWord;

    # Do all letters in $word occur somewhere in @sticker?
    # Conversely, does word consist entirely of letters from @sticker
    my $available = join("", @stickerWord);
    return 0 unless $target =~ m/^[$available]+$/;

    # Gather up a set of all possible substrings from the sticker words
    my %sticker;
    for my $w ( @stickerWord)
    {
        my $s = allSubstrings($w);
        $sticker{$_} = $w for @$s;
    }

    # Worst case is one letter at a time.
    my $minScore = length($target);

    stickerize($target, \%sticker, 0);


    return -1;
}

sub stickerize($target, $stickers, $scoreSoFar)
{
    state %cache;
    if ( exists $stickers->{$target} )
    {
        return $scoreSoFar + $cache{$target};
    }

    # Base cases for recursion.  If the string is of length one, we
    # know that there is a sticker for it because we already verified
    # that all letters in the target occur somewhere among the stickers.
    my $len = length($target);
    if    ( $len == 0 ) { return $scoreSoFar }
    elsif ( $len == 1 ) { return $soreSoFar  + ($cache{$target} = 1) }

    if ( exists $cache{$target} )
    {
        return $scoreSoFar + $cache{$target}
    }

    # Take each possible substring from the target.  If the substring
    # can be made from a sticker, remove it and recurse on the smaller
    # target.
    my $ssi = SubstringIterator->new($target);
    
    my $score = $len;
    my ($pre, $ss, $post) = $ssi->next();
    while ( defined $ss )
    {
        say "SSI: pre=[$pre] ss=[$ss] post=[$post]" if $Verbose;
        $score = map { stickerize($_, $stickers) } $pre, $ss, $post;
        ($pre, $ss, $post) = $ssi->next();
    }


}

sub runTest
{
    use Test2::V0;

    is( allSubstrings("a"),    [ qw(a) ], "Substr 1");
    is( allSubstrings("ab"),   [ qw(a b ab) ], "Substr 2");
    is( allSubstrings("abc"),  [ qw(a b c ab bc abc) ], "Substr 3");
    is( allSubstrings("abcd"), [ qw(a b c d ab bc cd abc bcd abcd) ], "Substr 4");

    is(wordSticker("peon"         , qw(perl raku python)  ), 2, "Example 1");
    is(wordSticker("goat"         , qw(love hate angry )  ), 3, "Example 2");
    is(wordSticker("accommodation", qw(come nation delta) ), 4, "Example 3");
    is(wordSticker("accommodation", qw(come country delta)), 0, "Example 4");

    done_testing;
}
