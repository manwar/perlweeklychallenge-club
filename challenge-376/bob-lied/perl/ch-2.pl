#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 376  Task 2  Doubled Words
#=============================================================================
# You are given a string (which may contain embedded newlines) which is taken
# from a page on a website. The string will not contain brackets qw{ [ ] }.
# Write a script that will find doubled words (such as “this this”) and
# highlight (wrap in brackets) each doubled word.  The script should:
#   - Work across lines, even finding situations where a word at the end of
#     one line is repeated at the beginning of the next.
#   - Find doubled words despite capitalization differences, such as with
#     'The the...', as well as allow differing amounts of whitespace (spaces,
#     tabs, newlines, and the like) to lie between the words.
#   - Find doubled words even when separated by HTML tags. For example, to
#     make a word bold: '...it is <B>very</B> very important...'. Only show
#     lines containing doubled words.
#
# Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F. Friedl
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

say task("@ARGV");

#=============================================================================
sub task($str)
{
    state $sepRE = qr/ \s*     # Possible white space followed by
                     (?:       # ( a group of a tag and more white space
                      <[^>]*>  #  ... an HTML tag
                      \s*      #  ... optional space
                     )+        # ) There can be multiple tags
                     | \s+     # Or just white space
                   /x;

    # Using () in RE includes separators in the array
    my @word = split( /($sepRE)/, $str);

    # Take every other word. Skip over a leading separator.
    my ($first, $second) = ( $word[0] =~ m/$sepRE/ ) ? (1,3) : (0, 2);

    while ( $second <= $#word)
    {
        my (@w) = ( trimPunct($word[$first]), trimPunct($word[$second]));

        if ( lc($w[0]) eq lc($w[1]) )
        {
            $logger->debug("Double: @w");
            $word[$first]  =~ s/($w[0])/[$1]/;
            $word[$second] =~ s/($w[1])/[$1]/;
        }
        $first += 2; $second += 2;
    }

    # Reassemble the string, now with some words possibly bracketed
    my $highlighted = join("", @word);

    # Output includes only lines where we inserted brackets
    return join"\n", grep /[\[\]]/, split(/\n/, $highlighted);
}


sub trimPunct($word)
{
    $word =~ s/^[[:punct:]]+//;
    $word =~ s/[[:punct:]]+$//;
    return $word
}

sub runTest
{
    use Test2::V0;

    is( trimPunct("abc"), "abc", "trimPunct nothing to do");
    is( trimPunct("'abc'"), "abc", "remove quotes");

    my @testCase = (
    {
	desc   => "Example 1",
    input  => "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.",
	expect => "web server for doubled words (such as '[this] [this]'), a common problem"
    },

    {
	desc   => "Example 2",
    input  => "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.",
	expect => "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"
    },
    {
	desc   => "Example 3",
    input  => "to make a word bold: '...it is <B>very</B> very important...'.",
	expect => "to make a word bold: '...it is <B>[very]</B> [very] important...'."
    },
    {
	desc   => "Example 4",
    input  => "Perl officially stands for Practical Extraction and Report Language, except when it doesn't.",
	expect => ""
    },
    {

	desc   => "Example 5",
    input  => "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.",
	expect => "There's more than [one] [one] way to do it."
    },
    {
    desc   => "Start with separator",
    input  => "  xx xx zz",
    expect => "  [xx] [xx] zz",
    },
    {
    desc   => "End with separator",
    input  => "xx zz zz </br>",
    expect => "xx [zz] [zz] </br>",
    },
    {
    desc   => "Multiple duplications",
    input  => "aa bb bb mm ss ss zz",
    expect => "aa [bb] [bb] mm [ss] [ss] zz",
    },
    {
    desc   => "Tag as eparator without white space",
    input  => "aa<xx>cc</xx>cc<xx>",
    expect => "aa<xx>[cc]</xx>[cc]<xx>",
    },
    );

    for my $tc ( @testCase )
    {
        is( task($tc->{input}), $tc->{expect}, "$tc->{desc}");
    }

    done_testing;
}
