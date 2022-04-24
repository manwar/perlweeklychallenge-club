#!perl

###############################################################################
=comment

Perl Weekly Challenge 161
=========================

TASK #1
-------
*Abecedarian Words*

Submitted by: Ryan J Thompson

An abecedarian word is a word whose letters are arranged in alphabetical order.
For example, "knotty" is an abecedarian word, but "knots" is not. Output or
return a list of all abecedarian words in the [ https://github.com/manwar/
perlweeklychallenge-club/blob/master/data/dictionary.txt |dictionary], sorted
in decreasing order of length.

Optionally, using only abecedarian words, leave a short comment in your code to
make your reviewer smile.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Abecedarian comment
-------------------
An abbot in an abbey abhors a bossy boor.

=cut
#==============================================================================

use strict;
use warnings;
use autodie;
use Const::Fast;

const my $COMMENT    => 'An abbot in an abbey abhors a bossy boor.';
const my $DICTIONARY => 'dictionary.txt';
const my $USAGE      => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 161, Task #1: Abecedarian Words (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args and die "ERROR: Expected 0 command line arguments, found $args" .
                     "\n$USAGE";

    my @abecedarians;

    open my $fh, '<', $DICTIONARY;

    while (my $line = <$fh>)
    {
        chomp $line;
        push  @abecedarians, $line if is_abecedarian( $line );
    }

    close $fh;

    @abecedarians = sort { length $b <=> length $a } @abecedarians;

    printf "The %d abecedarian words in %s, sorted from longest to shortest:" .
           "\n\n%s\n\n%s\n", scalar @abecedarians,   $DICTIONARY,
                        join( "\t", @abecedarians ), $COMMENT;
}

#------------------------------------------------------------------------------
sub is_abecedarian
#------------------------------------------------------------------------------
{
    my ($word)   = @_;
    my  @letters = split '', $word;

    for my $i (1 .. $#letters)
    {
        return 0 if $letters[ $i ] lt $letters[ $i - 1 ];
    }

    return 1;
}

###############################################################################
