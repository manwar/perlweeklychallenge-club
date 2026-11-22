use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A start gene string, an end gene string, and a list of gene strings (the gene
   bank), are entered on the command-line.
3. If -v is entered on the command-line, the first minimum path (if any) is
   displayed after the standard output.

=end comment
#===============================================================================

use Test;

subset Gene of Str where / ^ <[ACGT]> ** 8 $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 400, Task #2: Minimum Genetic Mutation (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Gene:D $start-gene,                            #= Start gene string
    Gene:D $end-gene,                              #= End   gene string
          *@gene-bank where { .all ~~ Gene:D },    #= List of gene strings
    Bool:D :v($verbose) = False                    #= Show path (if any)?
)
#===============================================================================
{
    qq[Input:  \$start-gene =  "$start-gene"].put;
    qq[        \$end-gene   =  "$end-gene"].put;
    qq[        \@gene-bank  = (%s)\n].printf:
                @gene-bank.map( { qq["$_"] } ).join: ', ';

    my Gene @path = find-min-path( $start-gene, $end-gene, @gene-bank );

    "Output: %d\n".printf: @path.elems - 1;

    if $verbose && @path.elems > 0
    {
        "\nPath: %s\n".printf: @path.map( { qq["$_"] } ).join: ' => ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-path
(
    Gene:D         $start-gene,
    Gene:D         $end-gene,
    List:D[Gene:D] $gene-bank
--> List:D[Gene:D]
)
#-------------------------------------------------------------------------------
{
    my Gene @min-path;

    if $start-gene eq $end-gene
    {
        @min-path.push: $start-gene;
    }
    else
    {
        my Set[Gene] $bank = Set[Gene].new: |$gene-bank;

        if $end-gene ∈ $bank
        {
            my Array[Array[Gene]] $paths      = Array[Array[Gene]].new;
            my Gene               @local-path = $start-gene;

            find-paths( $end-gene, $gene-bank, $paths, @local-path );

            if $paths.elems > 0
            {
                @min-path = |$paths[0];

                for 1 .. $paths.end -> UInt $i
                {
                    if @min-path.elems > $paths[$i].elems
                    {
                        @min-path = |$paths[$i];
                    }
                }
            }
        }
    }

    return @min-path;
}

#-------------------------------------------------------------------------------
sub find-paths                                            # Recursive subroutine
(
    Gene:D                 $end-gene,
    List:D[Gene:D]         $gene-bank,
    List:D[List:D[Gene:D]] $paths is rw,
    List:D[Gene:D]         $local-path
)
#-------------------------------------------------------------------------------
{
    my Gene @candidates = get-mutation-candidates( $local-path[*-1],
                                                   $gene-bank );

    for @candidates -> Gene $candidate
    {
        if     $candidate eq $end-gene                    # Success: path found
        {
            $local-path.push: $end-gene;
            $paths.push: $local-path.clone;
            $local-path.pop;
        }
        elsif $candidate eq $local-path.none              # Continue searching
        {
            $local-path.push: $candidate;
            find-paths( $end-gene, $gene-bank, $paths, $local-path );
            $local-path.pop;
        }
    }
}

#-------------------------------------------------------------------------------
sub get-mutation-candidates
(
    Gene:D         $start-gene,
    List:D[Gene:D] $gene-bank
--> List:D[Gene:D]
)
#-------------------------------------------------------------------------------
{
    my Gene @candidates;

    for @$gene-bank -> Gene $element
    {
        my $diffs = find-str-diffs( $start-gene, $element );

        @candidates.push: $element if $diffs.elems == 1;
    }

    return @candidates;
}

#-------------------------------------------------------------------------------
sub find-str-diffs
(
    Str:D $str1,
    Str:D $str2 where { $str2.chars == $str1.chars }
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my Str  @str1 = $str1.split: '', :skip-empty;
    my Str  @str2 = $str2.split: '', :skip-empty;
    my UInt @diffs;

    for 0 .. @str1.end -> UInt $i
    {
        @diffs.push: $i if @str1[ $i ] ne @str2[ $i ];
    }

    return @diffs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $start, $end, $expected,  @bank) = $line.split: '|';

        for     $test-name, $start, $end, $expected, |@bank
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Gene @path = find-min-path( $start, $end, @bank );

        is (@path.elems - 1), $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $data = q:to/END/;
        Example 1|AACCGGTT|AACCGGTA|-1|AACCGCTA|AAACGGTA
        Example 2|AACCGGTT|AACCGGAA| 2|AACCGGTA|AACCGGAA|AACCGCTA|AACCCTAA|    \
                                       AACCGTAA
        Example 3|AAAAAAAA|AAAAACCC|-1|CAAAAAAA|CCAAAAAA|AAAAAAAC
        Example 4|GAAAAAAA|GCCCCCCC| 7|GCAAAAAA|GCCAAAAA|GCCCAAAA|GCCCCAAA|    \
                                       GCCCCCAA|GCCCCCCA|GCCCCCCC
        Example 5|AACCGGTT|AACCGGTT| 0|AACCGGTA
        END

    return S:g/ \s+ \\ \n \s* // given $data;
}

################################################################################
