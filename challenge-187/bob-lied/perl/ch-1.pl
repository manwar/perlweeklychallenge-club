#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 187 Task 1 Days Together
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Two friends, Foo and Bar gone on holidays seperately to the same city.
# You are given their schedule i.e. start date and end date.
# To keep the task simple, the date is in the form DD-MM and all dates belong
# to the same calendar year i.e. between 01-01 and 31-12. Also the year is
# non-leap year and both dates are inclusive.
# Write a script to find out for the given schedule, how many days they spent
# together in the city, if at all.
#
# Example 1 Input: Foo => SD: '12-01' ED: '20-01'
#                  Bar => SD: '15-01' ED: '18-01'
#   Output: 4 days
#
# Example 2 Input: Foo => SD: '02-03' ED: '12-03'
#                  Bar => SD: '13-03' ED: '14-03'
#   Output: 0 day
#
# Example 3 Input: Foo => SD: '02-03' ED: '12-03'
#                  Bar => SD: '11-03' ED: '15-03'
#   Output: 2 days
#
# Example 4 Input: Foo => SD: '30-03' ED: '05-04'
#                  Bar => SD: '28-03' ED: '02-04'
#   Output: 4 days
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my %Schedule = (
    example1 => { Foo => { SD => '12-01', ED => '20-01' },
                  Bar => { SD => '15-01', ED => '18-01' },
              },
    example2 => { Foo => { SD => '02-03', ED => '12-03' },
                  Bar => { SD => '13-03', ED => '14-03' },
              },
    example3 => { Foo => { SD => '02-03', ED => '12-03' },
                  Bar => { SD => '11-03', ED => '15-03' },
              },
    example4 => { Foo => { SD => '30-03', ED => '05-04' },
                  Bar => { SD => '28-03', ED => '02-04' },
              },
);

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

if ( @ARGV )
{
    my ($fooSD, $fooED, $barSD, $barED) = @ARGV;
    say _together($fooSD, $fooED, $barSD, $barED);
}
else
{
    my $Sched="
    Foo => SD: '12-01' ED: '20-01'
    Bar => SD: '15-01' ED: '18-01'
    ";

    my $sch = parseSched($Sched);
    say together('Foo', 'Bar', $sch);

    $sch = parseSched( qq(X => SD: '02-03' ED: '12-03' Y => SD: '13-03' ED: '14-03') );
    say together('X', 'Y', $sch);
}

sub parseSched($s)
{
    my %sched;
    while ( $s =~ m/(\w+) => SD: '([-0-9]+)' ED: '([-0-9]+)'/g )
    {
        $sched{$1} = { SD => $2, ED => $3 };
    }
    return \%sched;
}

sub dayOfYear($ddmm)
{
    use Time::Piece;

    # Use a non-leap year as default
    return Time::Piece->strptime("$ddmm-2023", "%d-%m-%Y")->day_of_year;
}

sub _together($aSD, $aED, $bSD, $bED)
{
    my $days = 0;
    # Test for overlapping ranges
    if ( $aED >= $bSD && $bSD <= $aED )
    {
        use List::Util qw/min max/;
        $days = min($aED, $bED) - max($aSD, $bSD) + 1;
    }
    return $days;
}

sub together($friendA, $friendB, $sched)
{
    my ($aSD, $aED) = map { dayOfYear($_) } $sched->{$friendA}->@{qw/SD ED/};
    my ($bSD, $bED) = map { dayOfYear($_) } $sched->{$friendB}->@{qw/SD ED/};

    return _together($aSD, $aED, $bSD, $bED);
}

sub runTest
{
    use Test2::V0;

    is( together( "Foo", "Bar", $Schedule{example1} ), 4, "Example 1");
    is( together( "Foo", "Bar", $Schedule{example2} ), 0, "Example 1");
    is( together( "Foo", "Bar", $Schedule{example3} ), 2, "Example 1");
    is( together( "Foo", "Bar", $Schedule{example4} ), 4, "Example 1");

    done_testing;
}

