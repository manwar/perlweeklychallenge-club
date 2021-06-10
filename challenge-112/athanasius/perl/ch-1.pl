#!perl

###############################################################################
=comment

Perl Weekly Challenge 112
=========================

TASK #1
-------
*Canonical Path*

Submitted by: Mohammad S Anwar

You are given a string path, starting with a slash '/'.

Write a script to convert the given absolute path to the simplified canonical
path.

In a Unix-style file system:

 - A period '.' refers to the current directory
 - A double period '..' refers to the directory up a level
 - Multiple consecutive slashes ('//') are treated as a single slash '/'

The canonical path format:

 - The path starts with a single slash '/'.
 - Any two directories are separated by a single slash '/'.
 - The path does not end with a trailing '/'.
 - The path only contains the directories on the path from the root directory
   to the target file or directory

Example

 Input: "/a/"
 Output: "/a"

 Input: "/a/b//c/"
 Output: "/a/b/c"

 Input: "/a/b/c/../.."
 Output: "/a"

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The script may be invoked with either one argument (a single rooted path), or
with no arguments. In the latter case, the 3 paths given in the Example are
used as input.

Note that Windows-style backslashes are also supported as path separators.

Algorithm
---------
Directories (and the final file, if any) are stored sequentially in an array,
with 2 exceptions:

    (1) .  (the current directory) is ignored;
    (2) .. (the parent  directory) is "stored" by removing the most-recently
            added directory from the array.

When all directory and file entries have been processed, the canonical path is
re-constructed from whatever entries remain in the array.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my @EXAMPLES => ('/a/', '/a/b//c/', '/a/b/c/../..');
const my $USAGE    =>
"Usage:
  perl $0
  perl $0 <path>

    <path>    Absolute path beginning at root\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 112, Task #1: Canonical Path (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if ((my $path = parse_command_line()) eq 'EXAMPLES')
    {
        my $first = 1;

        for (@EXAMPLES)
        {
            print "\n" unless $first;

            $first = 0;

            canonical_path( $_ );
        }
    }
    else
    {
        canonical_path( $path );
    }
}

#------------------------------------------------------------------------------
sub canonical_path
#------------------------------------------------------------------------------
{
    my ($path) = @_;

    print qq[Input:  "$path"\n];

    $path =~ s{ \\ }{/}gx;         # Convert all backslashes to forward slashes

    my $valid_path = 1;
    my @canonical_dirs;

    # Note: The grep below removes all empty directories, and thereby reduces
    #       each sequence of consecutive slashes in the path to a single slash

    for my $dir (grep { /./ } split '/', $path)
    {
        next if $dir eq '.';                        # Current directory: ignore

        if ($dir eq '..')                           # Parent directory
        {
            if (scalar @canonical_dirs == 0)        # Impossible case
            {
                $valid_path = 0;
                last;
            }
            else                                    # Go one directory "up"
            {
                pop @canonical_dirs;
            }
        }
        else                                        # Go one directory "down"
        {
            push @canonical_dirs, $dir;
        }
    }

    printf "Output: %s\n",
        $valid_path ? '"/' . join('/', @canonical_dirs) . '"'
                    : 'INVALID PATH: The root directory has no parent';
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
    my $path;

    if    ($args == 0)
    {
        $path = 'EXAMPLES';
    }
    elsif ($args == 1)
    {
        $path = $ARGV[ 0 ];

        unless ($path =~ / ^ [\/\\] /x)
        {
            error( qq[Invalid input path "$path": paths must begin at root] );
        }
    }
    else
    {
        error( "Expected 0 or 1 command line arguments, found $args" );
    }

    return $path;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
