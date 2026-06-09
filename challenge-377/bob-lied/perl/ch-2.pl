#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 37 Task 2  Prefix Suffix
#=============================================================================
# You are given an array of strings.  Write a script to find if the two
# strings (str1, str2) in the given array such that str1 is prefix and
# suffix of str2. Return the total count of such pairs.
# Example 1 Input: @array = ("a", "aba", "ababa", "aa")
#           Output: 4
#   $array[0], $array[1]: "a" is a prefix and suffix of "aba"
#   $array[0], $array[2]: "a" is a prefix and suffix of "ababa"
#   $array[0], $array[3]: "a" is a prefix and suffix of "aa"
#   $array[1], $array[2]: "aba" is a prefix and suffix of "ababa"
# Example 2 Input: @array = ("pa", "papa", "ma", "mama")
#           Output: 2
#   $array[0], $array[1]: "pa" is a prefix and suffix of "papa"
#   $array[2], $array[3]: "ma" is a prefix and suffix of "mama"
# Example 3 Input: @array = ("abao", "ab")
#           Output: 0
# Example 4 Input: @array = ("abab", "abab")
#           Output: 1
#   $array[0], $array[1]: "abab" is a prefix and suffix of "abab"
# Example 5 Input: @array = ("ab", "abab", "ababab")
#           Output: 3
#   $array[0], $array[1]: "ab" is a prefix and suffix of "abab"
#   $array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
#   $array[1], $array[2]: "abab" is a prefix and suffix of "ababab"
# Example 6 Input: @array = ("abc", "def", "ghij")
#           Output: 0
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

say task(@ARGV);

#=============================================================================

sub isPrefixSuffix($pf, $str)
{
    my $length = length($pf);
    return ( substr($str, 0, $length) eq $pf )  && substr($str, -$length) eq $pf;
}

sub task(@array)
{
    my $count = 0;
    for my $first ( 0 .. $#array-1 )
    {
        for my $second ( $first+1 .. $#array )
        {
            $count++ if isPrefixSuffix($array[$first], $array[$second])
                     || isPrefixSuffix($array[$second], $array[$first]);
        }
    }
    return $count;
}

sub task2(@array)
{
    use List::MoreUtils qw/true/; # Conflict with true keyword

    my $count = 0;
    
    while ( defined(my $first = shift @array) )
    {
        $count += List::MoreUtils::true { isPrefixSuffix($first, $_) } @array;
    }

    return $count;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( isPrefixSuffix("a", "aba"),  true, "Simple true");
    is( isPrefixSuffix("a", "abc"), false, "Simple false suffix");
    is( isPrefixSuffix("a", "cba"), false, "Simple false prefix");
    is( isPrefixSuffix("a", "xxx"), false, "Simple false neither");
    is( isPrefixSuffix("aba", "a"), false, "Order matters");
    is( isPrefixSuffix("a",   "a"),  true, "One character true");
    is( isPrefixSuffix("a",  "aa"),  true, "Two character true");
    is( isPrefixSuffix("a",   "x"), false, "One character false");
    is( isPrefixSuffix("a",  "jk"), false, "Two character false");
    is( isPrefixSuffix("abc", "abcxyabc"),  true, "Non trivial true");
    is( isPrefixSuffix("abc", "jklmnopq"), false, "Non trivial false");

    is( task("a", "aba", "ababa", "aa"),  4, "Example 1");
    is( task("pa", "papa", "ma", "mama"), 2, "Example 2");
    is( task("abao", "ab"),               0, "Example 3");
    is( task("abab", "abab"),             1, "Example 4");
    is( task("ab", "abab", "ababab"),     3, "Example 5");
    is( task("abc", "def", "ghij"),       0, "Example 6");

    is( task("aba", "ababa", "aa", "a"),  4, "Example 1 revisited");

    is( task2("a", "aba", "ababa", "aa"),  4, "Example 1");
    is( task2("pa", "papa", "ma", "mama"), 2, "Example 2");
    is( task2("abao", "ab"),               0, "Example 3");
    is( task2("abab", "abab"),             1, "Example 4");
    is( task2("ab", "abab", "ababab"),     3, "Example 5");
    is( task2("abc", "def", "ghij"),       0, "Example 6");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @array = qw(Lorem ipsum dolor sit amet consectetur adipiscing elit. Etiam elit neque venenatis ut dolor consectetur iaculis venenatis arcu. In interdum mauris eget neque venenatis dapibus. Sed finibus varius sapien quis malesuada. Fusce libero augue vulputate sit amet faucibus at feugiat at lectus. Maecenas vehicula sem metus. Nullam lobortis massa et est vulputate facilisis. In tempus arcu metus vitae aliquam nibh sodales ac. Sed vitae erat nec nisl laoreet fringilla. Aliquam et lobortis purus. Ut a tristique nisi nec molestie arcu. Duis mattis ultrices nisl eget consectetur. Donec ac lorem non augue bibendum tincidunt interdum quis velit. In gravida metus vitae.);

    cmpthese($repeat, {
            forloop  => sub { task(@array) },
            utiltrue => sub { task2(@array) },
        });
}

