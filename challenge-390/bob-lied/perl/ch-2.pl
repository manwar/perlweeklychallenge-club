#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 390 Task 2  Order Characters
#=============================================================================
# You are given a string $s (containing only alphabetic characters) and an
# integer $k > 0.  Write a script to choose one of the first $k letters of
# given string and append it at the end of the string. You keep doing this
# until you have lexicographically smallest string and return the string.
# Example 1 Input: $str = "dbca", $k = 1
#           Output: "adbc"
#   Move 1: "bcad" (move d to the end)
#   Move 2: "cadb" (move b to the end after move 1)
#   Move 3: "adbc" (move c to the end after move 2)
# Example 2 Input: $str = "geeks", $k = 2
#           Output: "eegks"
#   Choose either of the first 2 letters: "g", "e"
#   Move 1: "gekse" (move second letter "e")
#   Move 2: "gksee" (move second letter "e")
#   Move 3: "kseeg"
#   Move 4: "seegk"
#   Move 5: "eegks"
# Example 3 Input: $str = "cbaed", $k = 3
#           Output: "abcde"
#   Choose among First 3 letters: "c", "b", "a"
#   Move 1: "cbeda"  (move "a")
#   Move 2: "cedab"  (move "b")
#   Move 3: "edabc"  (move "c")
#   Move 4: "eabcd"  (move "d")
#   Move 5: "abcde"  (move "e")
# Example 4 Input: $str = "fedcba", $k = 4
#           Output: "abcdef"
# Example 5 Input: $str = "perl", $k = 1
#           Output: "erlp"
# Example 6 Input: $str = "oloolooo", $k = 1
#           Output: "looloooo"
# Example 7 Input: $str = "oloooolo", $k = 1
#           Output: "looloooo"
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

while ( @ARGV > 1 )
{
    say task(shift, shift);
}

#=============================================================================
sub task($str, $k)
{
    my $best = 'z' x length($str);

    $logger->debug( "$str|$k" );
    die "k out of range" if $k < 1 || $k > length($str);

    my %seen;
    my @stack;
    my $count = 0;
    my $maxDepth = 0;

    push @stack, map { move($str, $_) } 1 .. $k;
    $maxDepth = @stack;
    $logger->debug("stack=( @stack )" );

    while ( my $word = pop @stack )
    {
        next if $seen{$word};
        $seen{$word} = true;
        $count++;

        $best = $word if $word lt $best;

        push @stack, map { move($word, $_) } 1 .. $k;
        # $logger->debug("After [$word], stack size = ", scalar(@stack) );
        $maxDepth = @stack if @stack > $maxDepth;
    }
    $logger->debug("Checked $count words, stack grew to $maxDepth");
    return $best;
}

sub move($s, $k)
{
    # substr($s, 0, $k-1) . substr($s, $k) . substr($s, $k-1, 1);
    $s .= substr($s, $k-1, 1, '');
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(    "dbca", 1),     "adbc", "Example 1");
    is( task(   "geeks", 2),    "eegks", "Example 2");
    is( task(   "cbaed", 3),    "abcde", "Example 3");
    is( task(  "fedcba", 4),   "abcdef", "Example 4");
    is( task(    "perl", 1),     "erlp", "Example 5");
    is( task("oloolooo", 1), "looloooo", "Example 6");
    is( task("oloooolo", 1), "looloooo", "Example 7");

    done_testing;
}
