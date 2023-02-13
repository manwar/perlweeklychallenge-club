#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
The solution below copies (recursively) to the target both the structure of the
source directory and the individual directory permissions.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use File::Spec::Functions qw( catdir no_upwards splitdir );

const my $USAGE =>
"Usage:
  perl $0 <source> <target>

    <source>    Path to source directory
    <target>    Path to target directory\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 203, Task #2: Copy Directory (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command-line arguments, found $args" );

    my ($source, $target) = @ARGV;
    -d  $source   or error( qq["$source" is not a valid directory] );
    -d  $target   or error( qq["$target" is not a valid directory] );

    print "Input: \$source = '$source' and \$target = '$target'\n";

    my $count = copy_dirs( $source, $target );

    print "\n$count directories copied\n";
}

#------------------------------------------------------------------------------
sub copy_dirs                                            # Recursive subroutine
#------------------------------------------------------------------------------
{
    my ($source, $target) = @_;
    my  $count = 0;

    opendir( my $dh, $source ) or die "Can't opendir $source: $!";

    my @dirs = grep { -d catdir( $source, $_ ) } readdir( $dh );
       @dirs = no_upwards( @dirs );

    closedir $dh               or die "Can't closedir $source: $!";

    for my $dir (@dirs)
    {
        my $basename   = (splitdir( $dir ))[ -1 ];
        my $new_source =  catdir( $source, $basename );
        my $new_target =  catdir( $target, $basename );
        my $mode       = (stat( $new_source ))[ 2 ] & 07777;

        if (mkdir $new_target, $mode)
        {
            $count += 1 + copy_dirs( $new_source, $new_target );
        }
        else
        {
            warn qq[Directory "$new_target" not created: $!];
        }
    }

    return $count;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
