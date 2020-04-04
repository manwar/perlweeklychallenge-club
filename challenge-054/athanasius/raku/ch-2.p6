use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 054
=========================

Task #2
*Collatz Conjecture*
*Contributed by Ryan Thompson*

It is thought that the following sequence will always reach 1:

  $n = $n / 2 when $n is even
  $n = 3*$n + 1 when $n is odd

For example, if we start at 23, we get the following sequence:

23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

Write a function that finds the *Collatz* sequence for any positive integer.
Notice how the sequence itself may go far above the original starting number.

*Extra Credit*

Have your script calculate the sequence length for _all_ starting numbers up to
1000000 (1e6), and output the starting number and sequence length for the
longest 20 sequences.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use Lingua::EN::Numbers;                            # For the comma() subroutine
use List::Priority:from<Perl5>;

my UInt constant MAX-N     = 1e6.UInt;
my UInt constant MAX-TERMS = 20;
my Str  constant BAR       = '-' x 30;
my Bool constant DEBUG     = False;

my Instant $t0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $t0 = now;
    ''.put;
}

#-------------------------------------------------------------------------------
END "\n%.1f seconds\n".printf: now - $t0;
#-------------------------------------------------------------------------------

#===============================================================================
multi sub MAIN         #= Find the MAX-TERMS longest sequences for N up to MAX-N
#===============================================================================
{
    "Challenge 054, Task #2: Collatz Conjecture (Raku)\n".put;

    ("The %d longest Collatz sequences for N up to %s:\n\n%s\n       " ~
        "  Starting    Sequence\n Rank   Number (N)    Length\n%s\n").printf:
        MAX-TERMS, comma(MAX-N), BAR, BAR;

    my @seqs = find-longest-seqs();

    "%4d%13s%10d\n".printf: ($_ + 1), comma( @seqs[$_][0] ), @seqs[$_][1]
        for 0 .. MAX-TERMS - 1;

    BAR.put;
}

#-------------------------------------------------------------------------------
sub find-longest-seqs( --> Array:D )
#-------------------------------------------------------------------------------
{
    my $longest-seqs = List::Priority.new(capacity => MAX-TERMS);
       $longest-seqs.insert(1, 1);

    my UInt $max = 1                         if DEBUG;
    print "Max seq length: [  1,       1]\n" if DEBUG;

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # N.B.: For MAX-N == 1e6, this for loop takes ~20 minutes to complete!
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for 2 .. MAX-N -> UInt $start
    {
        my UInt $terms = count-terms($start);

        if (DEBUG && $terms > $max)
        {
            $max = $terms;
            "Max seq length: [%3d, %7d]\n".printf: $terms, $start;
        }

        $longest-seqs.insert($terms, $start);
    }

    my @longest-seqs;

    while $longest-seqs.size > 0
    {
        my UInt $seq-len = $longest-seqs.highest_priority.UInt;
        my UInt $start   = $longest-seqs.pop;

        push @longest-seqs, [ $start, $seq-len ];
    }

    return @longest-seqs;
}

#-------------------------------------------------------------------------------
sub count-terms( UInt:D $n --> UInt:D )
#-------------------------------------------------------------------------------
{
    state  %chains = 1 => 1;            # Memoize

    return %chains{$n}                                  if %chains{$n}:exists;
    return %chains{$n} = 1 + count-terms(($n / 2).UInt) if $n % 2 == 0;
    return %chains{$n} = 1 + count-terms( $n * 3 + 1 );
}

#===============================================================================
multi sub MAIN
(
    UInt:D $N where $_ > 0   #= Find the Collatz sequence for positive integer N
)
#===============================================================================
{
    "Challenge 054, Task #2: Collatz Conjecture (Raku)\n".put;

    my UInt @seq = $N;
    my UInt $n   = $N;

    while $n > 1
    {
        $n = ($n % 2 == 0) ?? ($n / 2    ).UInt
                           !! ($n * 3 + 1);
        @seq.push: $n;
    }

    my UInt $terms = @seq.elems;

    "The Collatz sequence (of %d term%s) for N = %s:\n%s\n".printf:
        $terms, ($terms == 1 ?? '' !! 's'), comma($N), @seq.join: ' -> ';
}

################################################################################
