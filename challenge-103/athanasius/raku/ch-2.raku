use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
1. Although it would be quite straightforward to hand-craft file-reading code
   for this particular exercise, as a general rule it is advisable to use a
   dedicated module for reading CSV files. The module chosen here is the
   excellent Text::CSV.
2. The easiest way to determine the file currently playing is to begin by
   calculating the total time elapsed modulo the total duration of the media
   files. Unlike Perl's built-in mod operator, Raku's "%" gives the desired
   result when the operands are real (i.e., floating point) numbers.
3. The user may find it convenient to let the script determine the current
   time, so an input value of zero for the current_time parameter is inter-
   preted as "now".

=end comment
#==============================================================================

use Text::CSV;

enum Data-Fields < Length Name Cum-length >;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 103, Task #2: What's playing? (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $start-time,                #= Start time in seconds since the epoch
    UInt:D $current-time               #= Current time in seconds (0 means now)
                 where { $_ == 0 || $_ >= $start-time },
    Str:D  $file where { $_ ~~ / \.csv $ / && .IO ~~ :r }       #= CSV filename
)
#==============================================================================
{
    my UInt $current = $current-time || now.floor;

    ("Input:\n\n    Start time:   $start-time\n" ~
               "    Current time: $current\n"    ~
               "    File list:    $file\n").put;

    my Array[Str] @data       = read-data( $file.IO );
    my Real       $total-s    = @data[ @data.end; Cum-length ].Int / 1e3;
    my UInt       $difference = $current - $start-time;
    my UInt       $offset     = floor( ($difference % $total-s) * 1e3 );
    my UInt       $index      = 0;

    for @data
    {
        last if $_[ Cum-length ] > $offset;
        ++$index;
    }

    $offset -= @data[ $index - 1; Cum-length ] if $index > 0;

    "Output:\n\n    %s\n    %s\n".printf:
        @data[ $index; Name ], hms( $offset );
}

#------------------------------------------------------------------------------
sub read-data( IO::Path:D $file --> Array:D[Array:D[Str:D]] )
#------------------------------------------------------------------------------
{
    my Text::CSV  $csv = Text::CSV.new;
    my IO::Handle $io  = $file.open: :r, chomp => True;
    my Array[Str] @data;

    for $csv.getline_all( $io )
    {
        my Str @entry = $_<>;
        @data.push: @entry;
    }

    my UInt $cum-total = 0;

    for @data
    {
        $cum-total += $_[ Length ];
        .push: $cum-total.Str;
    }

    return @data;
}

#------------------------------------------------------------------------------
sub hms( UInt:D $ms --> Str:D )
#------------------------------------------------------------------------------
{
    my UInt $seconds = floor( $ms      / 1000 );
    my UInt $minutes = floor( $seconds /   60 );
    my UInt $hours   = floor( $minutes /   60 );

    $minutes -= $hours   * 60;
    $seconds -= $minutes * 60;

    return '%02d:%02d:%02d'.sprintf: $hours, $minutes, $seconds;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
