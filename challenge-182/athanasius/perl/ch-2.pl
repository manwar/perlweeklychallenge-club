#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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
to the final directory. This behaviour is enabled by setting the $SHOW_FINAL
constant to a false value.

However, if the only common directory happens to be root, the output will then
be an empty string, which is misleading. To append the file path separator to
the final directory, set $SHOW_FINAL to a true value. This will produce the
output "/a/b/c/" for the Example, and "/" when the only common directory is
root.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util qw( all );

const my $DEFAULT_FILE => 'paths.txt';
const my $SEPARATOR    => '/';
const my $SHOW_FINAL   => 1;
const my $USAGE        =>
"Usage:
  perl $0 [<paths> ...]
  perl $0 [--file <Str>]

    [<paths> ...]    A list of absolute Linux file paths
    --file <Str>     Name of input file [default: '$DEFAULT_FILE']\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 182, Task #2: Common Path (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($input, $str_paths) = parse_command_line();

    printf "Input (%s):\n    %s\n\n", $input, join "\n    ", @$str_paths;

    my $dir_paths   = parse_string_paths( $str_paths );
    my $common_path = find_deepest_path ( $dir_paths );

    print  "Output:\n    $common_path\n";
}

#------------------------------------------------------------------------------
sub find_deepest_path
#------------------------------------------------------------------------------
{
    my ($dir_paths)  = @_;
    my  $common_path = $SEPARATOR;

    while (all { scalar @$_ > 0 } @$dir_paths)
    {
        my @dirs = map { shift @$_ } @$dir_paths;

        if (all { $_ eq $dirs[ 0 ] } @dirs)
        {
            $common_path .= $dirs[ 0 ] . $SEPARATOR;
        }
        else
        {
            last;
        }
    }

    unless ($SHOW_FINAL)
    {
        chop $common_path for 1 .. length $SEPARATOR;
    }

    return $common_path;
}

#------------------------------------------------------------------------------
sub parse_string_paths
#------------------------------------------------------------------------------
{
    my ($str_paths) = @_;
    my  @dir_paths;

    for my $path (@$str_paths)
    {
        # "If LIMIT is negative, it is treated as if it were instead arbitrari-
        #  ly large; as many fields as possible are produced."
        #  -- https://perldoc.perl.org/functions/split

        my @dirs = split $SEPARATOR, $path, -1;

        $dirs[ 0 ] eq '' or error( qq[Path "$path" does not begin at root] );
        shift @dirs;
        pop   @dirs;                # Remove either filename or
                                    # the empty string that follows a directory
        push  @dir_paths, [ @dirs ];
    }

    return \@dir_paths;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $file;

    GetOptions( 'file=s' => \$file )
                   or error( 'Invalid command line flag(s)' );

    my  $args = scalar @ARGV;
    my ($input, @paths);

    if    (defined $file)
    {
        $args == 0 or error( 'Extra command line arguments found' );

        $input =   qq[file "$file"];
        @paths = read_file( $file );
    }
    elsif ($args == 0)
    {
        $input =   qq[file "$DEFAULT_FILE"];
        @paths = read_file( $DEFAULT_FILE );
    }
    else
    {
        $input = 'command line';
        @paths =  @ARGV;
    }

    return ($input, \@paths);
}

#------------------------------------------------------------------------------
sub read_file
#------------------------------------------------------------------------------
{
    my ($filename) = @_;

    open my $fh, '<', $filename
              or error( qq[Can't open file "$filename" for reading] );

    my @lines;

    while (my $line = <$fh>)
    {
        chomp $line;
        push  @lines, $line;
    }

    close $fh or die qq[Can't close file "$filename"];

    return @lines;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
