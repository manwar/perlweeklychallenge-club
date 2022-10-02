use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 184
=========================

TASK #2
-------
*Split Array*

Submitted by: Mohammad S Anwar

You are given list of strings containing 0-9 and a-z separated by space only.

Write a script to split the data into two arrays, one for integers and one for
alphabets only.

Example 1

  Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
  Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]

Example 2

  Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
  Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
From Example 2 it appears that empty arrays should be omitted from the output.

Implementation
--------------
For convenience, identification of valid digit and letter characters is imple-
mented using Raku's in-built Set class.

=end comment
#==============================================================================

subset Split of List where (Array[UInt], Array[Str]);

my Set[Str] constant $VALID-DIGITS  = Set[Str].new: '0' .. '9';
my Set[Str] constant $VALID-LETTERS = Set[Str].new: 'a' .. 'z';
my Set[Str] constant $VALID-CHARS   = $VALID-DIGITS ∪ $VALID-LETTERS;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 184, Task #2: Split Array (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| List of strings: single chars (0-9, a-z), space-separated

    *@list where { .elems > 0 }
)
#==============================================================================
{
    my Array[Str] @string-arrays = parse-command-line( @list );

    "Input: @list = ( %s )\n".printf:
        @string-arrays.map( { "'$_'" } ).join: ', ';

    my Array[UInt] @digits;
    my Array[Str]  @letters;

    for @string-arrays -> Array[Str] $chars
    {
        my (Array[UInt] $digits, Array[Str] $letters) = split-array( $chars );

        @digits\.push: $digits  if $digits;
        @letters.push: $letters if $letters;
    }

    "Output: [%s] and [%s]\n".printf: fmt-int( @digits ), fmt-str( @letters );
}

#------------------------------------------------------------------------------
sub split-array( Array:D[Str:D] $chars --> Split:D )
#------------------------------------------------------------------------------
{
    my UInt @digits;
    my Str  @letters;

    for @$chars -> Str $char
    {
        if $char ∈ $VALID-DIGITS
        {
            @digits\.push: $char.Int;
        }
        else
        {
            @letters.push: $char;
        }
    }

    return @digits, @letters;
}

#------------------------------------------------------------------------------
sub parse-command-line( List:D[Str:D] $list --> List:D[List:D[Str:D]] )
#------------------------------------------------------------------------------
{
    my Array[Str] @strings;

    for @$list -> Str $string
    {
        my Str @chars = $string.split: / \s+ /, :skip-empty;

        for @chars -> Str $char
        {
            $char ∈ $VALID-CHARS
               or error( qq[Invalid string element "$char"] );
        }

        @strings.push: @chars;
    }

    return @strings;
}

#------------------------------------------------------------------------------
sub fmt-int( List:D[UInt:D] $list --> Str:D )
#------------------------------------------------------------------------------
{
    return $list.map( { '[' ~ .join( ',' ) ~ ']' } ).join( ', ' );
}

#------------------------------------------------------------------------------
sub fmt-str( List:D[Str:D] $list --> Str:D )
#------------------------------------------------------------------------------
{
    return $list.map( { '[' ~ .map( { "'$_'" } ).join( ',' ) ~ ']' } )\
                                                .join( ', ' );
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
