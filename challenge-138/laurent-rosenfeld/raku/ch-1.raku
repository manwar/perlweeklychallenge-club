sub work-days (UInt $y) {
    my $new-year-day = Date.new("$y-01-01");
    my $fifty-two-weeks-later = $new-year-day.later(:52weeks);
    my $count = 52 * 5;
    $count++ if 1 <= $fifty-two-weeks-later.day-of-week < 6;
    return $count if $fifty-two-weeks-later.day == 31;
    $count++ if 1 <= $fifty-two-weeks-later.later(:1days).day-of-week < 6;
    return $count;
}
say "$_ -> ", work-days $_ for 2000..2021;
