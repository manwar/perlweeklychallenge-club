#!perl

################################################################################
=comment

Perl Weekly Challenge 400
=========================

TASK #2
-------
*Minimum Genetic Mutation*

Submitted by: Mohammad Sajid Anwar

You are given start and end gene string along with gene bank.

Write a script to return the minimum number of mutations required to mutate from
start to end gene. Return -1 if there is no such mutation. A gene must be in a
bank to make it a valid gene string.

  A gene string can be represented by an 8-character long string, with choices
  from 'A', 'C', 'G', and 'T'.

Example 1

  Input: $start_gene = "AACCGGTT"
         $end_gene   = "AACCGGTA"
         @gene_bank  = ("AACCGCTA", "AAACGGTA")
  Output: -1

  To reach end gene, every intermediate gene and the end gene itself must exist
  in bank.
  Since "AACCGGTA" is missing from bank, it is impossible to complete the
  mutation sequence.

Example 2

  Input: $start_gene = "AACCGGTT"
         $end_gene   = "AACCGGAA"
         @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA",
                        "AACCGTAA")
  Output: 2

  Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
  Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"

Example 3

  Input: $start_gene = "AAAAAAAA"
         $end_gene   = "AAAAACCC"
         @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
  Output: -1

Example 4

  Input: $start_gene = "GAAAAAAA"
         $end_gene   = "GCCCCCCC"
         @gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA",
                        "GCCCCCAA", "GCCCCCCA", "GCCCCCCC")
  Output: 7

  "GAAAAAAA" => "GCAAAAAA"
  "GCAAAAAA" => "GCCAAAAA"
  "GCCAAAAA" => "GCCCAAAA"
  "GCCCAAAA" => "GCCCCAAA"
  "GCCCCAAA" => "GCCCCCAA"
  "GCCCCCAA" => "GCCCCCCA"
  "GCCCCCCA" => "GCCCCCCC"

Example 5

  Input: $start_gene = "AACCGGTT"
         $end_gene   = "AACCGGTT"
         @gene_bank = ("AACCGGTA")
  Output: 0

  The current genetic sequence already matches the desired end gene.
  No mutations are necessary, so the result is 0.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A start gene string, an end gene string, and a list of gene strings (the gene
   bank), are entered on the command-line.
3. If -v (or --verbose) is entered on the command-line, the first minimum path 
   (if any) is displayed after the standard output.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( none );
use Set::Tiny;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v] <start-gene> <end-gene> [<gene-bank> ...]
  perl $0

    <start-gene>         Start gene string
    <end-gene>           End gene string
    [<gene-bank> ...]    List of gene strings
    -v                   Show path (if any)? [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 400, Task #2: Minimum Genetic Mutation (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $verbose;

    GetOptions( verbose => \$verbose ) or error( 'Invalid command-line flag' );

    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        error( 'Expected 0 or 2+ arguments, found 1' );
    }
    else
    {
        my  ($start_gene, $end_gene, @gene_bank) = @ARGV;

        for ($start_gene, $end_gene, @gene_bank)
        {
            / ^ [ACGT]{8} $ /x or error( qq["$_" is not a valid gene string] );
        }

        print  qq[Input:  \$start_gene =  "$start_gene"\n];
        print  qq[        \$end_gene   =  "$end_gene"\n];
        printf qq[        \@gene_bank  = (%s)\n],
               join ', ', map { qq["$_"] } @gene_bank;

        my $path  = find_min_path( $start_gene, $end_gene, @gene_bank );
        my $elems = scalar @$path;

        printf "Output: %d\n", $elems - 1;
        printf "\nPath: %s\n", join ' => ', map { qq["$_"] } @$path
                if $verbose && $elems > 0;
    }
}

#-------------------------------------------------------------------------------
sub find_min_path
#-------------------------------------------------------------------------------
{
    my ($start_gene, $end_gene, @gene_bank) = @_;
    my  @min_path;

    if ($start_gene eq $end_gene)
    {
        push @min_path, $start_gene;
    }
    else
    {
        my  $bank = Set::Tiny->new( @gene_bank );

        if ($bank->contains( $end_gene ))
        {
            my @paths;
            my @local_path = $start_gene;

            find_paths( $end_gene, $bank, \@paths, \@local_path );

            if (scalar @paths > 0)
            {
                push @min_path, @{ $paths[0] };

                for my $i (1 .. $#paths)
                {
                    if (scalar @{ $paths[$i] } < scalar @min_path)
                    {
                        @min_path = @{ $paths[$i] };
                    }
                }
            }
        }
    }

    return \@min_path;
}

#-------------------------------------------------------------------------------
sub find_paths                                            # Recursive subroutine
#-------------------------------------------------------------------------------
{
    my ($end_gene, $gene_bank, $paths, $local_path) = @_;
    my  $candidates = get_mutation_candidates( $local_path->[-1], $gene_bank );

    for my $candidate (@$candidates)
    {
        if    ($candidate eq $end_gene)                   # Success: path found
        {
            push @$local_path, $end_gene;
            push @$paths, [ @$local_path ];
            pop  @$local_path;
        }
        elsif (none { $candidate eq $_ } @$local_path)    # Continue searching
        {
            push @$local_path, $candidate;
            find_paths( $end_gene, $gene_bank, $paths, $local_path );
            pop  @$local_path;
        }
    }
}

#-------------------------------------------------------------------------------
sub get_mutation_candidates
#-------------------------------------------------------------------------------
{
    my ($start_gene, $gene_bank) = @_;
    my  @candidates;

    for my $element ($gene_bank->elements)
    {
        my $diffs = find_str_diffs( $start_gene, $element );

        push @candidates, $element if scalar @$diffs == 1;
    }

    return \@candidates;
}

#-------------------------------------------------------------------------------
sub find_str_diffs
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;

    length $str1 == length $str2 or die 'Invalid parameters, stopped';

    my @str1 = split //, $str1;
    my @str2 = split //, $str2;
    my @diffs;

    for my $i (0 .. $#str1)
    {
        push @diffs, $i if $str1[$i] ne $str2[$i];
    }

    return \@diffs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        while ($line =~ / \\ $ /x)
        {
            $line    =~ s/ \s* \\ \n $ //x;
            my $next =  <DATA>;
            $next    =~ s/ ^ \s+ //x;
            $line   .=  $next;
        }

        chomp $line;

        my  ($test_name, $start, $end, $expected, @bank) = split / \| /x, $line;

        for ($test_name, $start, $end, $expected, @bank)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $path = find_min_path( $start, $end, @bank );

        is scalar( @$path ) - 1, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|AACCGGTT|AACCGGTA|-1|AACCGCTA|AAACGGTA
Example 2|AACCGGTT|AACCGGAA| 2|AACCGGTA|AACCGGAA|AACCGCTA|AACCCTAA|AACCGTAA
Example 3|AAAAAAAA|AAAAACCC|-1|CAAAAAAA|CCAAAAAA|AAAAAAAC
Example 4|GAAAAAAA|GCCCCCCC| 7|GCAAAAAA|GCCAAAAA|GCCCAAAA|GCCCCAAA|GCCCCCAA|   \
          GCCCCCCA|GCCCCCCC
Example 5|AACCGGTT|AACCGGTT| 0|AACCGGTA
