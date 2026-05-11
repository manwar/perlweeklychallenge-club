#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu syntax=perl:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 69  Task 2  0/1 String
#=============================================================================
# A 0/1 string is a string in which every character is either 0 or 1.  Write a
# script to perform switch and reverse to generate S30 as described below:
#  switch: Every 0 becomes 1 and every 1 becomes 0. E.g., "101" becomes "010”.
#  reverse: The string is reversed. For example, "001" becomes "100".
# UPDATE (2020-07-13 17:00:00):
# It was brought to my notice that generating S1000 string would be nearly
# impossible. So I have decided to lower it down to S30. Please follow the
# rule as below:
# S0 = “” S1 = "0" S2 = "001" S3 = "0010011" ...
# SN = SN-1 + "0" + switch(reverse(SN-1))
#
# Notice that the length of S(n) will be 2*length(S(n-1))+1, so the string
# grows exponentially longer.
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

for my $n ( @ARGV )
{
    my $s = S($n);
    my $len = length($s);
    say "S($n) = ", ( $len > 200 ? "[length=$len]" : $s );
}

#=============================================================================
sub S($n)
{
    state %cache = ( 0 => "", 1 => "0", 2 => "001" );

    if ( exists $cache{$n} )
    {
        $cache{$n}
    }
    else
    {
        $cache{$n} = S($n-1) . "0" . switch(rev(S($n-1)))
    }
}

sub switch($s) { return $s =~ tr/01/10/r; }
sub rev($s)    { return scalar(reverse($s)) }

sub runTest
{
    use Test2::V0;

    is( S(0), "", "S(0)");
    is( S(1), "0", "S(1)");
    is( S(2), "001", "S(2)");
    is( S(3), "0010011", "S(3)");
    is( S(4), "001001100011011", "S(4)");

    done_testing;
}
