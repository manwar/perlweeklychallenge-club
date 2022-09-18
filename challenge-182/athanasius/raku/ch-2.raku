use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 182
=========================

TASK #2
-------
*Common Path*

Submitted by: Julien Fiegehenn

Given a list of absolute Linux file paths, determine the deepest path to the
directory that contains all of them.

Example

  Input:
      /a/b/c/1/x.pl
      /a/b/c/d/e/2/x.pl
      /a/b/c/d/3/x.pl
      /a/b/c/4/x.pl
      /a/b/c/d/5/x.pl

  Output:
      /a/b/c

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. A path consists of directories only.
2. The final entry in the path is a directory if and only if it is followed by
   a path separator.

Interface
---------
The input list of absolute Linux file paths may be either entered directly on
the command line or contained in a text file whose name is given on the command
line via the --file flag. If no command line arguments are given, input data is
read from the default file "paths.txt", which contains the data in the Example.

Configuration
-------------
The Example gives "/a/b/c" as the required output, with no separator appended
to the final directory. This behaviour is enabled by setting the $SHOW-FINAL
constant to False.

However, if the only common directory happens to be root, the output will then
be an empty string, which is misleading. To append the file path separator to
the final directory, set $SHOW-FINAL to True. This will produce the output
"/a/b/c/" for the Example, and "/" when the only common directory is root.

=end comment
#==============================================================================

my Str  constant $DEFAULT-FILE = 'paths.txt';
my Str  constant $SEPARATOR    = '/';
my Bool constant $SHOW-FINAL   = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 182, Task #2: Common Path (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    *@paths where { .elems > 0 }         #= A list of absolute Linux file paths
)
#==============================================================================
{
    main( 'command line', @paths );
}

#==============================================================================
multi sub MAIN
(
    Str:D :$file where *.IO.f = $DEFAULT-FILE             #= Name of input file
)
#==============================================================================
{
    my Str @paths = $file.IO.lines;

    @paths > 0 or error( 'No paths found' );

    main( qq[file "$file"], @paths );
}

#------------------------------------------------------------------------------
sub main( Str:D $input, Array:D[Str:D] $str-paths )
#------------------------------------------------------------------------------
{
    "Input (%s):\n    %s\n\n".printf: $input, $str-paths.join: "\n    ";

    my Array[Str] @dir-paths   = parse-string-paths( $str-paths );
    my Str        $common-path = find-deepest-path\( @dir-paths );

    "Output:\n    $common-path".put;
}

#------------------------------------------------------------------------------
sub parse-string-paths( Array:D[Str:D] $str-paths --> Array:D[Array:D[Str:D]] )
#------------------------------------------------------------------------------
{
    my Array[Str] @dir-paths;

    for @$str-paths -> Str $path
    {
        my Str @dirs = $path.split: $SEPARATOR;

        @dirs[ 0 ] eq '' or error( qq[Path "$path" does not begin at root] );
        @dirs.shift;
        @dirs.pop;                  # Remove either filename or
                                    # the empty string that follows a directory
        @dir-paths.push: @dirs;
    }

    return @dir-paths;
}

#------------------------------------------------------------------------------
sub find-deepest-path( Array:D[Array:D[Str:D]] $dir-paths --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $common-path = $SEPARATOR;

    while @$dir-paths.all.elems > 0
    {
        my Str @dirs = @$dir-paths.map: { .shift };

        if @dirs.all eq @dirs[ 0 ]
        {
            $common-path ~= @dirs[ 0 ] ~ $SEPARATOR;
        }
        else
        {
            last;
        }
    }

    $common-path .= chop: $SEPARATOR.chars unless $SHOW-FINAL;

    return $common-path;
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
