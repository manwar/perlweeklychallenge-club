#!/usr/bin/raku

sub p(Int $year) {
    return (($year + ($year div 4) - ($year div 100) +  ($year div 400)) % 7);
}

sub isLeap(Int $year) {
    return $year %% 4 && ($year !%% 100 ||  $year %% 400); 
}

sub MAIN(Int $year) {
    my $workDays = 260;
    my $firstDay = p($year);

    if $firstDay ~~ 1 .. 5 {
        $workDays++;
    }

    if isLeap($year) && $firstDay != 1 {
        $workDays++;
    }

    say $workDays;
}
