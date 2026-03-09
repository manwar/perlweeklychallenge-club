#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 364 Task 2  Goal Parser
#=============================================================================
# You are given a string, $str. Write a script to interpret the given string
# using Goal Parser. The Goal Parser interprets “G” as the string “G”, “()”
# as the string “o”, and “(al)” as the string “al”. The interpreted strings
# are then concatenated in the original order.
# Example 1 Input: $str = "G()(al)"
#           Output: "Goal"
# Example 2 Input: $str = "G()()()()(al)"
#           Output: "Gooooal"
# Example 3 Input: $str = "(al)G(al)()()"
#           Output: "alGaloo"
# Example 4 Input: $str = "()G()G"
#           Output: "oGoG"
# Example 5 Input: $str = "(al)(al)G()()"
#           Output: "alalGoo"
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
    my @version = ( { name => "regex s///", code => \&parse },
                    { name => "map join  ", code => \&parseMAP },
                    { name => "state mach", code => \&parseSTR },
                    { name => "with split", code => \&parseSPLIT },
    );
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

for my $v ( @version )
{
    say "$v->{name}: ", $v->{code}($_) for @ARGV;
}

#=============================================================================
sub parse($str)
{
    state %replace = ( G => "G", "()" => "o", "(al)" => "al" );
    my $result = $str =~ s/(G|\(\)|\(al\))/$replace{$1}/egr;

    # Retains any unexpected characters, check for syntax errors
    return ($result =~ m/[^Goal]/ ? "UNEXPECTED $str" : $result);
}

sub parseMAP($str)
{
    state %replace = ( G => "G", "()" => "o", "(al)" => "al" );
    return "UNEXPECTED $str" unless $str =~ m/^(?:G|\(\)|\(al\))*$/;
    my $result = join "", map { $replace{$_} } $str =~ m/(G|\(\)|\(al\))/g;

    # Drops unexpected characters, hides syntax errors
    return ($result =~ m/[^Goal]/ ? "UNEXPECTED $str" : $result);
}

sub parseSPLIT($str)
{
    state %replace = ( G => "G", "()" => "o", "(al)" => "al", "" => "" );

    # Use valid strings as separators, and keep the separators from split
    my $result = join "", map { $replace{$_} // $_ } split(/(G|\(\)|\(al\))/, $str);

    return ($result =~ m/[^Goal]/ ? "UNEXPECTED $str" : $result);
}

sub parseSTR($str)
{
    use enum qw(:ST_ UNEXPECTED START OPEN AL_A AL_L );
    my $state = ST_START;
    my $result = "";

    for my $c ( split(//, $str) )
    {
        # $logger->debug("STATE=$state input=$c result=$result");
        if    ( $state eq ST_START )
        {
            if    ( $c eq "G" ) { $result .= "G" }
            elsif ( $c eq "(" ) { $state = ST_OPEN }
            else                { $state = ST_UNEXPECTED }
        }
        elsif ( $state eq ST_OPEN )
        {
            if    ( $c eq ")" ) { $result .= "o"; $state = ST_START }
            elsif ( $c eq "a" ) { $state = ST_AL_A }
            else                { $state = ST_UNEXPECTED }
        }
        elsif ( $state eq ST_AL_A )
        {
            if    ( $c eq "l" ) { $state = ST_AL_L }
            else                { $state = ST_UNEXPECTED }
        }
        elsif ( $state eq ST_AL_L )
        {
            if    ( $c eq ")" ) { $result .= "al"; $state = ST_START }
            else                { $state = ST_UNEXPECTED }
        }
        elsif ( $state eq ST_UNEXPECTED ) { return "UNEXPECTED $str" }
    }

    return $result;
}

sub runTest
{
    use Test2::V0;
    my @testcase = (
    { input => "G()(al)"       , expect => "Goal",    desc => "Example 1" },
    { input => "G()()()()(al)" , expect => "Gooooal", desc => "Example 2" },
    { input => "(al)G(al)()()" , expect => "alGaloo", desc => "Example 3" },
    { input => "()G()G"        , expect => "oGoG",    desc => "Example 4" },
    { input => "(al)(al)G()()" , expect => "alalGoo", desc => "Example 5" },
    { input => "G()_z"         , expect => "UNEXPECTED G()_z", desc => "Unexpected character" },
    );

    for my $sub ( @version )
    {
        for my $c ( @testcase )
        {
            is( $sub->{code}( $c->{input} ), $c->{expect}, "$sub->{name} $c->{desc}" );
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = "G()(al)(al)()G" x 500;

    cmpthese($repeat, {
            map { my $code = $_->{code}; $_->{name} => sub { $code->($str) }  } @version
        });
}

#  cmpthese($repeat, { label => sub { }, });
