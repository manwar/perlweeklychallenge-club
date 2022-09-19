use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 172
=========================

TASK #2
-------
*Five-number Summary*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to compute the five-number summary of the given set of integers.

You can find the definition and example in the
[ https://en.wikipedia.org/wiki/Five-number_summary |wikipedia page].

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Median
------
For n data samples arranged in ascending numerical order:
- if n is odd,  then the median is sample number (n+1)/2.
- if n is even, then the median is the average of sample number n/2 and sample
  number (n/2)+1. [2]

Quartiles
---------
"For discrete distributions, there is no universal agreement on selecting the
quartile values." [3] The approach adopted here is as follows:

  "The lower quartile value is the median of the lower half of the data.
   The upper quartile value is the median of the upper half of the data." [3]

This leaves open the question of whether the median should be included in each
of the lower and upper halves. Set the constant $INCLUDE-MEDIAN as desired.

References
----------
[1] "Five-number summary",
                Wikipedia, https://en.wikipedia.org/wiki/Five-number_summary
[2] "Median",   Wikipedia, https://en.wikipedia.org/wiki/Median
[3] "Quartile", Wikipedia, https://en.wikipedia.org/wiki/Quartile

=end comment
#==============================================================================

my Bool constant $INCLUDE-MEDIAN = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 172, Task #2: Five-number Summary (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #= A non-empty array of integers

    *@samples where { +@samples > 0 && .all ~~ Int:D }
)
#==============================================================================
{
    my Int   @ordered        = @samples.sort;
    my Real ($lower, $upper) = $INCLUDE-MEDIAN                      ?? 
                               quartiles-include-median( @ordered ) !!
                               quartiles-exclude-median( @ordered );

    ("Input: %s\n\n"          ~
     "Five-number Summary\n"  ~
     "-------------------\n"  ~
     "Sample minimum: %d\n"   ~
     "Lower quartile: %.2f\n" ~
     "Median:         %.1f\n" ~
     "Upper quartile: %.2f\n" ~
     "Sample maximum: %d\n").printf:
      @samples.join( ', ' ),
      @ordered[ 0 ],
      $lower,
      median( @ordered ),
      $upper,
      @ordered[ *-1 ];
}

#------------------------------------------------------------------------------
sub median( *@samples where { +@samples > 0 && .all ~~ Int:D } --> Real:D )
#------------------------------------------------------------------------------
{
    my UInt $sample-size = +@samples;
    my Real $median;

    if $sample-size %% 2        # Even
    {
        my Int $mid    = ($sample-size / 2).Int - 1;
        my Int $lower  =  @samples[ $mid     ];
        my Int $higher =  @samples[ $mid + 1 ];

        $median = ($lower + $higher) / 2;
    }
    else                        # Odd
    {
        $median = @samples[ (($sample-size + 1) / 2).Int - 1 ];
    }

    return $median;
}

#------------------------------------------------------------------------------
sub quartiles-exclude-median                              # "Method 1" from [3]
(
    @samples where { +@samples > 0 && .all ~~ Int:D }
--> List:D[Real:D]
)
#------------------------------------------------------------------------------
{
    my UInt  $sample-size = +@samples;
    my Real ($lower-end, $upper-start);

    if $sample-size %% 2        # Even
    {
        my Real $mid-point   =  $sample-size / 2;
                $lower-end   =  $mid-point   - 1;
                $upper-start =  $mid-point;
    }
    else                        # Odd
    {
        my Real $mid-point   = ($sample-size - 1) / 2;
                $lower-end   =  $mid-point - 1;
                $upper-start =  $mid-point + 1;
    }

    my Int @lower-range = @samples[ 0            .. $lower-end   ];
    my Int @upper-range = @samples[ $upper-start .. @samples.end ];

    return median( @lower-range ), median( @upper-range );
}

#------------------------------------------------------------------------------
sub quartiles-include-median       # "Method 2" from [3] (aka "Tukey's hinges")
(
    @samples where { +@samples > 0 && .all ~~ Int:D }
--> List:D[Real:D]
)
#------------------------------------------------------------------------------
{
    my UInt  $sample-size = +@samples;
    my Real ($lower-end, $upper-start);

    if $sample-size %% 2        # Even
    {
        my Real $mid-point   =  $sample-size / 2;
                $lower-end   =  $mid-point   - 1;
                $upper-start =  $mid-point;
    }
    else                        # Odd
    {
        my Real $mid-point   = ($sample-size - 1) / 2;
                $lower-end   =  $mid-point;
                $upper-start =  $mid-point;
    }

    my Int @lower-range = @samples[ 0            .. $lower-end   ];
    my Int @upper-range = @samples[ $upper-start .. @samples.end ];

    return median( @lower-range ), median( @upper-range );
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
