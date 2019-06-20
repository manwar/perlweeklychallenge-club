use v6;

################################################################################
=begin comment

Perl Weekly Challenge 012
=========================

Challenge #2
------------

Write a script that finds the common directory path, given a collection of paths
and directory separator. For example, if the following paths are supplied.

    /a/b/c/d
    /a/b/cd
    /a/b/cc
    /a/b/c/d/e

and the path separator is /. Your script should return /a/b as common directory
path.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
#
# Assumptions:
#
# 1. All directories exist within the same rooted tree
# 2. Only absolute paths should be considered; relative paths are discarded with
#    a warning message
# 3. Each input file consists of a list of paths, one path per line; blank lines
#    are ignored
#
#===============================================================================

my Str constant $SEPARATOR := '/';

sub MAIN(Str:D $file, Str:D :$sep = $SEPARATOR)
{
    my @paths = $file.IO.lines.grep(*.chars > 0);

    if @paths.elems > 0
    {
        say "\nSeparator: $sep";
        say "\nInput path", (@paths.elems == 1 ?? ':' !! 's:');
        say   "  $_" for @paths;

        my @dirs = parse-paths($sep, @paths);

        if @dirs.elems > 0
        {
            my Bool $single = @dirs.elems == 1;

            say "\nAbsolute path", $single ?? ':' !! 's:';
            say   '  ', $sep, $_.join($sep) for @dirs;

            say "\nCommon directory path:\n  ",
                $single ?? @paths[0] !! get-common-path($sep, @dirs);
        }
        else
        {
            say "\nNo absolute paths found";
        }
    }
    else
    {
        say "\nNo paths found";
    }
}

sub parse-paths(Str:D $sep, @paths)
{
    my (@dirs, @disc);

    for @paths -> Str $path
    {
        if $path.substr(0 .. 0) eq $sep               # Path is absolute
        {
            @dirs.push: $path.substr(1).split($sep);  # Remove initial separator
        }
        else                                          # Path is relative
        {
            @disc.push: $path;
        }
    }

    if @disc.elems > 0
    {
        say "\nDiscarded relative path", (@disc.elems == 1 ?? '' !! 's'), ':';
        say   "  $_" for @disc;
    }

    @dirs.perl;         # Force cache of @dirs contents

    return @dirs;
}

sub get-common-path(Str:D $sep, @dirs)
{
    my Str $common    = $sep;
    my Int $max-depth = @dirs.map(*.elems).min;

    BY-DEPTH:
    for 0 .. $max-depth -> Int $depth
    {
        my $dir = @dirs[0; $depth];

        for 1 .. @dirs.end -> Int $dir-idx
        {
            last BY-DEPTH if @dirs[$dir-idx; $depth] ne $dir;
        }

        $common ~= $dir ~ $sep;
    }

    $common ~~ s/ $sep $ // if $common ne $sep;      # Remove trailing separator

    return $common;
}

################################################################################
