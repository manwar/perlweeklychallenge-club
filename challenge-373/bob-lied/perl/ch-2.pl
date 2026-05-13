#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 373 Task 2  List Division
#=============================================================================
# You are given a list and a non-negative integer.  Write a script to divide
# the given list into given non-negative integer equal parts. Return -1 if
# the integer is more than the size of the list.
# Example 1 Input: @list = (1,2,3,4,5), $n = 2
#           Output: ((1,2,3), (4,5))
#   5 / 2 = 2 remainder 1.
#   The extra element goes into the first chunk.
# Example 2 Input: @list = (1,2,3,4,5,6), $n = 3
#           Output: ((1,2), (3,4), (5,6))
# Example 3 Input: @list = (1,2,3), $n = 2
#           Output: ((1,2), (3))
# Example 4 Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
#           Output: ((1,2), (3,4), (5,6), (7,8), (9,10))
# Example 5 Input: @list = (1,2,3), $n = 4
#           Output: -1
# Example 6 Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
#           Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

my $N = 1;  # How many chunks? 1 seems like a reasonable default.

GetOptions("n:i" => \$N, "test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================
# Alternative implementations
my @func = (
    { name => "listDiv", ptr => \&listDiv },
    { name => "ld2", ptr => \&ld2 },
); 
#=============================================================================

exit(!runTest()) if $DoTest;

try        { say showAofA( listDiv([@ARGV], $N) ); }
catch ($e) { say "-1" }

#=============================================================================
sub showAofA($ref)
{
    return '('. join(',', map { '('.join(',', $_->@*).')' } $ref->@*) .')';
}

#=============================================================================
sub listDiv($list, $n)
{
    my $size = @$list;
    die "N out of range (must be <= $size)" if $n > $size;

    my $chunk = floor($size / $n);
    my $extra = $size % $n;
    my @answer;

    while ( @$list )
    {
        push @answer, [ splice(@$list, 0, $chunk + ( $extra-- > 0 ? 1 : 0)) ];
    }
    return \@answer;
}

#=============================================================================
sub ld2($list, $n)
{
    my $size = @$list;
    die "N out of range (must be <= $size)" if $n > $size;

    my $chunk = floor($size / $n);
    my $extra = $size % $n;
    my @answer;

    while ( $extra-- ) { push @answer, [ splice(@$list, 0, $chunk + 1) ]; }
    while ( @$list   ) { push @answer, [ splice(@$list, 0, $chunk    ) ]; }
    return \@answer;
}

#=============================================================================
sub runTest
{
    use Test2::V0;
    use Test2::Tools::Exception;

    is( showAofA([[1]]), "((1))", "Show AofA simple");
    is( showAofA([[1,2]]), "((1,2))", "Show AofA one list");
    is( showAofA([[1,2],[3,4]]), "((1,2),(3,4))", "Show AofA two list");

    my @case = (
    { name => "Example 1",
      list => [1,2,3,4,5], n => 2,
      expect => [[1,2,3], [4,5]]
    },
    { name => "Example 2",
      list => [1,2,3,4,5,6], n => 3,
      expect => [[1,2], [3,4], [5,6]]
    },
    { name => "Example 3",
      list => [1,2,3], n => 2,
      expect => [[1,2], [3]]
    },
    { name => "Example 4",
      list => [1,2,3,4,5,6,7,8,9,10], n => 5,
      expect => [[1,2], [3,4], [5,6], [7,8], [9,10]]
    },
    { name => "Example 6",
      list => [72,57,89,55,36,84,10,95,99,35], n => 7,
      expect => [[72,57], [89,55], [36,84], [10], [95], [99], [35]]
    },
    { name => "One chunk",
      list => [ 1..8 ], n => 1,
      expect => [ [1..8] ],
    },
    { name => "Chunks of 1",
      list => [ 1..4 ], n => 4,
      expect => [ [1],[2],[3],[4] ],
    },
    );

    for my $f ( @func )
    {
        for my $tc ( @case )
        {
            is( $f->{ptr}( [ $tc->{list}->@* ], $tc->{n} ), $tc->{expect}, "$f->{name} $tc->{name}" ); 
        }
    }
    # Test cases that throw exceptions
    for my $f ( @func )
    {
        like ( dies { $f->{ptr}( [1,2,3], 4 ) },  qr/out of range/, "$f->{name} Example 5 throws for n too large")
    }

    done_testing;
}

#=============================================================================
sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
