use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 098
=========================

Task #1
-------
*Read N-characters*

Submitted by: Mohammad S Anwar

You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and
moves the pointer to the (n+1)th character.

Example:

 Input: Suppose the file (input.txt) contains "1234567890"
 Output:
     print readN("input.txt", 4); # returns "1234"
     print readN("input.txt", 4); # returns "5678"
     print readN("input.txt", 4); # returns "90"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The subroutine readN()'s parameter $FILE is a file *name*. In Raku, an IO::
Handle object contains an in-built pointer to the next character in the file.
So, the implementation of readN() given below uses a local, persistent hash to
match file names to their corresponding handles; the remaining bookkeeping for
the file pointer is then performed "under the hood" by Raku itself.

The MAIN subroutine demonstrates readN()'s functionality using two small files:
'digit.txt' contains the digits 1 to 9 and 0 as in the Example, and 'alpha.txt'
contains the lowercase letters a to z. MAIN calls readN() ten times with alter-
nating filenames and assorted values of $number to show that:
  -- calls with different filenames are handled independently of each other
  -- readN() "remembers" the position of the next character from one call to
     another
  -- once the file is exhausted, calls to readN() return the empty string.

To be useful in practice, the readN() subroutine should also have a reset
facility. This is provided via a third, optional parameter to readN().

=end comment
#==============================================================================

my Str constant $DIGIT = 'digit.txt';
my Str constant $ALPHA = 'alpha.txt';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 098, Task #1: Read N-characters (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
      'Input:'.put;
    qq[  File "%s" contains "%s"\n].printf: $DIGIT, $DIGIT.IO.slurp;
    qq[  File "%s" contains "%s"\n].printf: $ALPHA, $ALPHA.IO.slurp;
    "\nOutput:".put;

    for $DIGIT => 4, $ALPHA => 5, $DIGIT => 3, $ALPHA => 3, $DIGIT => 1,
        $ALPHA => 4, $DIGIT => 7, $ALPHA => 4, $DIGIT => 2
    {
        my $string = readN( .key, .value );

        qq[  Read %d character%s from %s: "%s"\n].printf:
            .value, (.value == 1) ?? ' ' !! 's', .key, $string;
    }

    qq[  Reset and\n  read 3 characters from $DIGIT: "%s"\n].printf:
        readN( $DIGIT, 3, True );
}

#------------------------------------------------------------------------------
sub readN
(
    Str:D  $FILE,                   #= Filename
    UInt:D $number where * > 0,     #= Number of characters to read
    Bool:D $reset = False,          #= Reset file pointer to beginning of file?
--> Str:D                           #= The characters read (if any)
)
#------------------------------------------------------------------------------
{
    state IO::Handle %pointers;
    my    IO::Handle $pointer = %pointers{ $FILE };

    if $pointer.defined
    {
        $pointer.seek( 0, SeekFromBeginning ) if $reset;
    }
    else
    {
        $pointer = %pointers{ $FILE } = $FILE.IO.open;
    }

    my Str $text = '';

    for 1 .. $number
    {
        if (my Str $char = $pointer.getc).defined
        {
            $text ~= $char;
        }
        else
        {
            last;
        }
    }

    return $text;
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
