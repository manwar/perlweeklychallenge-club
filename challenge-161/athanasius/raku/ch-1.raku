use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 161
=========================

TASK #1
-------
*Abecedarian Words*

Submitted by: Ryan J Thompson

An abecedarian word is a word whose letters are arranged in alphabetical order.
For example, "knotty” is an abecedarian word, but “knots” is not. Output or
return a list of all abecedarian words in the [ https://github.com/manwar/
perlweeklychallenge-club/blob/master/data/dictionary.txt |dictionary], sorted
in decreasing order of length.

Optionally, using only abecedarian words, leave a short comment in your code to
make your reviewer smile.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Abecedarian comment
-------------------
An abbot in an abbey abhors a bossy boor.

=end comment
#==============================================================================

my Str constant $COMMENT    = 'An abbot in an abbey abhors a bossy boor.';
my Str constant $DICTIONARY = 'dictionary.txt';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 161, Task #1: Abecedarian Words (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Str @abecedarians;

    for $DICTIONARY.IO.lines -> Str $line
    {
        @abecedarians.push: $line if is-abecedarian( $line );
    }

    @abecedarians.= sort: { $^b.chars <=> $^a.chars };

    ("The %d abecedarian words in %s, sorted from longest to shortest:\n\n" ~
     "%s\n\n%s\n").printf: +@abecedarians,              $DICTIONARY,
                            @abecedarians.join( "\t" ), $COMMENT;
}

#------------------------------------------------------------------------------
sub is-abecedarian( Str:D $word --> Bool:D )
#------------------------------------------------------------------------------
{
    my Str @letters = $word.split: '', :skip-empty;

    for 1 .. @letters.end -> UInt $i
    {
        return False if @letters[ $i ] lt @letters[ $i - 1 ];
    }

    return True;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
