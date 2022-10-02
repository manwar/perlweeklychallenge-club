#!perl

###############################################################################
=comment

Perl Weekly Challenge 184
=========================

TASK #1
-------
*Sequence Number*

Submitted by: Mohammad S Anwar

You are given list of strings in the format aa9999 i.e. first 2 characters can
be anything 'a-z' followed by 4 digits '0-9'.

Write a script to replace the first two characters with sequence starting with
'00', '01', '02' etc.

Example 1

  Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
  Output: ('001234', '015678', '021342')

Example 2

  Input: @list = ( 'pq1122', 'rs3334')
  Output: ('001122', '013334')

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
1. From the wording of the question combined with the two Examples, I assume
   that sequence numbers are to be assigned in the order in which strings
   appear in the input list, regardless of the contents of their 2-letter pre-
   fixes.
2. If more than 100 strings are given as input, the prefixes simply increment
   to 3 digits.

Interface
---------
If no arguments are given on the command line, the test suite is run.

Implementation
--------------
Uses Perl's built-in (postfix) ++ operator: "If ... the variable has been used
in only string contexts since it was set, and has a value that is not the empty
string and matches the pattern /^[a-zA-Z]*[0-9]*\z/, the increment is done as a
string, preserving each character within its range, with carry" [1].

References
----------
[1] https://perldoc.perl.org/perlop#Auto-increment-and-Auto-decrement

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    List of strings, format SSNNNN where S is a-z, N is 0-9\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 184, Task #1: Sequence Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @list = parse_command_line();

        printf "Input: \@list = ( %s )\n", format_list(          \@list   );
        printf "Output:        ( %s )\n",  format_list( replace(  @list ) );
    }
}

#------------------------------------------------------------------------------
sub replace
#------------------------------------------------------------------------------
{
    my @list   =  @_;
    my $prefix = '00';
    my @replaced;

    for my $string (@list)
    {
        push @replaced, $prefix++ . substr $string, 2, 4;
    }

    return \@replaced;
}

#------------------------------------------------------------------------------
sub format_list
#------------------------------------------------------------------------------
{
    my ($list) = @_;

    return join ', ', map { "'$_'" } @$list;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for my $item (@ARGV)
    {
        $item =~ / ^ [a-z]{2} [0-9]{4} $ /x
            or error( qq[Invalid string "$item"] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($name, $in, $exp)  = split / , \s* /x, $line, 3;
        my  $replaced = replace( split /   \s+ /x, $in );

        is join( ' ', @$replaced ), $exp, $name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,    ab1234 cd5678 ef1342, 001234 015678 021342
Example 2,    pq1122 rs3334,        001122 013334
Same nums,    zz9876 yy9876 xx9876, 009876 019876 029876
Same letters, aa2468 aa3579 aa1680, 002468 013579 021680
