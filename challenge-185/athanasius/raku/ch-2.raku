use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 185
=========================

TASK #2
-------
*Mask Code*

Submitted by: Mohammad S Anwar

You are given a list of codes in many random format.

Write a script to mask first four characters (a-z,0-9) and keep the rest as it
is.

Example 1

  Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
  Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')

Example 2

  Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
  Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

Assumption
----------
If fewer than 4 characters are eligible for masking, they will be masked but no
error will be reported. That is, the requirement is interpreted to be: "Write a
script to mask UP TO THE first four characters (a-z,0-9)...".

=end comment
#==============================================================================

use Test;

my Str      constant $MASK-CHAR    = 'x';
my UInt     constant $MASK-COUNT   =  4;
my Set[Str] constant $TARGET-CHARS =  Set[Str].new: |('a'..'z'), |('0'..'9');
my UInt     constant $TEST-FIELDS  =  3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 185, Task #2: Mask Code (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    *@list where { .elems > 0 }            #= List of code strings to be masked
)
#==============================================================================
{
    "Input: @list = (%s)\n".printf: @list\ .map( { "'$_'" } ).join: ', ';

    my @masked;

    for @list -> Str $code
    {
        @masked.push: mask( $code );
    }

    "Output:        (%s)\n".printf: @masked.map( { "'$_'" } ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($name, $in, $exp) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        is mask( $in ), $exp, $name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub mask( Str:D $code --> Str:D )
#------------------------------------------------------------------------------
{
    my Str  @chars  = $code.split: '', :skip-empty;
    my Str  $masked = '';
    my UInt $count  = 0;

    for @chars -> str $char
    {
        if $count < $MASK-COUNT && $char ∈ $TARGET-CHARS
        {
            $masked ~= $MASK-CHAR;
            ++$count;
        }
        else
        {
            $masked ~= $char;
        }
    }

    return $masked;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1.1,  ab-cde-123,   xx-xxe-123
        Example 1.2,  123.abc.420,  xxx.xbc.420
        Example 1.3,  3abc-0010.xy, xxxx-0010.xy
        Example 2.1,  1234567.a,    xxxx567.a
        Example 2.2,  a-1234-bc,    x-xxx4-bc
        Example 2.3,  a.b.c.d.e.f,  x.x.x.x.e.f
        Short string, pq-4,         xx-x
        x unchanged,  m-x:n87:0,    x-x:xx7:0
        END
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

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
