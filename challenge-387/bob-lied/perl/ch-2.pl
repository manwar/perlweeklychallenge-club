#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 387 Task 2  Atoms Count
#=============================================================================
# You are given a chemical formula with elements, numbers, and parentheses.
# Write a script to count the total number of each type of atom by expanding
# all grouped multipliers. Then, format and return the final inventory as a
# single string sorted alphabetically by element name, including the total
# count only if it is greater than 1.
# Example 1 Input: $formula = "((N2O)3(H2O)2)2"
#           Output: "H8N12O10"
# Example 2 Input: $formula = "Mg3(PO4)2"
#           Output: "Mg3O8P2"
# Example 3 Input: $formula = "(((H)2)3)4"
#           Output: "H24"
# Example 4 Input: $formula = "NaCl3(O2(S10)2)2Mg"
#           Output: "Cl3MgNaO4S40"
# Example 5 Input: $formula = "Z2Y3(X2W)2"
#           Output: "W2X4Y3Z2"
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

say task($_) for @ARGV;

#=============================================================================

sub gatherGroup($depth, $tokens)
{
    my @elem = ();

    while ( defined(my $t = shift @$tokens) )
    {
        if ( $t =~ m/[A-Z]/ )
        {
            $logger->debug("depth=$depth TOKEN: Element: $t", $tokens->[0] // 0);
            push @elem, [$t, ( @$tokens && $tokens->[0] =~ /\d/ ? shift(@$tokens) : 1 ) ];
        }
        elsif ( $t eq '(' )
        {
            $logger->debug("depth=$depth TOKEN: (");
            push @elem, gatherGroup($depth+1, $tokens);
        }
        elsif ( $t eq ')' )
        {
            my $mult = ( @$tokens && $tokens->[0] =~ m/\d/ ? shift(@$tokens) : 1 );
            $logger->debug("depth=$depth TOKEN: ) mult=$mult");
            
            $_->[1] *= $mult for @elem;
            return @elem;
        }
    }
    return @elem;
}

sub task($formula)
{
    my @tokens = ($formula =~ m/([A-Z][a-z]?|\d+|[()])/g);
    $logger->debug("TOKENS: @tokens");

    # Make pairs of [id, count]
    my @elem = gatherGroup(0, \@tokens);

    my %element;
    $element{$_->[0]} += $_->[1] for @elem;

    my $count = "";
    $count .= "$_" . ($element{$_} > 1 ? $element{$_} : "")  for sort keys %element;
    return $count;
}


sub runTest
{
    use Test2::V1 -ipP;

    is( task(   "((N2O)3(H2O)2)2"),     "H8N12O10", "Example 1");
    is( task(         "Mg3(PO4)2"),      "Mg3O8P2", "Example 2");
    is( task(        "(((H)2)3)4"),          "H24", "Example 3");
    is( task("NaCl3(O2(S10)2)2Mg"), "Cl3MgNaO4S40", "Example 4");
    is( task(        "Z2Y3(X2W)2"),     "W2X4Y3Z2", "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
