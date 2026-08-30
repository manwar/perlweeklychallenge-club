#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 388 Task 1  Dyck Words
#=============================================================================
# A Dyck Word of order $n is a string of length 2x$n consisting of $n
# ‘U’ (Up) characters and $n ‘D’ (Down) characters such that no initial
# prefix of the string contains more ‘D’s than ‘U’s.  Write a script to
# return a list of all valid Dyck words of length 2x$n, sorted in
# lexicographical (alphabetical) order.
# Example 1 Input: $n = 1
#           Output: ("UD")
# Example 2 Input: $n = 2
#           Output: ("UDUD","UUDD")
# Example 3 Input: $n = 3
#           Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")
# Example 4 Input: $n = 0
#           Output: ("")
# Example 5 Input: $n = 4
#           Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
#                    "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
#                    "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")
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

say '(', join(', ', task($_)->@*), ')' for @ARGV;

#=============================================================================
# Credit: modified from Math:DyckWords
sub generateDyck($n, $dyck = [], $word = 'U', $nU = 1, $nD = 0, $depth = 1 )
{
    $logger->debug("$depth ($nU/$nD) $word");

    # We have space to add both a U and a D
    if ( $nU < $n && $nD < $n && $nU > $nD )
    {
        # U goes before D
        generateDyck( $n, $dyck, $word . 'U', $nU + 1, $nD     , $depth++ );
        generateDyck( $n, $dyck, $word . 'D', $nU,     $nD + 1 , $depth++ );
    }

    # We have space, but a U must be next
    if ( ( $nU < $n && $nD < $n && $nU == $nD ) ||
         ( $nU < $n && $nD == $n ) )
    {
        generateDyck( $n, $dyck, $word . 'U', $nU + 1, $nD , $depth++ );
    }

    if ( $nU == $n )
    {
        # We have all the Us, must add D until we balance.
        if ( $nD < $n  )
        {
            my $need = $n - $nD;
            generateDyck( $n, $dyck, $word . ('D' x $need), $nU, $nD + $need , $depth++ );
        }
        else # $nD == $n
        {
            # We have n of each, so save a complete word.
            push @$dyck, $word;
        }
    }
    return $dyck;
}

#=============================================================================
sub task($n)
{
    my $result = $n ? generateDyck($n) : [""];
    return [ reverse $result->@* ];
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(1), [ qw/UD/ ], "Example 1");
    is( task(2), [ qw/UDUD UUDD/ ], "Example 2");
    is( task(3), [ qw/UDUDUD UDUUDD UUDDUD UUDUDD UUUDDD/ ], "Example 3");
    is( task(0), [ "" ], "Example 4");
    is( task(4), [ qw/UDUDUDUD UDUDUUDD UDUUDDUD UDUUDUDD UDUUUDDD
                      UUDDUDUD UUDDUUDD UUDUDDUD UUDUDUDD UUDUUDDD
                      UUUDDDUD UUUDDUDD UUUDUDDD UUUUDDDD/ ] , "Example 5");

    done_testing;
}
