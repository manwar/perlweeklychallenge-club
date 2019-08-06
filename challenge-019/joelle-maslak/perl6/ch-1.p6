#!/usr/bin/env perl6
use v6;

# Shortcut: to have 5 weekends (including Friday), you need 31 days, and
# the 31st must fall on a Sunday.

my @months = « 
    invalid
    Jan Feb Mar Apr May Jun
    Jul Aug Sep Oct Nov Dec
»;

sub MAIN() {
    my $days = (1900..2019).map( { get-all-days($_) } ).flat;
    my $sunday31st = $days.grep( { $_.day-of-week == 7 and $_.day-of-month == 31 } );
    say $sunday31st.map( { @months[$_.month] ~ " " ~ $_.year } ).join("\n");
}

sub get-all-days(UInt:D $year) {
    return gather {
        state $dt = Date.new($year, 1, 1);
        while $dt.year == $year {
            take $dt;
            $dt = $dt.succ;
        }
    }
}


