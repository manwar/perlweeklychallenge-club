#!perl

################################################################################
=comment

Perl Weekly Challenge 019
=========================

Task #2
-------
Write a script that can wrap the given paragraph at a specified column using the
[ https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines
|greedy algorithm].

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $COLUMN   => 79;
const my $INDENT   =>  0;
const my $SPACE    => ' ';
const my $SP_WIDTH => length $SPACE;
const my $ERROR    => 'Error in command line arguments: ';
const my $USAGE    =>
            "\nUSAGE: perl $0 [ --column   uint ] [ --indent uint ]\n" .
         "                    < --filename string | --text string >\n";

MAIN:
{
    my ($column, $indent, $text) = parse_command_line();

    my  $wrapped_text  = '';
        $wrapped_text .= line_wrap_greedy($column, $indent, $_) . "\n"
            for split m{ \n }x, $text;

    print "\n", $wrapped_text;
}

sub parse_command_line
{
    my ($column, $indent) = ($COLUMN, $INDENT);
    my ($file,   $text);

    GetOptions
    (
        'file=s'   => \$file,
        'text=s'   => \$text,
        'column=i' => \$column,
        'indent=i' => \$indent,

    ) or die $USAGE;

    ( defined $file ||  defined $text)
        or die "\n${ERROR}missing filename or text\n$USAGE";

    (!defined $file || !defined $text)
        or die "\n${ERROR}both filename and text given\n$USAGE";

    $column >  0 or die "\n${ERROR}invalid column value \"$column\"\n$USAGE";
    $indent >= 0 or die "\n${ERROR}invalid indent value \"$indent\"\n$USAGE";

    if (defined $file)
    {
        length $file > 0
            or die "\n${ERROR}empty filename\n$USAGE";

        open my $fh, '<', $file
            or die "\nCannot open file \"$file\" for reading, stopped";

        local $/;           # Slurp
        $text = <$fh>;

        close $fh
            or die "\nCannot close file \"$file\" (opened for reading), " .
                     'stopped';
    }
    elsif (length $text == 0)
    {
        die "\n${ERROR}empty text\n$USAGE";
    }

    return ($column, $indent, $text);
}

sub line_wrap_greedy
{
    my ($column, $indent, $paragraph) = @_;
    my  $wrapped = '';

    if (length $paragraph > 0)
    {
        $paragraph =~ m{ \n }x
            and die "Line break in paragraph \"$paragraph\", stopped";

        my @words = split m{ \s+ }x, $paragraph;

        # Indent the first word in the paragraph

           $wrapped   = ($SPACE x $indent) . shift @words;
        my $remaining = $column - length $wrapped;

        # Place the remaining words in the paragraph using the greedy algorithm

        for my $word (@words)
        {
            my $length = length $word;

            if (($length + $SP_WIDTH) > $remaining) # Start a new line
            {
                $wrapped   .= "\n" . $word;
                $remaining  = $column - $length;
            }
            else                                    # Continue the existing line
            {
                $wrapped   .= $SPACE . $word;
                $remaining -= $SP_WIDTH + $length;
            }
        }
    }

    return $wrapped;
}

################################################################################

__END__

From Wikipedia:

Line wrap and word wrap
=======================

4 Algorithm
-----------

Word wrapping is an optimization problem. Depending on what needs to be opti-
mized for, different algorithms are used.

4.1 Minimum number of lines
- - - - - - - - - - - - - -

A simple way to do word wrapping is to use a greedy algorithm that puts as many
words on a line as possible, then moving on to the next line to do the same
until there are no more words left to place. This method is used by many modern
word processors, such as OpenOffice.org Writer and Microsoft Word. This algo-
rithm always uses the minimum possible number of lines but may lead to lines of
widely varying lengths. The following pseudocode implements this algorithm:

    SpaceLeft := LineWidth
    for each Word in Text
        if (Width(Word) + SpaceWidth) > SpaceLeft
            insert line break before Word in Text
            SpaceLeft := LineWidth - Width(Word)
        else
            SpaceLeft := SpaceLeft - (Width(Word) + SpaceWidth)

Where LineWidth is the width of a line,
      SpaceLeft is the remaining width of space on the line to fill,
      SpaceWidth is the width of a single space character,
      Text is the input text to iterate over
  and Word is a word in this text.
