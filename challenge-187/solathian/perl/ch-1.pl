#!usr/bin/perl -w

# Challange 187 - 1 - Days Together
#   Two friends, Foo and Bar gone on holidays seperately to the same city. You are given their schedule i.e. start date and end date.
#   To keep the task simple, the date is in the form DD-MM and all dates belong to the same calendar year i.e. between 01-01 and 31-12.
#   Also the year is non-leap year and both dates are inclusive.
#   Write a script to find out for the given schedule, how many days they spent together in the city, if at all.

use strict;
use warnings;
no  warnings 'experimental';

use feature ('say', 'signatures');

use constant
{
    MONTHS => [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
};


# my $input0 = { Foo => { SD =>'12-01',  ED => '20-01'}, Bar => { SD =>'15-01',  ED => '18-01'} };
# say ("Output:", days($input0));
# Output: 4 days

# my $input1 = { Foo => { SD =>'02-03',  ED => '12-03'}, Bar => { SD =>'13-03',  ED => '14-03'} };
# say ("Output:", days($input1));
# Output: 0 day


# my $input2 = { Foo => { SD =>'02-03',  ED => '12-03'}, Bar => { SD =>'11-03',  ED => '15-03'} };
# say ("Output:", days($input2));
# Output: 2 days


# my $input3 = { Foo => { SD =>'30-03',  ED => '05-04'}, Bar => { SD =>'28-03',  ED => '02-04'} };
# say ("Output:", days($input3));
# Output: 4 days

# convert month-day into index, assume that is in correct format
sub convert($key)
{
    my ($day, $month) = $key =~ /(\d{2})-(\d{2})/ ;

    my $i    = 0;
    my $days = $day;

    while ($i < $month - 1)
    {
        $days += MONTHS->[$i];
        $i++;
    }

    return $days;
}

sub days($hashRef)
{
    my $retVal   = 0;

    my $startFoo =  convert($hashRef->{Foo}->{SD});
    my $endFoo   =  convert($hashRef->{Foo}->{ED});

    my $startBar =  convert($hashRef->{Bar}->{SD});
    my $endBar   =  convert($hashRef->{Bar}->{ED});

    # if they do not meet
    if( ($endFoo < $startBar) || ($endBar < $startFoo))
    {
        # do nothing
    }
    else
    {
        my @tempArr = ($startFoo, $endFoo, $startBar, $endBar);
        @tempArr = sort  @tempArr;

        $retVal = $tempArr[2] - $tempArr[1] + 1 ;
    }

    return $retVal;
}