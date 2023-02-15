use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 203
=========================

TASK #2
-------
*Copy Directory*

Submitted by: Julien Fiegehenn

You are given path to two folders, $source and $target.

Write a script that recursively copy the directory from $source to $target
except any files.

Example

  Input: $source = '/a/b/c' and $target = '/x/y'

  Source directory structure:

  ├── a
  │   └── b
  │       └── c
  │           ├── 1
  │           │   └── 1.txt
  │           ├── 2
  │           │   └── 2.txt
  │           ├── 3
  │           │   └── 3.txt
  │           ├── 4
  │           └── 5
  │               └── 5.txt

  Target directory structure:

  ├── x
  │   └── y

  Expected Result:

  ├── x
  │   └── y
  |       ├── 1
  │       ├── 2
  │       ├── 3
  │       ├── 4
  │       └── 5

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
The solution below copies (recursively) to the target both the structure of the
source directory and the individual directory permissions.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 203, Task #2: Copy Directory (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $source,                 #= Path to source directory
    Str:D $target                  #= Path to target directory
)
#==============================================================================
{
    $source.IO.d or error( qq["$source" is not a valid directory] );
    $target.IO.d or error( qq["$target" is not a valid directory] );

    "Input: \$source = '$source' and \$target = '$target'".put;

    my UInt $count = copy-dirs( $source, $target );

    "\n$count directories copied".put;
}

#------------------------------------------------------------------------------
sub copy-dirs( Str:D $source, Str:D $target --> UInt:D )    # Recursive routine
#------------------------------------------------------------------------------
{
    my UInt     $count = 0;
    my IO::Path @dirs  = $source.IO.dir.grep: { .d };

    for @dirs -> IO::Path $dir
    {
        my Str      $basename   = $dir.basename;
        my IO::Path $new-source = $source.IO.add: $basename;
        my IO::Path $new-target = $target.IO.add: $basename;

        $new-target.mkdir: $new-source.mode;

        CATCH
        {
            when X::IO::Mkdir
            {
                note qq[Directory "$new-target" not created];
            }
        }

        # If an exception was caught, this will not be executed:

        $count += 1 + copy-dirs( $new-source.Str, $new-target.Str );
    }

    return $count;
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
