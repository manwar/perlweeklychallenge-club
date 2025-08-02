#!perl

################################################################################
=comment

Perl Weekly Challenge 294
=========================

TASK #1
-------
*Consecutive Sequence*

Submitted by: Mohammad Sajid Anwar

You are given an unsorted array of integers, @ints.

Write a script to return the length of the longest consecutive elements se-
quence. Return -1 if none found. The algorithm must runs in O(n) time.

Example 1

  Input: @ints = (10, 4, 20, 1, 3, 2)
  Output: 4

  The longest consecutive sequence (1, 2, 3, 4).
  The length of the sequence is 4.

Example 2

  Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
  Output: 9

Example 3

  Input: @ints = (10, 30, 20)
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty, unsorted list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 294, Task #1: Consecutive Sequence (Perl)\n\n";
}

#-------------------------------------------------------------------------------
package Range
#-------------------------------------------------------------------------------
{
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub new
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($class, $low, $high) = @_;

        my  %self = (low => $low, high => $high);

        return bless \%self, $class;
    }

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub size
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($self) = @_;

        return $self->{ high } - $self->{ low } + 1;
    }
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @ints = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $max_seq = find_max_seq( \@ints );

        print  "Output: $max_seq\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_seq
#-------------------------------------------------------------------------------
{
    my ($ints)       = @_;
    my  $max_seq_len = 1;
    my (%n2seq, %edge, @seqs);

    for my $n (@$ints)
    {
        unless (exists $n2seq{ $n })
        {
            if (exists  $edge{ $n })
            {
                my  $seq_len = merge( $n, \%n2seq, \%edge, \@seqs );
                $max_seq_len = $seq_len if $seq_len > $max_seq_len;
            }
            else
            {
                add_singleton( $n, \%n2seq, \%edge, \@seqs );
            }
        }
    }

    return $max_seq_len <= 1 ? -1 : $max_seq_len;
}

#-------------------------------------------------------------------------------
sub merge
#-------------------------------------------------------------------------------
{
    my ($n, $n2seq, $edge, $seqs) = @_;
    my ($left, $right) = @{ $edge->{ $n } };
    my  $range;

    if    (defined $left && defined $right)
    {
        my $seq_id_l = $n2seq  ->{ $n - 1    };
           $range    = $seqs   ->[ $seq_id_l ];
        my $seq_id_r = $n2seq  ->{ $n + 1    };
        my $range_r  = $seqs   ->[ $seq_id_r ];
        my $high     = $range_r->{ high      };

        $range->{ high      } = $high;
        $n2seq->{ $n        } = $n2seq->{ $high } = $seq_id_l;
        $seqs ->[ $seq_id_r ] = undef;
    }
    elsif (defined $left)
    {
        my $seq_id = $n2seq->{ $n - 1  };
           $range  = $seqs ->[ $seq_id ];

        $range->{ high } = $n;
        $n2seq->{ $n   } = $edge->{ $n + 1 }[ 0 ] = $seq_id;
    }
    else # defined $right
    {
        my $seq_id = $n2seq->{ $n + 1  };
           $range  = $seqs ->[ $seq_id ];

        $range->{ low  } = $n;
        $n2seq->{ $n   } = $edge->{ $n - 1 }[ 1 ] = $seq_id;
    }

    delete $edge->{ $n };

    return $range->size;
}

#-------------------------------------------------------------------------------
sub add_singleton
#-------------------------------------------------------------------------------
{
    my ($n, $n2seq, $edge, $seqs) = @_;
    my  $seq = Range->new( $n, $n );

    push @$seqs, $seq;

    my $seq_id     = $#$seqs;
    $n2seq->{ $n } = $seq_id;

    if (exists $edge->{ $n - 1 })
    {
        $edge->{ $n - 1 }[ 1 ] = $seq_id;
    }
    else
    {
        $edge->{ $n - 1 } = [ undef, $seq_id ];
    }

    if (exists $edge->{ $n + 1 })
    {
        $edge->{ $n + 1 }[ 0 ] = $seq_id;
    }
    else
    {
        $edge->{ $n + 1 } = [ $seq_id, undef ];
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints    = split / \s+ /x, $ints_str;
        my $max_seq = find_max_seq( \@ints );

        is $max_seq, $expected, $test_name;
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
Example 1|10  4 20 1 3 2        | 4
Example 2| 0  6  1 8 5 2 4 3 0 7| 9
Example 3|10 30 20              |-1
