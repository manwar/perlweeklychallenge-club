#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 364 Task 1  Decrypt String
#=============================================================================
# You are given a string formed by digits and ‘#'. Write a script to map
# the given string to English lowercase characters following the given rules.
# - Characters 'a' to 'i' are represented by '1' to '9' respectively.
# - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.
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

say decrypt("@ARGV");

#=============================================================================
sub decrypt($str)
{
                 # 0 1 2 3 4 5 6 7 8 9
    state @dd = qw(_ a b c d e f g h i j k l m n o p q r s t u v w x y z);

    try {
        $str =~ s/(\d\d)#/$dd[$1]/ge;
        $str =~ s/(\d)/$dd[$1]/ge;
    } catch ( $e ) {
        say "Illegal encoding: ", $e;
    }
    return $str;
}

sub runTest
{
    use Test2::V0;

    is( decrypt("10#11#12"), "jkab", "Example 1");
    is( decrypt("1326#"), "acz", "Example 2");
    is( decrypt("25#24#123"), "yxabc", "Example 3");
    is( decrypt("20#5"), "te", "Example 4");
    is( decrypt("1910#26#"), "aijz", "Example 5");

    done_testing;
}
