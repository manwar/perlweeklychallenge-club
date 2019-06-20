#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 Perlmonk Athanasius #
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

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $SEPARATOR => '/';
const my $USAGE     => "\nUSAGE: perl $0  --help\n" .
                         "or     perl $0 [--sep <separator>] <filename>\n";

$| = 1;

MAIN:
{
    my ($help, $sep, $paths) = read_paths();

    if ($help)
    {
        print $USAGE;
    }
    elsif (my $num_paths = scalar @$paths)
    {
        print  "\nSeparator: $sep\n";
        printf "\nInput path%s:\n", ($num_paths == 1) ? '' : 's';
        print    "  $_\n" for @$paths;

        my $dirs = parse_paths($sep, $paths);

        if (my $num_dirs = scalar @$dirs)
        {
            printf "\nAbsolute path%s:\n", ($num_dirs == 1) ? '' : 's';
            printf   "  %s%s\n", $sep, join($sep, @$_) for @$dirs;

            printf "\nCommon directory path:\n  %s\n",
                   ($num_dirs == 1) ? $paths->[0] :
                                      get_common_path($sep, $dirs);
        }
        else
        {
            print "\nNo absolute paths found\n";
        }
    }
    else
    {
        print "\nNo paths found\n";
    }
}

sub read_paths
{
    my $help = '';
    my $sep  = $SEPARATOR;

    GetOptions
    (
        'help'   => \$help,     # Show usage?: flag
        'sep:s'  => \$sep,      # Separator:   optional string

    ) or die $USAGE;

    my @paths;

    unless ($help)
    {
        my $file = $ARGV[0]
            or die $USAGE;

        open(my $fh, '<', $file)
            or die "Cannot open file '$file' for reading, stopped";

        while (my $line = <$fh>)
        {
            chomp $line;
            push  @paths, $line if $line;
        }

        close $fh
            or die "Cannot close file '$file', stopped";
    }

    return ($help, $sep, \@paths);
}

sub parse_paths
{
    my ($sep,  $paths) = @_;
    my (@dirs, @disc);

    for my $path (@$paths)
    {
        # Look for an absolute path

        my ($init, $rest) = $path =~ / ^ (\Q$sep\E) (.*) $ /x;

        if (defined $init)          # Path is absolute
        {
            # Remove the initial separator

            push @dirs, [ split m{ \Q$sep\E }x, $rest ];
        }
        else                        # Path is relative
        {
            push @disc, $path;
        }
    }

    if (my $discards = scalar @disc)
    {
        printf "\nDiscarded relative path%s:\n", ($discards == 1) ? '' : 's';
        print    "  $_\n" for @disc;
    }

    return \@dirs;
}

sub get_common_path
{
    my ($sep, $dirs) = @_;
    my  $common      = $sep;
    my  $max_depth   = get_max_common_dir_index($dirs);

    OUTER:
    for my $depth (0 .. $max_depth)
    {
        my $dir = $dirs->[0][$depth];

        for my $dir_idx (1 .. $#$dirs)
        {
            last OUTER if $dirs->[$dir_idx][$depth] ne $dir;
        }

        $common .= $dir . $sep;
    }

    # Remove trailing separator

    $common =~ s{ \Q$sep\E $ }{}x if $common ne $sep;

    return $common;
}

sub get_max_common_dir_index
{
    my ($dirs) = @_;
    my  $index = scalar( $dirs->[0]->@* ) - 1;

    for my $path ( @{ $dirs }[1 .. $#$dirs] )
    {
        $index = $#$path if $#$path < $index;
    }

    return $index;
}

################################################################################
