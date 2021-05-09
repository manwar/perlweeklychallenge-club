#!perl

###############################################################################
=comment

Perl Weekly Challenge 111
=========================

TASK #2
-------
*Ordered Letters*

Submitted by: E. Choroba

Given a word, you can sort its letters alphabetically (case insensitive). For
example, "beekeeper" becomes "beeeeekpr" and "dictionary" becomes "acdiinorty".

Write a script to find the longest English words that don't change when their
letters are sorted.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use autodie;
use Const::Fast;

const my $DICT_DIR   => '.';

# From https://github.com/dwyl/english-words
const my $IN_FILE    => "$DICT_DIR/words_alpha.txt";

const my $DICTIONARY => "$DICT_DIR/dict_by_length.tmp";

const my $USAGE      =>
"Usage:
  perl $0 [<file>]

    [<file>]    Name of the input dictionary file (optional)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 111, Task #2: Ordered Letters (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $in_file = parse_command_line();

    print "Dictionary: $in_file\n\n";

    order_dictionary( $in_file );

    open( my $fh, '<', $DICTIONARY );

    my @solutions;

    while (my $word = <$fh>)
    {
        chomp $word;

        last if scalar @solutions > 0 &&
                length $word < length $solutions[ -1 ];

        my $lc_word = lc $word;
        my @letters = split //, $lc_word;
        my $ordered = join '', sort @letters;

        push @solutions, $word if $ordered eq $lc_word;
    }

    close $fh;
    unlink $DICTIONARY;

    display_solutions( \@solutions );
}

#------------------------------------------------------------------------------
sub order_dictionary
#------------------------------------------------------------------------------
{
    my ($in_file) = @_;
    my  %out_fh;

    open( my $in, '<', $in_file );

    while (my $line = <$in>)
    {
        chomp $line;

        next if $line =~ /[^A-Za-z]/;

        my $len = length $line;
        my $out_fh;

        if (exists $out_fh{ $len })
        {
            $out_fh = $out_fh{ $len };
        }
        else       
        {
            my $out_file = "$DICT_DIR/dict_$len.tmp";

            open( $out_fh, '+>', $out_file );

            $out_fh{ $len } = $out_fh;
        }

        print $out_fh "$line\n";
    }

    close $in;

    open( my $out, '>', $DICTIONARY );

    for my $len (sort { $b <=> $a } keys %out_fh)
    {
        my $fh = $out_fh{ $len };

        seek $fh, 0, 0;

        while (my $line = <$fh>)
        {
            print $out $line;
        }
    }

    close $out;

    for my $len (keys %out_fh)
    {
        my $fh = $out_fh{ $len };
        close $fh;

        my $filename = "$DICT_DIR/dict_$len.tmp";
        unlink $filename;
    }
}

#------------------------------------------------------------------------------
sub display_solutions
#------------------------------------------------------------------------------
{
    my ($solutions) = @_;

    if ((my $count = scalar @$solutions) == 0)
    {
        print "No solutions found\n";
    }
    else
    {
        my $soln_len = length $solutions->[ 0 ];

        if ($count == 1)
        {
            printf "One solution found (%d letters in length): %s\n",
                    $soln_len, $solutions->[ 0 ];
        }
        else
        {
            printf "%d solutions found (each %d letters in length):\n",
                    $count, $soln_len;
            print  "  $_\n" for @$solutions;
        }
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    $args <= 1
             or error( "Expected 0 or 1 command line arguments, found $args" );

    my $file =  ($args == 1) ? $ARGV[0] : $IN_FILE;
       $file =~ s{ \\ }{/}gx;
    -e $file or error( qq[File "$file" not found] );
    -s $file or error( qq[File "$file" is empty] );
    -f $file or error( qq[File "$file" is not a plain file] );

    return $file;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
