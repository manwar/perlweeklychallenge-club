#!perl

###############################################################################
=comment

Perl Weekly Challenge 181
=========================

TASK #2
-------
*Hot Day*

Submitted by: Mohammad S Anwar

You are given file with daily temperature record in random order.

Write a script to find out days hotter than previous day.

Example

  Input File: (temperature.txt)

  2022-08-01, 20
  2022-08-09, 10
  2022-08-03, 19
  2022-08-06, 24
  2022-08-05, 22
  2022-08-10, 28
  2022-08-07, 20
  2022-08-04, 18
  2022-08-08, 21
  2022-08-02, 25

  Output:
  2022-08-02
  2022-08-05
  2022-08-06
  2022-08-08
  2022-08-10

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
Although, in the example data, the dates (when ordered) form a contiguous
series, the Task description does not require this. I assume that a date whose
previous day is omitted from the data file cannot satisfy the condition that it
be "hotter than [the] previous day". For this reason, the CPAN module DateTime
is used to determine whether a given date has an immediate predecessor in the
given data. This is easier, and less error-prone, than attempting a manual
solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;

const my $USAGE =>
"Usage:
  perl $0 <file>

    <file>    File with daily temperature records\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 181, Task #2: Hot Day (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($file, $lines) = read_file();

    printf "Input file ($file):\n%s\n\n", join "\n", @$lines;

    my $temp_hash    = read_temperatures( $lines );
    my @date_strings = sort keys %$temp_hash;
    my $date_objects = make_date_objects( \@date_strings );
    my @hotter;

    for my $i (1 .. $#date_strings)
    {
        my $previous = $date_objects->[ $i ]->clone->subtract( days => 1 );

        push @hotter, $date_strings[ $i ]
            if DateTime->compare( $previous, $date_objects->[ $i - 1 ] ) == 0
               && $temp_hash->{ $date_strings[ $i     ] } >
                  $temp_hash->{ $date_strings[ $i - 1 ] };
    }

    printf "Output:\n%s\n", join "\n", @hotter;
}

#------------------------------------------------------------------------------
sub read_temperatures
#------------------------------------------------------------------------------
{
    my ($lines) = @_;
    my  %temp;

    for my $line (@$lines)
    {
        my ($date, $temp) =
            $line =~ / \s* (\d{4} - \d{2} - \d{2}) , \s+ (\d+) \s* /x;

        $temp{ $date } = $temp;
    }

    return \%temp;
}

#------------------------------------------------------------------------------
sub make_date_objects
#------------------------------------------------------------------------------
{
    my ($date_strings) = @_;
    my  @date_objects;

    for my $date_string (@$date_strings)
    {
        my ($year, $month, $day) =
            $date_string =~ / (\d{4}) - (\d{2}) - (\d{2}) /x;

        push @date_objects,
             DateTime->new( year => $year, month => $month, day => $day );
    }

    return \@date_objects;
}

#------------------------------------------------------------------------------
sub read_file
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Found $args command line arguments, expected 1" );

    my $file = $ARGV[ 0 ];
    -e $file      or error( qq[File "$file" not found] );

    open my $fh, '<', $file
                  or error( qq[Can't open file "$file" for reading] );

    my @lines;

    while (my $line = <$fh>)
    {
        chomp $line;
        push  @lines, $line;
    }

    close $fh     or error( qq[Can't close file "$file"] );

    return ($file, \@lines);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
