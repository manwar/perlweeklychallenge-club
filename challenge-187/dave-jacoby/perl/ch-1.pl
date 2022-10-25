#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use DateTime;

# I added a bunch of additional test cases to be sure of the
# cases
my @input = (
    {
        foo => { SD => '12-01', ED => '20-01', },
        bar => { SD => '15-01', ED => '18-01', }
    },
    {
        foo => { SD => '15-01', ED => '18-01', },
        bar => { SD => '12-01', ED => '20-01', }
    },
    {
        foo => { SD => '02-03', ED => '12-03', },
        bar => { SD => '13-03', ED => '14-03', }
    },
    {
        foo => { SD => '13-03', ED => '14-03', },
        bar => { SD => '02-03', ED => '12-03', }
    },
    {
        foo => { SD => '02-03', ED => '12-03', },
        bar => { SD => '11-03', ED => '15-03', }
    },
    {
        foo => { SD => '30-03', ED => '05-04', },
        bar => { SD => '28-03', ED => '02-04', }
    },
    {
        foo => { SD => '11-11', ED => '12-12', },
        bar => { SD => '01-11', ED => '01-12', }
    }
);

# So, that's from the beginning of the 12th month to the beginning
# of the 20th month? That doesn't make sense.
#
# No, wait, this is DD-MM, an unsortable format.
#
# I'm a big fan of YYYY-MM-DD and have been for a quarter century

for my $input (@input) {
    my $output = days_together($input);
    say <<"END";
INPUT:  Foo => SD: '$input->{foo}{SD}' ED: '$input->{foo}{ED}'
        Bar => SD: '$input->{bar}{SD}' ED: '$input->{bar}{ED}'
OUTPUT:     $output

END
}

sub days_together ($input) {
    my $foo    = $input->{foo};
    my $bar    = $input->{bar};
    my $foo_SD = day_month_to_day_of_year( $foo->{SD} );
    my $foo_ED = day_month_to_day_of_year( $foo->{ED} );
    my $bar_SD = day_month_to_day_of_year( $bar->{SD} );
    my $bar_ED = day_month_to_day_of_year( $bar->{ED} );

    # cases:

    #   foo before bar
    if ( $foo_SD < $bar_SD && $foo_ED < $bar_SD ) {
        return 0;
    }

    #   foo after bar
    elsif ( $foo_SD > $bar_ED && $foo_ED > $bar_ED ) {
        return 0;
    }

    #   foo within bar
    elsif ( $foo_SD > $bar_SD && $foo_ED < $bar_ED ) {
        return $foo_ED - $foo_SD;
    }

    #   bar within foo
    elsif ( $foo_SD < $bar_SD && $foo_ED > $bar_ED ) {
        return $bar_ED - $bar_SD;
    }

    # foo starts and ends before bar
    elsif ( $foo_SD < $bar_SD && $foo_ED < $bar_ED ) {
        return $foo_ED - $bar_SD;
    }

    # bar starts and ends before foo
    elsif ( $foo_SD > $bar_SD && $foo_ED > $bar_ED ) {
        return $bar_ED - $foo_SD;
    }

    # remember the impossible situation we never planned for?
    else {
        return 0;
    }

    say <<"END";
    \$foo_SD    $foo_SD
    \$foo_ED    $foo_ED
    \$bar_SD    $bar_SD
    \$bar_ED    $bar_ED
END

    return 5000;
}

# It is much easier to deal with day-of-year than month and day
sub day_month_to_day_of_year ( $date ) {
    my ( $day, $month ) = split /\D/, $date;
    my $dt = DateTime->new(
        year  => 2022,
        month => $month,
        day   => $day,
    );

    # say join "\t", '', $month, $day,
    #     $dt->day_of_year,
    #     $dt->month_name,
    #     $dt->ymd;
    return $dt->day_of_year;
}
