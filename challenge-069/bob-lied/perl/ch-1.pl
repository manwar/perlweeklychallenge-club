#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 069 Task 1  Strobogrammatic Number
#=============================================================================
# A strobogrammatic number is a number that looks the same when looked at
# upside down.  You are given two positive numbers $A and $B such that
# 1 <= $A <= $B <= 10^15.  Write a script to print all strobogrammatic
# numbers between the given two numbers.
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

say join(", ", strobrange(@ARGV)->@*);

#=============================================================================
sub strobrange($beg, $end)
{
    my @answer;
    for my $size ( length("$beg") .. length("$end") )
    {
        push @answer, grep { $beg <= $_ <= $end } strob($size, $size)->@*;
    }
    return [ sort { $a <=> $b } @answer ];
}

# Generate strobogrammatic numbers of length n
sub strob($n, $length)
{
    $logger->debug(' 'x$n, "Enter: $n [$length]");
    if ( $n <= 0 ) {
        $logger->debug(' 'x$n, "Constant: $n ['']");
        return [ '' ];
    }
    elsif ( $n == 1 ) {
        $logger->debug(' 'x$n, "Constant: $n [0 1 8]");
        return [ 0, 1, 8 ]
    }

    my @result;
    my $middle = strob($n-2, $length);
    for my $m ( $middle->@*  )
    {
        push @result, "0${m}0" if ( $n != $length );
        push @result, "1${m}1", "8${m}8", "6${m}9", "9${m}6";
    }
    $logger->debug(' 'x$n, "Leave $n [@result]");
    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( strobrange(1,9), [1,8], "One digit");
    is( strobrange(10,99), [11,69,88,96], "Two digit");
    is( strobrange(100,999), [ 101, 111, 181, 609, 619, 689, 808, 818, 888, 906, 916, 986 ], "Three digit");
    is( strobrange(1000,9999), [
1001, 1111, 1691, 1881, 1961, 6009, 6119, 6699, 6889, 6969, 8008, 8118, 8698, 8888, 8968, 9006, 9116, 9696, 9886, 9966
        ], "Four digit");

    is( strobrange(80, 120), [ 88, 96, 101, 111 ], 'Multiple lengths 2-3');
    is( strobrange(90, 1120), [
            96,101, 111, 181, 609, 619, 689, 808, 818, 888, 906, 916, 986 , 1001, 1111
        ], 'Multiple lengths 2-4');

    done_testing;
}
