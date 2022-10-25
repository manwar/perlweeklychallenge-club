#!/usr/bin/raku
sub dateToDays($date) {
    constant @monthFirst = (-1, 30, 58, 89, 120, 150, 181, 212, 242, 273, 303, 333);
    my ($day, $month) = split '-', $date;

    return @monthFirst[$month - 1] + $day;
}

sub MAIN(
    $fooStartDate, $fooEndDate, $barStartDate, $barEndDate #= 4 dates in the format DD-MM
) {
    my ($fooStartDay, $fooEndDay, $barStartDay, $barEndDay) =
        map { dateToDays($_); }, 
        ($fooStartDate, $fooEndDate, $barStartDate, $barEndDate);

    if ($fooEndDay < $barStartDay || $fooStartDay > $barEndDay) {
        say "0 days";
    } else {
        my $commonStart =
            $fooStartDay < $barStartDay ?? $barStartDay !! $fooStartDay;
        my $commonEnd = $fooEndDay < $barEndDay ?? $fooEndDay !! $barEndDay;
        my $common = $commonEnd - $commonStart + 1;

        say "$common day", ($common == 1 ?? q{} !! 's');
    }
}