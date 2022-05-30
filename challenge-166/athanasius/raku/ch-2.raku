use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 166
=========================

TASK #2
-------
*K-Directory Diff*

Submitted by: Ryan J Thompson

Given a few (three or more) directories (non-recursively), display a side-by-
side difference of files that are missing from at least one of the directories.
Do not display files that exist in every directory.

Since the task is non-recursive, if you encounter a subdirectory, append a /,
but otherwise treat it the same as a regular file.

Example

Given the following directory structure:

  dir_a:
  Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  Impact.otf
  Verdana.ttf  Old_Fonts/

  dir_b:
  Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf
  Tahoma.ttf  Verdana.ttf

  dir_c:
  Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Monaco.ttf
  Verdana.ttf

The output should look similar to the following:

  dir_a          | dir_b           | dir_c
  -------------- | --------------- | ---------------
  Comic_Sans.ttf | Comic_Sans.ttf  |
                 | Courier_New.ttf | Courier_New.ttf
  Georgia.ttf    |                 |
                 |                 | Monaco.ttf
  Old_Fonts/     |                 |
                 | Tahoma.ttf      |

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
This script receives the names of 3 or more actual directories as input, and
prepares the output table according to the files which those directories
contain. However, no attempt is made to verify that files sharing the same name
are in fact identical.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 166, Task #2: K-Directory Diff (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@dirs where { .all ~~ Str:D && +@dirs >= 3 }  #= 3 or more directory names
)
#==============================================================================
{
    my Set[Str] $dirs-set = Set[Str].new: |@dirs;
    my Str      @dirs-srt = $dirs-set.keys.sort;

    +@dirs-srt >= 3
        or error( "Input contains only { +@dirs-srt } distinct directories, " ~
                  "must have at least 3" );

    my Array[Str] %dir2files = map-dir-to-files( @dirs-srt );
    my Array[Str] %file2dirs;

    for %dir2files.keys -> Str $dir
    {
        for %dir2files{ $dir }.list -> Str $file
        {
            %file2dirs{ $file }.push: $dir;
        }
    }

    my UInt $dir-count = +@dirs-srt;

    for %file2dirs.keys -> Str $filename
    {
        if  %file2dirs{ $filename }.list.elems == $dir-count
        {
            %file2dirs{ $filename }:delete;
        }
    }

    display-table( @dirs-srt, %file2dirs );
}

#------------------------------------------------------------------------------
sub map-dir-to-files
(
    Array:D[Str:D] $dirs
--> Hash:D[Array:D[Str:D]]
)
#------------------------------------------------------------------------------
{
    my Array[Str] %dir2files;

    for @$dirs -> Str $dir
    {
        if $dir.IO.d
        {
            for $dir.IO.dir -> IO::Path $file
            {
                my Str $filename = $file.basename;

                $filename ~= '/' if $file.d;

                %dir2files{ $dir }.push: $filename;
            }
        }
        else
        {
            error( qq[Directory "$dir" not found] );
        }
    }

    return %dir2files;
}

#------------------------------------------------------------------------------
sub display-table
(
    Array:D[Str:D]         $dirs,
    Hash:D[Array:D[Str:D]] $file2dirs
)
#------------------------------------------------------------------------------
{
    my UInt %dir2width = get-max-widths( $dirs, $file2dirs );

    display-header( $dirs, %dir2width );

    for $file2dirs.keys.sort -> Str $file
    {
        display-line( $file, $dirs, $file2dirs, %dir2width );
    }
}

#------------------------------------------------------------------------------
sub get-max-widths
(
    Array:D[Str:D]         $dirs,
    Hash:D[Array:D[Str:D]] $file2dirs
--> Hash:D[UInt:D]
)
#------------------------------------------------------------------------------
{
    my UInt %dir2width = $dirs.map: { $_ => 0 };

    for $file2dirs.keys -> Str $filename
    {
        for $file2dirs{ $filename }.list -> Str $dir
        {
            if $filename.chars > %dir2width{ $dir }
            {
                %dir2width{ $dir } = $filename.chars;
            }
        }
    }

    return %dir2width;
}

#------------------------------------------------------------------------------
sub display-header
(
    Array:D[Str:D] $dirs,
    Hash:D[UInt:D] $dir2width
)
#------------------------------------------------------------------------------
{
    my Str $dir0 = $dirs[ 0 ];

    '  %-*s'.printf: $dir2width{ $dir0 }, $dir0;

    for $dirs[ 1 .. * ] -> Str $dir
    {
        ' | %-*s'.printf: $dir2width{ $dir }, $dir;
    }

    "\n  %s".printf: '-' x $dir2width{ $dir0 };

    for $dirs[ 1 .. * ] -> Str $dir
    {
        ' | %s'.printf: '-' x $dir2width{ $dir };
    }

    put();
}

#------------------------------------------------------------------------------
sub display-line
(
    Str:D                  $file,
    Array:D[Str:D]         $dirs,
    Hash:D[Array:D[Str:D]] $file2dirs,
    Hash:D[UInt:D]         $dir2width
)
#------------------------------------------------------------------------------
{
    my Str $dir0 = $dirs[ 0 ];

    if $file2dirs{ $file }.first: $dir0
    {
        '  %-*s'.printf: $dir2width{ $dir0 }, $file;
    }
    else
    {
        '  %s'.printf: ' ' x $dir2width{ $dir0 };
    }

    for $dirs[ 1 .. * ] -> Str $dir
    {
        if $file2dirs{ $file }.first: $dir
        {
            ' | %-*s'.printf: $dir2width{ $dir }, $file;
        }
        else
        {
            ' | %s'.printf: ' ' x $dir2width{ $dir };
        }
    }

    put();
}

#------------------------------------------------------------------------------
sub error
(
    Str:D $message
)
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
