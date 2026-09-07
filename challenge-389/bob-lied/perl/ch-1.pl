#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 389 Task 1  Reorder Notes
#=============================================================================
# You are given an array [composer, notes, permutation], reconstruct the
# melody by using each permutation value as the destination position of
# the corresponding note. Use no explicit for, foreach, or while loops.
# Output each result as COMPOSER => reordered notes.
# ASSUMPTION: Input is valid; the notes array and permutation array have
# identical lengths, and the permutation contains each position from
# 1 to N exactly once.
# Example 1
#   Input: $melody = ['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]
#   Output: BACH => D F# A B G E C
#    Note 1 (C)  moves to position 7.
#    Note 2 (D)  moves to position 1.
#    Note 3 (E)  moves to position 6.
#    Note 4 (F#) moves to position 2.
#    Note 5 (G)  moves to position 5.
#    Note 6 (A)  moves to position 3.
#    Note 7 (B)  moves to position 4.
# Example 2
#   Input: $melody = ['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]
#   Output: BEETHOVEN => C G D Ab F#
# Example 3
#   Input: $melody = [ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]
#   Output: BRAHMS => F Bb Db D Ab C Eb G C
# Example 4
#   Input: $melody = [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]
#   Output: BRUCKNER => D Bb F G Eb C F#
# Example 5
#   Input: $melody = ['Berg', [qw(C#)], [1]]
#   Output: BERG => C#
#=============================================================================

use v5.44;
no warnings 'qw'; # Allow # in qw// strings

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

# Usage: perl $0 composer  'a b c'  3 2 1
my $Composer = shift;
my @Notes = split(/ /, shift);
my @Permutation = @ARGV;
say task( [ $Composer, \@Notes, \@Permutation ] );

#=============================================================================
sub taskLOOP($melody)
{
    my ($composer, $notes, $order) = $melody->@*;
    my @song = $notes->@*;

    for my ($note, $pos) ( indexed $order->@* )
    {
        $song[$pos-1] = $notes->[$note];
    }
    return uc($composer). " => @song"; 
}

sub task($melody)
{
    my ($composer, $notes, $order) = $melody->@*;
    my @song;

    # Look, Ma! No [explicit] loops!
    @song[ map { $_ - 1} @$order ] = $notes->@*;
    return uc($composer). " => @song"; 
}

sub runTest
{
    use Test2::V1 -ipP;
    no warnings 'qw';
 
    my @test = (
    { desc => "Example 1",
      melody => ['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]],
      expect => 'BACH => D F# A B G E C',
    },
    { desc => "Example 2",
      melody => ['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]],
      expect => 'BEETHOVEN => C G D Ab F#',
    },
    { desc => "Example 3",
      melody => [ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ],
      expect => 'BRAHMS => F Bb Db D Ab C Eb G C',
    },
    { desc => "Example 4",
      melody => [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ],
      expect => 'BRUCKNER => D Bb F G Eb C F#',
    },
    { desc => "Example 5",
      melody => ['Berg', ['C#'], [1]],
      expect => 'BERG => C#',
    },
    );

    for my $c ( @test )
    {
        is( task($c->{melody}), $c->{expect}, $c->{desc} );
    }

    done_testing;
}
