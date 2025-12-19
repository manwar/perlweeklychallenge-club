#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 352 Task 1  Match String
#=============================================================================
# You are given an array of strings. Write a script to return all
# strings that are a substring of another word in the given array in
# the order they occur.
# Example 1 Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
#           Output: ("cat", "dog", "dogcat", "rat")
# Example 2 Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
#           Output: ("hell", "world", "wor", "ellow")
# Example 3 Input: @words = ("a", "aa", "aaa", "aaaa")
#           Output: ("a", "aa", "aaa")
# Example 4 Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
#           Output: ("flow", "fl", "fli", "ig", "ght")
# Example 5 Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
#           Output: ("car", "pet", "enter", "pen", "pent")
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say join(", ", matchString(@ARGV)->@*);

#=============================================================================
sub matchString(@words)
{
    use List::Util qw/any/;
    my %seen;
    my @match;
    for ( 1 .. @words )
    {
        my $w = shift @words;
        push @match, $w if ( ! $seen{$w}++ && any { index($_, $w) >= 0  } @words );
        push @words, $w;
    }
    return \@match;
}

sub matchRE(@words)
{
    use List::Util qw/any/;
    my %seen;
    my @match;
    for ( 1 .. @words )
    {
        my $w = shift @words;
        push @match, $w if ( ! $seen{$w}++  &&  grep /$w/, @words );
        push @words, $w;
    }
    return \@match;
}

sub runTest
{
    use Test2::V0;

    is( matchString("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"),
        [ "cat", "dog", "dogcat", "rat" ] , "Example 1");

    is( matchString( "hello", "hell", "world", "wor", "ellow", "elloworld"),
        [ "hell", "world", "wor", "ellow" ] , "Example 2");

    is( matchString( "a", "aa", "aaa", "aaaa"),
        [ "a", "aa", "aaa" ] , "Example 3");

    is( matchString( "flower", "flow", "flight", "fl", "fli", "ig", "ght"),
        [ "flow", "fl", "fli", "ig", "ght" ] , "Example 4");

    is( matchString( "car", "carpet", "carpenter", "pet", "enter", "pen", "pent"),
        [ "car", "pet", "enter", "pen", "pent" ] , "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $lorem = lc("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam elit neque, venenatis ut dolor consectetur, iaculis venenatis arcu. In interdum mauris eget neque venenatis dapibus. Sed finibus varius sapien quis malesuada. Fusce libero augue, vulputate sit amet faucibus at, feugiat at lectus. Maecenas vehicula sem metus. Nullam lobortis massa et est vulputate facilisis. In tempus arcu metus, vitae aliquam nibh sodales ac. Sed vitae erat nec nisl laoreet fringilla. Aliquam et lobortis purus. Ut a tristique nisi, nec molestie arcu. Duis mattis ultrices nisl eget consectetur. Donec ac lorem non augue bibendum tincidunt interdum quis velit. In gravida metus vitae.");
    $lorem =~ s/[^[:alpha:]]/ /g;
    my @t = split(" ", $lorem);

    my $answer = matchString(@t);
    my $yes = grep { $_ } $answer->@*;
    say "$yes true, t size=", scalar(@t);


    cmpthese($repeat, {
            index => sub { matchString(@t) },
            grepre => sub { matchRE(@t) },
        });
}
