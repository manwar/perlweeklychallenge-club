use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

=end comment
#==============================================================================

my constant @EXAMPLES = Array[Str].new: '/a/', '/a/b//c/', '/a/b/c/../..';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 112, Task #1: Canonical Path (Raku)\n".put;
}

#==============================================================================
multi sub MAIN()
#==============================================================================
{
    my Bool $first = True;

    for @EXAMPLES
    {
        ''.put unless $first;

        $first = False;

        canonical-path( $_ );
    }
}

#==============================================================================
multi sub MAIN
(
    Str:D $path where { / ^ <[ \\ / ]> / };  #= Absolute path beginning at root
)
#==============================================================================
{
    canonical-path( $path );
}

#------------------------------------------------------------------------------
sub canonical-path( Str:D $absolute-path )
#------------------------------------------------------------------------------
{
    qq[Input:  "$absolute-path"].put;

    my Str  $path = $absolute-path;
            $path ~~ s:g{ \\ } = '/';  # Convert backslashes to forward slashes
    my Bool $valid-path        = True;
    my Str  @canonical-dirs;

    # Note: The ":skip-empty" below removes all empty directories, and thereby
    #       reduces each sequence of consecutive slashes to a single slash

    for $path.split: '/', :skip-empty -> Str $dir
    {
        next if $dir eq '.';                        # Current directory: ignore

        if $dir eq '..'                             # Parent directory
        {
            if @canonical-dirs.elems == 0           # Impossible case
            {
                $valid-path = False;
                last;
            }
            else                                    # Go one directory "up"
            {
                @canonical-dirs.pop;
            }
        }
        else                                        # Go one directory "down"
        {
            @canonical-dirs.push: $dir;
        }
    }

    "Output: %s\n".printf:
        $valid-path ?? '"/' ~ @canonical-dirs.join( '/' ) ~ '"'
                    !! 'INVALID PATH: The root directory has no parent';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
