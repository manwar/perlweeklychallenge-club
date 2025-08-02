#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use DateTime;
use List::Util qw{ any };

my @examples = (

    {
        start_date    => '2018-06-28',
        offset        => 3,
        bank_holidays => ['2018-07-03']
    },
    { start_date => '2018-06-28', offset => 3 },
    { start_date => '2019-11-01', offset => 3 },
);

for my $example (@examples) {
    my $output = banking_day_offset($example);
    my $input  = '';
    $input .= qq{\$startdate = $example->{start_date}};
    $input .= qq{, \$offset = $example->{offset}};
    $input .=
        qq{, \$bank_holidays = [}
        . ( join ', ', map { qq{'$_'} } $example->{bank_holidays}->@* ) . ']'
        if defined $example->{bank_holidays};

    say <<~"END";
    Input:  $input
    Output: $output
    END
}

sub banking_day_offset ($obj) {
    my @bank_holidays ;
     @bank_holidays = $obj->{bank_holidays}->@* if defined $obj->{bank_holidays};

    my ( $y, $m, $d ) = split /-/, $obj->{start_date};
    my $dt = DateTime->new( year => $y, month => $m, day => $d );
    my $c  = 0;
    while ( $c < $obj->{offset} ) {
        $dt->add( days => 1 );
        next if $dt->day_of_week == 6;    # Saturday
        next if $dt->day_of_week == 7;    # Sunday
        next if any { $dt->ymd eq $_ } @bank_holidays;
        $c++;
    }

    return $dt->ymd;
}
