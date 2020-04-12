use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 055
=========================

Task #1
*Flip Binary*

You are given a binary number *B*, consisting of *N* binary digits *0* or *1*:
*s0, s1, …, s(N-1)*.

Choose two indices *L* and *R* such that *0 ≤ L ≤ R < N* and flip the digits
*s(L), s(L+1), …, s(R)*. By flipping, we mean change *0* to *1* and vice-versa.

For example, given the binary number 010, the possible flip pair results are
listed below:

  ▪ L=0, R=0 the result binary: 110
  ▪ L=0, R=1 the result binary: 100
  ▪ L=0, R=2 the result binary: 101
  ▪ L=1, R=1 the result binary: 000
  ▪ L=1, R=2 the result binary: 001
  ▪ L=2, R=2 the result binary: 011

Write a script to find the indices (*L,R*) that results in a binary number with
maximum number of *1*s. If you find more than one maximal pair *L,R* then print
all of them.

Continuing our example, note that we had three pairs *(L=0, R=0)*, *(L=0, R=2)*,
and *(L=2, R=2)* that resulted in a binary number with two *1*s, which was the
maximum. So we would print all three pairs.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Str constant USAGE =
               "USAGE: raku $*PROGRAM-NAME <B> - where B is a binary number\n";

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN(Str:D $B)                                       #= B is a binary number
#===============================================================================
{
    "Challenge 055, Task #1: Flip Binary (Raku)\n".put;

    my @binary = $B.split: '', :skip-empty;

    $_ eq '0' || $_ eq '1'
        or die "ERROR: Found \"$_\", expected \"0\" or \"1\"\n" ~ USAGE
            for @binary;

    my ($max, @indices) = solve( @binary );

    ("The maximum number of 1s obtained by flipping \"%s\" is %d,\nobtained " ~
        "with the flip indices: %s\n").printf: $B, $max, @indices[0].join: ', ';
}

#-------------------------------------------------------------------------------
sub solve(@binary)
#-------------------------------------------------------------------------------
{
    my UInt $max-i = @binary.elems - 1;
    my      %results;

    for 0 .. $max-i -> UInt $left
    {
        for $left .. $max-i -> UInt $right
        {
            my      @flipped = flip(@binary, $left, $right);
            my UInt $ones    = count-ones(@flipped);

            %results{$ones}.push: "($left, $right)";
        }
    }

    my $max = (%results.keys.sort: { $^a <=> $^b })[*-1];

    return $max, %results{$max};
}

#-------------------------------------------------------------------------------
sub flip(@binary, UInt:D $left, UInt:D $right --> Array:D)
#-------------------------------------------------------------------------------
{
    my @flipped = @binary;

    for $left .. $right -> UInt $i
    {
        my $digit    = @flipped[$i];
        @flipped[$i] = $digit == 0 ?? 1 !! 0;
    }

    return @flipped;
}

#-------------------------------------------------------------------------------
sub count-ones(@binary --> UInt)
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    $_ == 1 && ++$count for @binary;

    return $count;
}

###############################################################################
