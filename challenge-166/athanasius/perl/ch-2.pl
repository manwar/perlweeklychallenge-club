#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
This script receives the names of 3 or more actual directories as input, and
prepares the output table according to the files which those directories
contain. However, no attempt is made to verify that files sharing the same name
are in fact identical.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util qw( first );

const my $USAGE =>
"Usage:
  perl $0 [<dirs> ...]

    [<dirs> ...]    3 or more directory names\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 166, Task #2: K-Directory Diff (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @dirs      = parse_command_line();
    my $dir2files = map_dir_to_files( \@dirs );
    my %file2dirs;

    for my $dir (keys %$dir2files)
    {
        for my $file (@{ $dir2files->{ $dir } })
        {
            push @{ $file2dirs{ $file } }, $dir;
        }
    }

    my $dir_count = scalar @dirs;

    for my $filename (keys %file2dirs)
    {
        if (scalar @{ $file2dirs{ $filename } } == $dir_count)
        {
            delete $file2dirs{ $filename };
        }
    }

    display_table( \@dirs, \%file2dirs );
}

#------------------------------------------------------------------------------
sub map_dir_to_files
#------------------------------------------------------------------------------
{
    my ($dirs) = @_;
    my  %dir2files;

    for my $dir (@$dirs)
    {
        if (-d $dir)
        {
            opendir my $dh, $dir
                or die qq[Cannot opendir "$dir"\n];

            while (my $file = readdir $dh)
            {
                next if $file =~ / ^ \. /x;

                my $filename  = $file;
                   $filename .= '/' if -d "$dir/$file";

                push @{ $dir2files{ $dir } }, $filename;
            }

            closedir $dh
                or die qq[Cannot closedir "$dir"\n];
        }
        else
        {
            error( qq[Directory "$dir" not found] );
        }
    }

    return \%dir2files;
}

#------------------------------------------------------------------------------
sub display_table
#------------------------------------------------------------------------------
{
    my ($dirs, $file2dirs) = @_;

    my $dir2width = get_max_widths( $dirs, $file2dirs );

    display_header( $dirs, $dir2width );

    for my $file (sort keys %$file2dirs)
    {
        display_line( $file, $dirs, $file2dirs, $dir2width );
    }
}

#------------------------------------------------------------------------------
sub get_max_widths
#------------------------------------------------------------------------------
{
    my ($dirs, $file2dirs) = @_;

    my %dir2width = map { $_ => 0 } @$dirs;

    for my $filename (keys %$file2dirs)
    {
        for my $dir (@{ $file2dirs->{ $filename } })
        {
            if (length $filename > $dir2width{ $dir })
            {
                $dir2width{ $dir } = length $filename;
            }
        }
    }

    return \%dir2width;
}

#------------------------------------------------------------------------------
sub display_header
#------------------------------------------------------------------------------
{
    my ($dirs, $dir2width) = @_;

    my $dir0 = $dirs->[ 0 ];

    printf '  %-*s', $dir2width->{ $dir0 }, $dir0;

    for my $dir (@$dirs[ 1 .. $#$dirs ])
    {
        printf ' | %-*s', $dir2width->{ $dir }, $dir;
    }

    printf "\n  %s", '-' x $dir2width->{ $dir0 };

    for my $dir (@$dirs[ 1 .. $#$dirs ])
    {
        printf ' | %s', '-' x $dir2width->{ $dir };
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub display_line
#------------------------------------------------------------------------------
{
    my ($file, $dirs, $file2dirs, $dir2width) = @_;

    my $dir0 = $dirs->[ 0 ];

    if (first { $_ eq $dir0 } @{ $file2dirs->{ $file } })
    {
        printf '  %-*s', $dir2width->{ $dir0 }, $file;
    }
    else
    {
        printf '  %s', ' ' x $dir2width->{ $dir0 };
    }

    for my $dir (@$dirs[ 1 .. $#$dirs ])
    {
        print ' | ';
        
        if (first { $_ eq $dir } @{ $file2dirs->{ $file } })
        {
            printf '%-*s', $dir2width->{ $dir }, $file;
        }
        else
        {
            printf '%s', ' ' x $dir2width->{ $dir };
        }
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args >= 3
            or error( 'Expected at least 3 command line arguments, found ' .
                       $args );

    my %dirs;
     ++$dirs{ $_ } for @ARGV;

    my @dirs = sort keys %dirs;

    scalar @dirs >= 3
            or error( 'Input contains only ' . scalar( @dirs ) . ' distinct ' .
                      'directories, must have at least 3' );

    return @dirs;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
