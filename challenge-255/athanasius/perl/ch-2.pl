#!perl

################################################################################
=comment

Perl Weekly Challenge 255
=========================

TASK #2
-------
*Most Frequent Word*

Submitted by: Mohammad Sajid Anwar

You are given a paragraph $p and a banned word $w.

Write a script to return the most frequent word that is not banned.

Example 1

  Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
         $w = "hit"
  Output: "ball"

  The banned word "hit" occurs 3 times.
  The other word "ball" occurs 2 times.

Example 2

  Input: $p = "Perl and Raku belong to the same family. Perl is the most popular
               language in the weekly challenge."
         $w = "the"
  Output: "Perl"

  The banned word "the" occurs 3 times.
  The other word "Perl" occurs 2 times.

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
2. If $VERBOSE is set to a true value, the output is followed by a short explan-
   ation like those in the Examples.

Assumptions
-----------
1. "Words" are composed of the letters A-Z, a-z, and ' (the apostrophe) ONLY.
2. Different forms of the same root word are treated as different words:
   "belong", "belongs", and "belonged" are 3 distinct words; "Perl" and "Perl's"
   are 2 distinct words.
3. Hyphenated words are not recognised as such: e.g., "cul-de-sac" is treated
   as 3 separate words.
4. Capitalisation.
   If a word appears with its initial letter both capitalised and uncapitalised,
   AND each occurrence of the capitalised version appears at the beginning of a
   sentence, then (and only then) the different forms are considered to be a
   single word, and that word's uncapitalised form is treated as canonical.
5. If two or more words share the same maximum frequency of occurrence, the
   alphabetically-first word is given as the output.

=cut
#===============================================================================

use v5.32.1;     # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $SCREEN_WIDTH => 80;
const my $TAB          => 14;
const my $VERBOSE      => 1;
const my $USAGE        => <<END;
Usage:
  perl $0 <p> <w>
  perl $0

    <p>    A paragraph of text
    <w>    A banned word
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 255, Task #2: Most Frequent Word (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my ($p, $w) = @ARGV;

        $p =~ /   [a-z]    /ix or error( 'The paragraph contains no words' );
        $w =~ / ^ [a-z]+ $ /ix or error( 'The banned word is not valid' );

        printf qq[Input:  \$p = "%s"\n], split_paragraph( $p );
        print  qq[        \$w = "$w"\n];

        my $result = find_most_freq_word( $p, $w );

        if (scalar @{ $result->{words} } == 0)
        {
            print "Output: <none>\n";
        }
        else
        {
            printf qq[Output: "%s"\n], $result->{words}[ 0 ];
        }

        explain_output( $w, $result ) if $VERBOSE;
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_most_freq_word
#-------------------------------------------------------------------------------
{
    my ($p, $w) = @_;

    # Remove (by replacing with spaces) all non-word characters, but leave 
    # apostrophes and sentence-ending punctuation characters in place

    $p =~ s/ [^A-Za-z'.?!\s] / /gx;

    my $first_words = find_first_words( $p );      # Words beginning sentences

    $p =~ s/ [.?!] / /gx;                          # Remove sentence terminators

    # Record all words, together with their frequencies of occurrence

    my %dict;
     ++$dict{ $_ } for split / \s+ /x, $p;

    merge_words( $first_words, \%dict ); # Merge capitalised/uncapitalised pairs

    my %result;

    remove_banned_word( $w, \%dict, \%result );

    my $max_freq = 0;

    $_ > $max_freq and $max_freq = $_ for values %dict;

    $result{ 'max-freq' } = $max_freq;

    my @words        = grep { $dict{ $_ } == $max_freq } keys %dict;
    $result{ words } = [ sort @words ];

    return \%result;
}

#-------------------------------------------------------------------------------
sub find_first_words
#-------------------------------------------------------------------------------
{
    my ($p) = @_;

    my @matches = $p =~ / (?= ^ \s* || [.?!] \s+) ([A-Z] \S*) /gx;

    my %first_words;
     ++$first_words{ $_ } for @matches;

    return \%first_words;
}

#-------------------------------------------------------------------------------
sub merge_words
#-------------------------------------------------------------------------------
{
    my ($first_words, $dict) = @_;

    for my $word (keys %$first_words)
    {
        my $lc_word = $word =~ s/ ^ (.) / lc( $1 ) /erx;

        if (exists $dict->{ $lc_word } &&
            $first_words->{ $word } == $dict->{ $word })
        {
            $dict->{ $lc_word } += $dict->{ $word };

            delete $dict->{ $word };
        }
    }
}

#-------------------------------------------------------------------------------
sub remove_banned_word
#-------------------------------------------------------------------------------
{
    my ($w, $dict, $result) = @_;

    $result->{ 'banned-word' } = 0;

    if (exists $dict->{ $w })                           # Remove the banned word
    {
        $result->{ 'banned-word' } = $dict->{ $w };

        delete $dict->{ $w };
    }
    else
    {
        my $lc_bw = $w =~ s/ ^ (.) / lc( $1 ) /erx;

        if (exists $dict->{ $lc_bw })      # Remove the banned word's lc version
        {
            $result->{ 'banned-word' } = $dict->{ $lc_bw };

            delete $dict->{ $lc_bw };
        }
    }
}

#-------------------------------------------------------------------------------
sub explain_output
#-------------------------------------------------------------------------------
{
    my ($w, $result) = @_;
    my  $w_freq      = $result->{ 'banned-word' };

    printf qq[\nThe banned word "%s" occurs %d time%s\n],
        $w, $w_freq, $w_freq == 1 ? '' : 's';

    my $freq  = $result->{ 'max-freq' };
    my $words = $result->{  words  };
    my $count = scalar @$words;

    if ($count == 0)
    {
        print "There are no other words\n";
    }
    else
    {
        printf qq[The other  word%s %s occur%s %d time%s%s\n],
            ($count == 1 ? ''  : 's'),
             join( ', ', map { qq["$_"] } @$words ),
            ($count == 1 ? 's' : ''),
             $freq,
            ($freq  == 1 ? ''  : 's'),
            ($count == 1 ? ''  : ' each');
    }
}

#-------------------------------------------------------------------------------
sub split_paragraph
#-------------------------------------------------------------------------------
{
    my ($p) = @_;

    # Insert "\n<tab>" at every $SCREEN_WIDTH position in $p

    my $insert = "\n" . ' ' x $TAB;

    for (my $i = $SCREEN_WIDTH - $TAB; $i < length $p; $i += $SCREEN_WIDTH)
    {
        --$i while substr( $p, $i, 1 ) =~ / \S /x;
        
        substr $p, $i, 1, $insert;
    }

    return $p;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        while ($line =~ / \+ $ /x)
        {
            $line .= <DATA>;
            $line =~ s/ \+ \n \s* //x;
        }

        chomp $line;

        my  ($test_name, $p, $w, $expected) = split / \| /x, $line;

        for ($test_name, $p, $w, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $result = find_most_freq_word( $p, $w );

        is $result->{words}[ 0 ], $expected, $test_name;
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

# For ease of copy/paste onto the command line:
=text
But, in a larger sense, we can not dedicate-we can not consecrate-we can not hallow-this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us-that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion-that we here highly resolve that these dead shall not have died in vain-that this nation, under God, shall have a new birth of freedom-and that government of the people, by the people, for the people, shall not perish from the earth.
=cut

################################################################################

__DATA__
Example 1 |Joe hit a ball, the hit ball flew far after it was hit.|hit|ball
Example 2 |Perl and Raku belong to the same family. Perl is the most popular   +
           language in the weekly challenge.|the|Perl
Gettysburg|But, in a larger sense, we can not dedicate-we can not consecrate-  +
           we can not hallow-this ground. The brave men, living and dead, who  +
           struggled here, have consecrated it, far above our poor power to    +
           add or detract. The world will little note, nor long remember what  +
           we say here, but it can never forget what they did here. It is for  +
           us the living, rather, to be dedicated here to the unfinished work  +
           which they who fought here have thus far so nobly advanced. It is   +
           rather for us to be here dedicated to the great task remaining      +
           before us-that from these honored dead we take increased devotion   +
           to that cause for which they gave the last full measure of devotion-+
           that we here highly resolve that these dead shall not have died in  +
           vain-that this nation, under God, shall have a new birth of freedom-+
           and that government of the people, by the people, for the people,   +
           shall not perish from the earth.|the|here
Case 1    |Perl and Raku belong to the same family. Perl is the most popular   +
           language in the weekly challenge.|The|Perl
Case 2    |x y a? X w a u! X ab a c and x|unknown|x
