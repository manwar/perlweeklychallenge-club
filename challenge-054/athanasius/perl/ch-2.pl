#!perl

################################################################################
=comment

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
1000000 (1e6), and output the starting number and sequence length for the long-
est 20 sequences.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use List::Priority;
use Scalar::Util::Numeric qw( isint );
use constant
{
    DEBUG => 0,
    TIMER => 1,
};

const my $MAX_TERMS =>  20;
const my $MAX_N     => 1e6;
const my $MAX_N_STR => commas( $MAX_N );
const my $BAR       => '-' x 30 . "\n";
const my $USAGE     =>
     "USAGE: perl $0 <N> - find the Collatz sequence for positive integer N\n" .
     "   OR  perl $0     - find the $MAX_TERMS longest sequences for N up to " .
                          "$MAX_N_STR\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

    my $t0 = [gettimeofday] if TIMER;

    print "Challenge 054, Task #2: Collatz Conjecture (Perl)\n\n";

    if (scalar @ARGV == 0)
    {
        printf "The %d longest Collatz sequences for N up to %s:\n\n%s       " .
               "  Starting    Sequence\n Rank   Number (N)    Length\n%s",
                $MAX_TERMS, $MAX_N_STR, $BAR, $BAR;

        my $seqs = find_longest_seqs();

        printf "%4d%13s%10d\n", ($_ + 1), commas($seqs->[$_][0]), $seqs->[$_][1]
            for 0 .. $MAX_TERMS - 1;

        print $BAR;
    }
    elsif (scalar @ARGV == 1)
    {
        my $n     = $ARGV[0];
        my $seq   = find_seq($n);
        my $terms = scalar @$seq;

        printf "The Collatz sequence (of %d term%s) for N = %s:\n%s\n",
                $terms, $terms == 1 ? '' : 's', commas($n), join ' -> ', @$seq;
    }
    else
    {
        die $USAGE;
    }

    printf "\n%.1f seconds\n", tv_interval($t0) if TIMER;
}

#-------------------------------------------------------------------------------
sub find_longest_seqs
#-------------------------------------------------------------------------------
{
    my $longest_seqs = List::Priority->new(capacity => $MAX_TERMS);
       $longest_seqs->insert(1, 1);

    my $max = 1                              if DEBUG;
    print "Max seq length: [  1,       1]\n" if DEBUG;

    for my $start (2 .. $MAX_N)
    {
        my $terms = count_terms($start);

        if (DEBUG && $terms > $max)
        {
            $max = $terms;
            printf "Max seq length: [%3d, %7d]\n", $terms, $start;
        }

        $longest_seqs->insert($terms, $start);
    }

    my @longest_seqs;

    while ($longest_seqs->size > 0)
    {
        my $seq_len = $longest_seqs->highest_priority;
        my $start   = $longest_seqs->pop;

        push @longest_seqs, [ $start, $seq_len ];
    }

    return \@longest_seqs;
}

#===============================================================================
# Memoize Collatz sequences (chains)
#===============================================================================
{
    my %chains;

    #---------------------------------------------------------------------------
    BEGIN
    #---------------------------------------------------------------------------
    {
        $chains{ 1 } = 1;
    }

    #---------------------------------------------------------------------------
    sub count_terms
    #---------------------------------------------------------------------------
    {
        my ($n) = @_;

        return $chains{ $n } if exists $chains{ $n };

        no warnings 'recursion';

        return $chains{ $n } = 1 + count_terms( $n / 2     ) unless $n % 2;
        return $chains{ $n } = 1 + count_terms( $n * 3 + 1 );
    }
}

#-------------------------------------------------------------------------------
sub find_seq
#-------------------------------------------------------------------------------
{
    my ($n) = @_;

    die $USAGE unless isint($n) && $n > 0;

    my @seq = ($n);

    push @seq, $n = ($n % 2) ? (3 * $n + 1) : ($n / 2) while $n > 1;

    return \@seq;
}

#-------------------------------------------------------------------------------
sub commas
#-------------------------------------------------------------------------------
{
    my ($number) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $number =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/gr;
}

################################################################################
