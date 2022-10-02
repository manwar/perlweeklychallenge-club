#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
From Example 2 it appears that empty arrays should be omitted from the output.

Implementation
--------------
For convenience, identification of valid digit and letter characters is imple-
mented using the CPAN module Set::Tiny.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Set::Tiny;

const my $VALID_DIGITS  => Set::Tiny->new( '0' .. '9' );
const my $VALID_LETTERS => Set::Tiny->new( 'a' .. 'z' );
const my $VALID_CHARS   => $VALID_DIGITS->union( $VALID_LETTERS );
const my $USAGE         =>
"Usage:
  perl $0 [<list> ...]

    [<list> ...]  List of strings: single chars (0-9, a-z), space-separated\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 184, Task #2: Split Array (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @strings = parse_command_line();

    printf "Input: \@list = ( %s )\n", join ', ', map { "'@$_'" } @strings;

    my (@digits, @letters);

    for my $chars (@strings)
    {
        my ($digits, $letters) = split_array( $chars );

        push @digits,  $digits  if @$digits;
        push @letters, $letters if @$letters;
    }

    printf "Output: [%s] and [%s]\n", fmt_int( \@digits  ),
                                      fmt_str( \@letters );
}

#------------------------------------------------------------------------------
sub split_array
#------------------------------------------------------------------------------
{
    my ($chars) = @_;
    my (@digits,  @letters);

    for my $char (@$chars)
    {
        if (defined $VALID_DIGITS->element( $char ))
        {
            push @digits,  $char;
        }
        else
        {
            push @letters, $char;
        }
    }

    return (\@digits, \@letters);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0 or error( 'No command-line arguments found' );

    my @strings;

    for my $string (@ARGV)
    {
        my @chars = split /\s+/, $string;

        for my $char (@chars)
        {
            defined $VALID_CHARS->element( $char )
                     or error( qq[Invalid string element "$char"] );
        }

        push @strings, [ @chars ];
    }

    return @strings;
}

#------------------------------------------------------------------------------
sub fmt_int
#------------------------------------------------------------------------------
{
    my ($list) = @_;

    return join ', ',
           map { '[' . join( ',',                @$_ ) . ']' } @$list;
}

#------------------------------------------------------------------------------
sub fmt_str
#------------------------------------------------------------------------------
{
    my ($list) = @_;

    return join ', ',
           map { '[' . join( ',', map { "'$_'" } @$_ ) . ']' } @$list;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
