#!perl

###############################################################################
=comment

Perl Weekly Challenge 103
=========================

Task #2
-------
*What's playing?*

Submitted by: Albert Croft

Working from home, you decided that on occasion you wanted some background
noise while working. You threw together a network streamer to continuously loop
through the files and launched it in a tmux (or screen) session, giving it a
directory tree of files to play. During the day, you connected an audio player
to the stream, listening through the workday, closing it when done.

For weeks you connect to the stream daily, slowly noticing a gradual drift of
the media. After several weeks, you take vacation. When you return, you are
pleasantly surprised to find the streamer still running. Before connecting,
however, if you consider the puzzle of determining which track is playing.

After looking at a few modules to read info regarding the media, a quick bit of
coding gave you a file list. The file list is in a simple CSV format, each line
containing two fields: the first the number of milliseconds in length, the
latter the media's title (this example is of several episodes available from
the MercuryTheatre.info):

 1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
 1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
 1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
 1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
 1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
 1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
 1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"

For this script, you can assume to be provided the following information:

    * the value of $^T ($BASETIME) of the streamer script,
    * the value of time(), and
    * a CSV file containing the media to play consisting of the length in
      milliseconds and an identifier for the media (title, filename, or other).

Write a program to output which file is currently playing. For purposes of this
script, you may assume gapless playback, and format the output as you see fit.

Optional: Also display the current position in the media as a time-like value.

Example:

UPDATED: Input parameters as reported by many members [2021-03-08 16:20 UK
TIME].

 Input: 3 command line parameters: start time, current time, file name

     # starttime
     1606134123

     # currenttime
     1614591276

     # filelist.csv

 Output:

     "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
     00:10:24

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes
-----
1. Although it would be quite straightforward to hand-craft file-reading code
   for this particular exercise, as a general rule it is advisable to use a
   dedicated module for reading CSV files. The module chosen here is the
   excellent Text::CSV (which automatically uses Text::CSV_XS if the latter is
   available).
2. The easiest way to determine the file currently playing is to begin by
   calculating the total time elapsed modulo the total duration of the media
   files. Perl's built-in mod operator "%" does not give the desired result
   when the operands are real (i.e., floating point) numbers, so the subroutine
   POSIX::fmod() is used for this purpose.
3. The user may find it convenient to let the script determine the current
   time, so an input value of zero for the current_time parameter is inter-
   preted as "now".

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use POSIX          qw( fmod );
use Regexp::Common qw( number );
use Text::CSV;

use enum qw( Length Name Cum_length );

const my $USAGE =>
"Usage:
  perl $0 <start_time> <current_time> <file>

    <start_time>      Start time in seconds since the epoch
    <current_time>    Current time in seconds (0 means now)
    <file>            CSV filename\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 103, Task #2: What's playing? (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($start_time, $current_time, $file) = parse_command_line();

    my  $current = $current_time || time;

    print "Input:\n\n    Start time:   $start_time\n" .
                    "    Current time: $current\n"    .
                    "    File list:    $file\n\n";

    my $data       = read_data( $file );
    my $total_s    = int( $data->[ $#$data ][ Cum_length ] ) / 1e3;
    my $difference = $current - $start_time;
    my $offset     = int( fmod($difference, $total_s) * 1e3 );
    my $index      = 0;

    for (@$data)
    {
        last if $_->[ Cum_length ] > $offset;
        ++$index;
    }

    $offset -= $data->[ $index - 1 ][ Cum_length ] if $index > 0;

    printf "Output:\n\n    %s\n    %s\n",
        $data->[ $index ][ Name ], hms( $offset );
}

#------------------------------------------------------------------------------
sub read_data
#------------------------------------------------------------------------------
{
    my ($file) = @_;

    open( my $fh, '<', $file )
              or error( qq[Cannot open file "$file" for reading] );

    my $csv  = Text::CSV->new;
    my $data = $csv->getline_all( $fh );

    close $fh or error( qq[Cannot close file "$file"] );

    my $cum_total = 0;

    for my $i (0 .. $#$data)
    {
        $cum_total += $data->[ $i ][ Length ];

        push @{ $data->[ $i ] }, $cum_total;
    }

    return $data;
}

#------------------------------------------------------------------------------
sub hms
#------------------------------------------------------------------------------
{
    my ($ms)     = @_;
    my  $seconds = int( $ms      / 1e3 );
    my  $minutes = int( $seconds /  60 );
    my  $hours   = int( $minutes /  60 );

    $minutes -= $hours   * 60;
    $seconds -= $minutes * 60;

    return sprintf '%02d:%02d:%02d', $hours, $minutes, $seconds;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args =  scalar @ARGV;
       $args == 3
              or error( "Expected 3 command-line arguments, found $args" );

    my ($start_time, $current_time, $file) = @ARGV;

    for ($start_time, $current_time)
    {
        / ^ $RE{num}{int} $ /x && $_ >= 0
              or error( qq["$_" is not a positive integer] );
    }

    if ($current_time > 0)
    {
        $current_time >= $start_time
              or error( 'Current time is earlier than start time' );
    }

    $file =~ / \. csv $ /ix
              or error( qq[File "$file" does not have a ".csv" extension] );

    open( my $fh, '<', $file )
              or error( qq[Cannot open file "$file" for reading] );

    close $fh or die qq[Cannot close file "$file", stopped];

    return ($start_time, $current_time, $file);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
