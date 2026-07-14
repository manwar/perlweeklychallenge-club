#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 382 Task 2  Replace Question Mark
#=============================================================================
# You are given a string that contains only 0, 1 and ? characters.
# Write a script to generate all possible combinations when replacing
# the question marks with a zero or one.
# Example 1 Input: $str = "01??0"
#           Output: ("01000", "01010", "01100", "01110")
# Example 2 Input: $str = "101"
#           Output: ("101")
# Example 3 Input: $str = "???"
#           Output: ("000", "001", "010", "011", "100", "101", "110", "111")
# Example 4 Input: $str = "1?10"
#           Output: ("1010", "1110")
# Example 5 Input: $str = "1?1?0"
#           Output: ("10100", "10110", "11100", "11110")
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

for ( @ARGV )
{
    my @replaced = sort { $a cmp $b } task($_)->@*;
    say '(', join(",", @replaced), ')';
}

#=============================================================================
sub task($str)
{
    my @replaced;

    my @queue = ( $str );
    while ( defined(my $s = shift @queue) )
    {
        if ( index($s, '?') >= 0 )
        {
            push @queue, ($s =~ s/\?/0/r), ($s =~ s/\?/1/r);
        }
        else
        {
            push @replaced, $s;
        }
    }

    return \@replaced;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("01??0"), ["01000", "01010", "01100", "01110"], "Example 1");
    is( task("101"  ), ["101"                             ], "Example 2");
    is( task("???"  ), ["000", "001", "010", "011", "100", "101", "110", "111"], "Example 3");
    is( task("1?10" ), ["1010", "1110"                    ], "Example 4");
    is( task("1?1?0"), ["10100", "10110", "11100", "11110"], "Example 5");

    done_testing;
}
