#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 289 Task Jumbled Letters
#=============================================================================
# An Internet legend dating back to at least 2001 goes something like this:
#   Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in
#   waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the
#   frist and lsat ltteer be at the rghit pclae. The rset can be a toatl mses
#   and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid
#   deos not raed ervey lteter by istlef, but the wrod as a wlohe.
# This supposed Cambridge research is unfortunately an urban legend. However,
# the effect has been studied. For example—and with a title that probably made
# the journal’s editor a little nervous—Raeding wrods with jubmled lettres:
# there is a cost by Rayner, White, et. al. looked at reading speed and
# comprehension of jumbled text.
#
# Your task is to write a program that takes English text as its input and
# outputs a jumbled version as follows:
#   The first and last letter of every word must stay the same.
#   The remaining letters in the word are scrambled in a random order
#   (if that happens to be the original order, that is OK).
#   Whitespace, punctuation, and capitalization must stay the same.
#   The order of words does not change, only the letters inside the word.
# So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it could
# not become “Pelr” or “lreP”.
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say jumble( join(" ", @ARGV) );

sub scramble($word)
{
    use List::Util qw/shuffle/;
    return $word if length($word) < 4;
    my @c = split(//, $word);
    join "", $c[0], @c[shuffle 1 .. ($#c-1)], $c[$#c];
}

sub jumble($text)
{
    join "", 
    map { scramble($_) } split(/(\W+)/, $text);
}

sub runTest
{
    use Test2::V0;

    is( scramble("abc"), "abc", "scramble basic");
    my $s = scramble("abcd");
    ok($s eq "abcd" || $s eq "acbd", "scramble 4 $s");
    $s = scramble("abcde");
    ok($s eq "abcde" || $s eq "abdce" || $s eq "acbde" ||
       $s eq "acdbe" || $s eq "adbce" || $s eq "adcbe", "scramble 5 $s");

    $s = scramble("abcdefghij");
    ok(substr($s,0,1) eq "a" && substr($s, -1, 1) eq "j" && length($s) == length("abcdefghij"), "scramble 10 $s");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
        label => sub { },
    });
}
