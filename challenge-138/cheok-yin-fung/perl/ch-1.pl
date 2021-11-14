#!/usr/bin/perl
# The Weekly Challenge 138
# Task 1 Work Days
# Usage: ch-1.pl $YEAR
use v5.12.0;
use warnings;
use Time::Local qw 'timelocal_nocheck ';
use Time::localtime;
use Time::HiRes qw 'time'; #for benchmarking

say count_work_days($ARGV[0]) if defined($ARGV[0]) && $ARGV[0] >= 1900;


testing();
benchmark();



sub testing {
    for my $i (1975..2400) {
         say "big event in ", $i , "\n"
            if simple_days_count($i) != count_work_days($i);
    }
}



sub count_work_days {
    my $y = $_[0];
        
    my $_01Jan = localtime timelocal_nocheck 0, 0, 0, 1, 0, $y;
    my $d_01Jan = $_01Jan->wday();
    my $diff = (1 - $d_01Jan) % 7;

    my $firstMonday = timelocal_nocheck 0, 0, 0, 1+$diff, 0, $y;

    my $_31Dec = localtime timelocal_nocheck 0, 0, 0, 31, 11, $y;

    my $d_31Dec = $_31Dec->wday();   

    my $back_diff = ($d_31Dec - 5) % 7;


    my $MondayAfterLastFriday 
        = timelocal_nocheck 0, 0, 0, 3-$back_diff, 0, $y+1;

    my $ans 
        = 5 * int (
            ($MondayAfterLastFriday
            -$firstMonday)
                /86400/7
          );


    $ans += 6-$d_01Jan if $d_01Jan > 1;
    $ans += $d_31Dec if $d_31Dec < 5;

    return $ans;
}



sub simple_days_count {
    my $y = $_[0];
    my $day_var = timelocal_nocheck 0, 0, 0, 1, 0, $y;
    my $my_day = localtime $day_var;
    my $d = $my_day->wday();
    
    my $i = 0;
    while ( ($my_day->year()+1900) == $y) {
        $i++ if ($d >= 1 && $d <= 5);
        $day_var = $day_var + 86400;
        $my_day = localtime $day_var;
        $d = $my_day->wday();
    }
    return $i;
}



sub benchmark {

    my $time_0 = time;
    for my $i (1975..2400) {
        simple_days_count($i);
    }

    my $time_1 = time;
    for my $i (1975..2400) {
        count_work_days($i);
    }

    my $time_2 = time;

    say "Benchmarking:";
    say "simple_days_count: ", $time_1 - $time_0;
    say "count_work_days: ", $time_2 - $time_1;

    # Output, before using Time::localtime
    # simple_days_count: 0.491244077682495
    # count_work_days: 0.0362129211425781

    # Output, after using Time::localtime
    # simple_days_count: 1.16461586952209
    # count_work_days: 0.0263321399688721
}


