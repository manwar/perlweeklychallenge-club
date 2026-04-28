#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 371 Task 1  Missing Letter
#=============================================================================
# You are given a sequence of 5 lowercase letters, with one letter replaced
# by ‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’,
# …, ‘z = 26’). The sequence follows a repeating pattern of step sizes between
# consecutive letters.
# The pattern is either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple
# alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).
#
# Example 1 Input: $seq = qw(a c ? g i)
#           Output: e (The pattern of the sequence is +2,+2,+2,+2.)
# Example 2 Input: $seq = qw(a d ? j m)
#           Output: g (The pattern of the sequence is +3,+3,+3,+3.)
# Example 3 Input: $seq = qw(a e ? m q)
#           Output: i (The pattern of the sequence is +4,+4,+4,+4.)
# Example 4 Input: $seq = qw(a c f ? k)
#           Output: h (The pattern of the sequence is +2,+3,+2,+3.)
# Example 5 Input: $seq = qw(b e g ? l)
#           Output: j (The pattern of the sequence is +3,+2,+3,+2.)
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

say missing(@ARGV);

#=============================================================================
sub missing(@seq)
{
    use List::MoreUtils qw/firstidx slide/;
    my $q = firstidx { $_ eq '?' } @seq;
    my @d = slide { $b - $a } map { ord($_) } @seq;

    my $m;
    if    ( $q == 0 ) { $m = ord($seq[1]) - $d[-2] }
    elsif ( $q == 1 ) { $m = ord($seq[0]) + $d[ 2] }
    elsif ( $q == 2 ) { $m = ord($seq[1]) + $d[ 3] }
    elsif ( $q == 3 ) { $m = ord($seq[2]) + $d[ 0] }
    elsif ( $q == 4 ) { $m = ord($seq[3]) + $d[ 1] }

    return chr($m);
}

sub runTest
{
    use Test2::V0;

    is( missing(qw(a c ? g i)), 'e', "Example 1");
    is( missing(qw(a d ? j m)), 'g', "Example 2");
    is( missing(qw(a e ? m q)), 'i', "Example 3");
    is( missing(qw(a c f ? k)), 'h', "Example 4");
    is( missing(qw(b e g ? l)), 'j', "Example 5");

    is( missing(qw(? c f h k)), 'a', "Leading ?");
    is( missing(qw(a c f h ?)), 'k', "Trailing ?");
    is( missing(qw(a ? f h k)), 'c', "Second position");

    done_testing;
}
