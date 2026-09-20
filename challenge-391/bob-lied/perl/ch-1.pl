#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 391 Task 1  Array Median
#=============================================================================
# You are given two sorted arrays.  Write a script to merge the two given
# sorted arrays and return the median of the merged array.
# Example 1 Input: @arr1 = (2), @arr2 = (4)
#           Output: 3.0
# Example 2 Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
#           Output: 7.0
# Example 3 Input: @arr1 = (), @arr2 = (10,20,30,40)
#           Output: 25.0
# Example 4 Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
#           Output: 4.5
# Example 5 Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
#           Output: 2.0
#=============================================================================

use v5.44;

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

my $a1 = [ split(/,/, shift) ];
my $a2 = [ split(/,/, shift) ];
say task1($a1, $a2);

#=============================================================================
sub merge($arr1, $arr2)
{
    return undef unless @$arr1 || @$arr2;

    # Given that both arrays are sorted, we don't have to sort them together;
    # they can be merged in one pass. And because we want the median, we only
    # have to merge to the midpoint.

    # Make copies of arr1 and arr2 because we're going to destroy them
    my @a1 = $arr1->@*;
    my @a2 = $arr2->@*;

    my $length = @a1 + @a2;
    my $mid = floor($length / 2);
    my $isOdd = $length % 2;

    my @merged;

    while ( @a1 && @a2 && @merged <= $mid )
    {
        push @merged, ( $a1[0] < $a2[0] ? shift(@a1) : shift(@a2) );
    }

    # At this point, if we haven't merged enough elements to reach
    # the midpoint, then we've exhausted either a1 or a2. Add enough
    # elements to reach the midpoint.
    if ( @merged <= $mid )
    {
        my $toMidPoint = $mid - @merged;
        if   ( @a1 ) { push @merged, @a1[0 .. $toMidPoint] }
        else         { push @merged, @a2[0 .. $toMidPoint] }
    }

    return $isOdd ? $merged[$mid] : ( ($merged[$mid] + $merged[$mid-1]) / 2);
}

# Sort both arrays together, index the midpoint
sub diysort($arr1, $arr2)
{
    my @all = sort { $a <=> $b } $arr1->@*, $arr2->@*;
    if ( @all >= 1 )
    {
        if ( @all % 2 ) # Odd number of elements
        {
            return $all[ floor(@all/2) ];
        }
        else # Even number of elements
        {
            my $mid = @all / 2;
            return ($all[$mid] + $all[$mid-1]) / 2;
        }
    }
    else # No elements, two empty lists were given
    {
        return undef;
    }
}

# use module Statistics::Basic
sub basic($arr1, $arr2)
{
    return undef unless @$arr1 || @$arr2;
    use Statistics::Basic::Median;
    return 0+ Statistics::Basic::Median->new( $arr1->@*, $arr2->@* );
}

# use module Statistics::Descriptive
sub descr($arr1, $arr2)
{
    return undef unless @$arr1 || @$arr2;
    use Statistics::Descriptive;
    my $stat = Statistics::Descriptive::Full->new;
    $stat->add_data( $arr1->@*, $arr2->@* );
    return $stat->median;
}

# use module PDL
# PDL and Test2 can't coexist. PDL benchmarks at about same as Basic.
sub taskPDL($arr1, $arr2)
{
    #return undef unless @$arr1 || @$arr2;
    #use PDL;
    #my $data = pdl (  $arr1->@*, $arr2->@* );
    #return median($data);
}

#======================================================================
sub runTest
{
    use Test2::V1 -ipP;

    my @case = (
        { desc => "Example 1", expect => 3.0,
          in   => [ [    2], [            4] ],
        },
        { desc => "Example 2", expect => 7.0,
          in   => [ [1,2,3], [     7,8,9,10] ],
        },
        { desc => "Example 3", expect => 25.0,
          in   => [      [], [  10,20,30,40] ],
        },
        { desc => "Example 4", expect => 4.5,
          in   => [   [100], [1,2,3,4,5,6,7] ],
        },
        { desc => "Example 5", expect => 2.0,
          in   => [ [1,2,2], [        2,2,3] ],
        },
        { desc => "One element", expect => 9.0,
          in   => [ [9], [] ],
        },
        { desc => "Empty lists", expect => undef,
          in   => [ [], [] ],
        },
    );

    my @task = (
        { name => "MERGE", f => \&merge  },
        { name =>   "DIY", f => \&diysort },
        { name => "BASIC", f => \&basic },
        { name => "DESCR", f => \&descr },
      # { name =>   "PDL", f => \&taskPDL },
    );

    for my $sub ( @task )
    {
        for my $t ( @case )
        {
            is( $sub->{f}->( $t->{in}->@* ), $t->{expect}, "$sub->{name} $t->{desc}");
        }
    }

    done_testing;
}

#======================================================================
sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @arr1 = ( 0 .. 99 ); my @arr2 = ( 0 .. 99);

    cmpthese($repeat, {
            merge => sub { merge(   [ 0 .. 99 ], [ 0 .. 99 ] ) },
            diy   => sub { diysort( [ 0 .. 99 ], [ 0 .. 99 ] ) },
            basic => sub { basic(   [ 0 .. 99 ], [ 0 .. 99 ] ) },
            descr => sub { descr(   [ 0 .. 99 ], [ 0 .. 99 ] ) },
          # pdl   => sub { taskPDL(\@arr1, \@arr2) },
        });
}
# $ perl ch-1.pl -b 150000
#           Rate descr merge basic   diy
# descr  40107/s    --  -49%  -55%  -87%
# merge  78534/s   96%    --  -12%  -75%
# basic  88757/s  121%   13%    --  -72%
# diy   312500/s  679%  298%  252%    --
