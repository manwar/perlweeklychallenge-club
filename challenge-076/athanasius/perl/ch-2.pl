#!perl

################################################################################
=comment

Perl Weekly Challenge 076
=========================

Task #2
-------
*Word Search*

Submitted by: Neil Bowers
Reviewed by:  Ryan Thompson

Write a script that takes two file names. The first file would contain word
search grid as shown below. The second file contains list of words, one word per
line. You could even use local dictionary file.

Print out a list of all words seen on the grid, looking both orthogonally and
diagonally, backwards as well as forwards.

Search Grid

 B I D E M I A T S U C C O R S T
 L D E G G I W Q H O D E E H D P
 U S E I R U B U T E A S L A G U
 N G N I Z I L A I C O S C N U D
 T G M I D S T S A R A R E I F G
 S R E N M D C H A S I V E E L I
 S C S H A E U E B R O A D M T E
 H W O V L P E D D L A I U L S S
 R Y O N L A S F C S T A O G O T
 I G U S S R R U G O V A R Y O C
 N R G P A T N A N G I L A M O O
 E I H A C E I V I R U S E S E D
 S E T S U D T T G A R L I C N H
 H V R M X L W I U M S N S O T B
 A E A O F I L C H T O D C A E U
 Z S C D F E C A A I I R L N R F
 A R I I A N Y U T O O O U T P F
 R S E C I S N A B O S C N E R A
 D R S M P C U U N E L T E S I L

Output

Found 55 words of length 5 or more when checked against the local dictionary.
You may or may not get the same result but that is fine.

argos, constitution, margo, patna, traci, tracie, aimed, align, antes, arose,
ashed, blunt, blunts, broad, buries, clove, cloven, constitution, constitutions,
croon, depart, departed, enter, filch, garlic, goats, grieve, grieves, hazard,
liens, malign, malignant, malls, midst, ought, ovary, parted, pudgiest, quash,
quashed, raped, ruses, shrine, shrines, social, socializing, spasm, spasmodic,
succor, succors, theorem, theorems, virus, viruses, wigged

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                    # Exports:
use strict;
use warnings;
use Const::Fast;                    # const()
use FindBin        qw( $RealBin );
use Getopt::Long;                   # GetOptions
use Regexp::Common qw( number );    # %RE{num}

const my $LIB_DIR            => "$RealBin/../lib";
const my $DEFAULT_GRID_FILE  => "$LIB_DIR/example-grid.txt";
const my $DEFAULT_DICT_FILE  => "$LIB_DIR/linuxwords.txt";
const my $DEFAULT_MIN_LENGTH =>  5;
const my $SCREEN_WIDTH       => 80;
const my $USAGE              =>
"Usage:
  perl $0 [--grid <Str>] [--dict <Str>] [--min <UInt>]

    --grid <Str>    Name of file containing a word search grid
    --dict <Str>    Name of a dictionary file: valid words, one per line
    --min <UInt>    Minimum search-word length (must be > 0)\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 076, Task #2: Word Search (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my  ($grid, $dict, $min) = parse_command_line();

    my   @grid_lines   = read_grid($grid)->@*;

    my   @search_lines = @grid_lines;   # The horizontal lines
    push @search_lines, get_vertical_lines(\@grid_lines)->@*;
    push @search_lines, get_diagl_dn_lines(\@grid_lines)->@*;
    push @search_lines, get_diagl_up_lines(\@grid_lines)->@*;

    my   $dictionary   = create_dictionary($dict, $min);
    my   $found        = search_grid($min, $dictionary, \@search_lines);

    printf "Found %d different words of length %d or more:\n\n",
            scalar keys %$found, $min;
    print_words($found);
}

#-------------------------------------------------------------------------------
sub search_grid
#-------------------------------------------------------------------------------
{
    my ($min_len, $dict, $lines) = @_;
    my  %found;

    for my $line (@$lines)
    {
        my $line_length = length $line;

        if ($line_length >= $min_len)
        {
            # Search each line both forwards and backwards

            for my $search_space ($line, scalar reverse $line)
            {
                for my $begin (0 .. $line_length - $min_len - 1)
                {
                    for my $len ($min_len .. $line_length - $begin)
                    {
                        my $word = lc substr $search_space, $begin, $len;

                        ++$found{ $dict->{ $word } } if exists $dict->{ $word };
                    }
                }
            }
        }
    }

    return \%found;
}

#-------------------------------------------------------------------------------
sub read_grid
#-------------------------------------------------------------------------------
{
    my ($grid_file) = @_;

    open(my $fh, '<', $grid_file)
        or die "Cannot open file '$grid_file' for reading, stopped";

    my @grid_lines;

    while (my $line = <$fh>)
    {
        chomp $line;
        push @grid_lines, $line =~ s/\s+//gr;
    }

    close $fh
        or die "Cannot close file '$grid_file', stopped";

    return \@grid_lines;
}

#-------------------------------------------------------------------------------
sub get_vertical_lines
#-------------------------------------------------------------------------------
{
    my ($grid_lines) = @_;
    my  @search_lines;

    for my $i (0 .. length($grid_lines->[0]) - 1)
    {
        my $search_line  = '';
           $search_line .= substr $_, $i, 1 for @$grid_lines;

        push @search_lines, $search_line;
    }

    return \@search_lines;
}

#-------------------------------------------------------------------------------
sub get_diagl_dn_lines
#-------------------------------------------------------------------------------
{
    my ($grid_lines) = @_;

    my @lines;
    my $max_row = scalar(@$grid_lines)      - 1;
    my $max_col = length( $grid_lines->[0]) - 1;

    for my $first_row (reverse 0 .. $max_row)
    {
        my $line = '';
        my $col  = 0;

        for my $row ($first_row .. $max_row)
        {
            $line .= substr $grid_lines->[$row], $col, 1;
            last if ++$col > $max_col;
        }

        push @lines, $line;
    }

    for my $first_col (1 .. $max_col)
    {
        my $line = '';
        my $row  = 0;

        for my $col ($first_col .. $max_col)
        {
            $line .= substr $grid_lines->[$row], $col, 1;
            last if ++$row > $max_row;
        }

        push @lines, $line;
    }

    return \@lines;
}

#-------------------------------------------------------------------------------
sub get_diagl_up_lines
#-------------------------------------------------------------------------------
{
    my ($grid_lines) = @_;

    my @lines;
    my $max_row = scalar(@$grid_lines)      - 1;
    my $max_col = length( $grid_lines->[0]) - 1;

    for my $first_row (0 .. $max_row)
    {
        my $line = '';
        my $col  = 0;

        for my $row (reverse 0 .. $first_row)
        {
            $line .= substr $grid_lines->[$row], $col, 1;
            last if ++$col > $max_col;
        }

        push @lines, $line;
    }

    for my $first_col (1 .. $max_col)
    {
        my $line = '';
        my $row  = $max_row;

        for my $col ($first_col .. $max_col)
        {
            $line .= substr $grid_lines->[$row], $col, 1;
            last if --$row < 0;
        }

        push @lines, $line;
    }

    return \@lines;
}

#-------------------------------------------------------------------------------
sub create_dictionary
#-------------------------------------------------------------------------------
{
    my ($dict_file, $min_length) = @_;
    my  %dictionary;

    open(my $fh, '<', $dict_file)
        or die "Cannot open file '$dict_file' for reading, stopped";

    while (my $word = <$fh>)
    {
        chomp $word;

        # Note: Each word is recorded twice, the key in lower case, the value in
        # its original case. For dictionaries (such as linuxwords.txt) in which
        # some words are capitalised (Aarhus, Aaron, Ababa, Abba, ...) this
        # allows retrieval of the original case following hash look-up (which
        # necessarily uses uniform case, since case is not distinguished in the
        # word search grid).

        $dictionary{ lc $word } = $word if length $word >= $min_length;
    }

    close $fh
        or die "Cannot close file '$dict_file', stopped";

    return \%dictionary;
}

#-------------------------------------------------------------------------------
sub print_words
#-------------------------------------------------------------------------------
{
    # Print a list of the words found, *without* splitting words across lines

    my ($found) = @_;
    my  $line   = '';

    for my $word (sort keys %$found)
    {
        # Let n be the number of times "word" was found in the search grid;
        # then, if n > 1, append a count to display it as "word(n)"

        my $freq = $found->{ $word };

        $word .= "($freq)" if $freq > 1;

        # Allow 3 extra characters for the preceding ', ' and the following ','

        if (length($line) + length($word) + 3 >= $SCREEN_WIDTH)
        {
            print "$line,\n";
            $line = $word;
        }
        else
        {
            $line .= ', ' if $line;
            $line .= $word;
        }
    }

    print "$line\n";
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $grid = $DEFAULT_GRID_FILE;
    my $dict = $DEFAULT_DICT_FILE;
    my $min  = $DEFAULT_MIN_LENGTH;

    GetOptions
    (
        'grid=s' => \$grid,
        'dict=s' => \$dict,
        'min=i'  => \$min,
    )                                       or die $USAGE;

    scalar @ARGV == 0                       or die $USAGE;
    -f $grid                                or die $USAGE;
    -f $dict                                or die $USAGE;
    $min =~ /\A$RE{num}{int}\z/ && $min > 0 or die $USAGE;

    return ($grid, $dict, $min);
}

################################################################################
