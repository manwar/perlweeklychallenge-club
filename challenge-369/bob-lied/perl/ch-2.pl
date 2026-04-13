#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 369 Task 2  Group Division
#=============================================================================
# You are given a string, group size and filler character.
# Write a script to divide the string into groups of given size. In the last
# group if the string doesn’t have enough characters remaining fill with the
# given filler character.
# Example 1 Input: $str = "RakuPerl", $size = 4, $filler = "*"
#			Output: ("Raku", "Perl")
# Example 2 Input: $str = "Python", $size = 5, $filler = "0"
#			Output: ("Pytho", "n0000")
# Example 3 Input: $str = "12345", $size = 3, $filler = "x"
#			Output: ("123", "45x")
# Example 4 Input: $str = "HelloWorld", $size = 3, $filler = "_"
#			Output: ("Hel", "loW", "orl", "d__")
# Example 5 Input: $str = "AI", $size = 5, $filler = "!"
#			Output: "AI!!!"
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

say '(', join(", ", map { qq("$_") } enGroupenize(@ARGV)->@*), ')';

#=============================================================================
sub enGroupenize($str, $size, $filler)
{
    my @g = unpack("(A$size)*", $str);
    $g[-1] .= $filler x ($size - length($g[-1]));
    return \@g;
}

sub runTest
{
    use Test2::V0;

    my @case = (
        { desc => "Example 1",
          str => "RakuPerl", size => 4, filler => '*',
          expect => [ "Raku", "Perl" ],
        },
        { desc => "Example 2",
          str => "Python", size => 5, filler => '0',
          expect => [ "Pytho", "n0000" ],
        },
        { desc => "Example 3",
          str => "12345", size => 3, filler => 'x',
          expect => [ "123", "45x" ],
        },
        { desc => "Example 4",
          str => "HelloWorld", size => 3, filler => '_',
          expect => [ "Hel", "loW", "orl", "d__" ],
        },
        { desc => "Example 5",
          str => "AI", size => 5, filler => '!',
          expect => [ "AI!!!" ],
        },
    );

    for ( @case )
    {
        is( enGroupenize($_->{str}, $_->{size}, $_->{filler}), $_->{expect}, $_->{desc} );
    }
    done_testing;
}
