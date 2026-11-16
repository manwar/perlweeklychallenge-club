#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 400 Task 2  Minimum Genetic Mutation
#=============================================================================
# You are given start and end gene string along with gene bank. Write a
# script to return the minimum number of mutations required to mutate
# from start to end gene. Return -1 if there is no such mutation. A gene
# must be in a bank to make it a valid gene string. A gene string can be
# represented by an 8-character-long string, with choices from ‘A’, ‘C’,
# ‘G’, and ‘T’.
#
# Example 1 Input: $start_gene = "AACCGGTT"
#                  $end_gene   = "AACCGGTA"
#                  @gene_bank  = ("AACCGCTA", "AAACGGTA")
#       Output: -1
#   To reach end gene, every intermediate gene and the end gene itself must
#   exist in bank.  Since "AACCGGTA" is missing from bank, it is impossible
#   to complete the mutation sequence.
#
# Example 2 Input: $start_gene = "AACCGGTT"
#                  $end_gene   = "AACCGGAA"
#                  @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")
#       Output: 2
#   Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
#   Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"
#
# Example 3 Input: $start_gene = "AAAAAAAA"
#                  $end_gene   = "AAAAACCC"
#                  @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
#       Output: -1
#
# Example 4 Input: $start_gene = "GAAAAAAA"
#                  $end_gene   = "GCCCCCCC"
#                  @gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC")
#       Output: 7
#   "GAAAAAAA" => "GCAAAAAA"
#   "GCAAAAAA" => "GCCAAAAA"
#   "GCCAAAAA" => "GCCCAAAA"
#   "GCCCAAAA" => "GCCCCAAA"
#   "GCCCCAAA" => "GCCCCCAA"
#   "GCCCCCAA" => "GCCCCCCA"
#   "GCCCCCCA" => "GCCCCCCC"
#
# Example 5 Input: $start_gene = "AACCGGTT"
#                  $end_gene   = "AACCGGTT"
#                  @gene_bank = ("AACCGGTA")
#       Output: 0
#   The current genetic sequence already matches the desired end gene.
#   No mutations are necessary, so the result is 0.
#=============================================================================

use v5.44;
use List::Util qw/first sum0/;

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

my $START = shift;
my $END   = shift;
say task($START, $END, \@ARGV);

#=============================================================================
sub task($start_gene, $end_gene, $gene_bank)
{
    return 0 if $start_gene eq $end_gene;

    # end_gene must exist in gene_bank
    return -1 unless first { $_ eq $end_gene } $gene_bank->@*;

    my $minMutateCount = length($start_gene);
    my @queue;
    for ( oneMutationAway($start_gene, $gene_bank) )
    {
        push @queue, [ $_, 0 ];
    }

    my %seen;
    while ( my $x = shift @queue )
    {
        my ( $g, $count ) = $x->@*; 

        next if $seen{$g};
        $seen{$g} = true;
        $logger->debug("LOOK: $g, $count");

        my $stepCount = $count + 1;
        if ( $g eq $end_gene )
        {
            $minMutateCount = $stepCount if $stepCount < $minMutateCount;
            next;
        }

        for ( oneMutationAway($g, $gene_bank) )
        {
            push @queue, [ $_, $stepCount ] unless $seen{$_};
        }
    }
    return $minMutateCount;
}

sub oneMutationAway($g, $bank)
{
    grep { geneDiff($g, $_) == 1 } $bank->@*;
}

sub geneDiff($beg, $end)
{
    return sum0 map
        { substr($beg, $_, 1) eq substr($end, $_, 1) ? 0 : 1 }
            ( 0 .. length($beg)-1 );
}


sub runTest
{
    use Test2::V1 -ipP;

    my @case = (
    {   desc   => "Example 1",
        start  => "AAccGgtT", end => "AACCGGTA",
        bank   => [ "AACCGCTA", "AAACGGTA"],
        expect => -1,
    },
    {   desc   => "Example 2",
        start  => "AACCGGTT", end => "AACCGGAA",
        bank   => ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"],
        expect => 2,
    },
    {   desc   => "Example 3",
        start  => "AAAAAAAA", end => "AAAAACCC",
        bank   => ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"],
        expect => -1,
    },
    {   desc   => "Example 4",
        start  => "GAAAAAAA", end => "GCCCCCCC",
        bank   => ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"],
        expect => 7,
    },
    {   desc   => "Example 5",
        start  => "AACCGGTT", end => "AACCGGTT",
        bank   => ["AACCGGTA"],
        expect => 0,
    },
    );

    for my $c ( @case )
    {
        is( task($c->{start}, $c->{end}, $c->{bank}), $c->{expect}, $c->{desc});
    }

    done_testing;
}
