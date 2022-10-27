sub MAIN() {
    my @schedules = %( foo => <12-01 20-01>, bar => <15-01 18-01> ),
                    %( foo => <02-03 12-03>, bar => <13-03 14-03> ),
                    %( foo => <02-03 12-03>, bar => <11-03 15-03> ),
                    %( foo => <30-03 05-04>, bar => <28-03 02-04> );

    for @schedules -> %schedule {
        put days-together(%schedule) ~ " day(s)";
    }
}

#| date-to-int takes a date in "DD-MM" form and converts it to an
#| integer.
sub date-to-int(Str $date --> Int) {
    my @days-in-month = 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31;

    given $date.split("-").map(*.Int) {
        return $_[0] + ([+] @days-in-month[^ ($_[1] - 1)])
    }
}

#| days-together returns the days foo & bar are together.
sub days-together(%schedule --> Int) {
    my $foo-start = date-to-int %schedule<foo>[0];
    my $foo-end = date-to-int %schedule<foo>[1];

    my $bar-start = date-to-int %schedule<bar>[0];
    my $bar-end = date-to-int %schedule<bar>[1];

    return min($foo-end, $bar-end) - max($foo-start, $bar-start) + 1;
}
