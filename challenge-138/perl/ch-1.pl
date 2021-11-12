#!/usr/bin/perl
# The Weekly Challenge 138
# Task 1 Work Days
# Usage: ch-1.pl $YEAR
use v5.12.0;
use warnings;
use Time::Local qw 'timelocal_nocheck ';
use Time::HiRes qw 'time'; #for benchmarking

say count_work_days($ARGV[0]) if defined($ARGV[0]) && $ARGV[0] >= 1900;


testing();
benchmark();



sub testing {
    for my $i (1975..2400) {
         say "big event in ", $i 
            if simple_days_count($i) != count_work_days($i);
    }
}



sub count_work_days {
    my $y = $_[0];
    my %wday = (
        "Mon" => 1, 
        "Tue" => 2, 
        "Wed" => 3, 
        "Thu" => 4, 
        "Fri" => 5, 
        "Sat" => 6, 
        "Sun" => 0, 
    );
        
    my $_01Jan = localtime timelocal_nocheck 0, 0, 0, 1, 0, $y;
    my $d_01Jan= $wday{(split " ", $_01Jan)[0]};

    my $diff = (1 - $d_01Jan) % 7;

    my @firstMonday = localtime timelocal_nocheck 0, 0, 0, 1+$diff, 0, $y;

    my $_31Dec = localtime timelocal_nocheck 0, 0, 0, 31, 11, $y;

    my $d_31Dec = $wday{(split " ", $_31Dec)[0]};

    my $back_diff = ($d_31Dec - 5) % 7;


    my @MondayAfterLastFriday 
#        = $back_diff < 3
#           ? localtime timelocal_nocheck 0, 0, 0,  3-$back_diff,    0, $y+1
#           : localtime timelocal_nocheck 0, 0, 0, 31-$back_diff+3, 11, $y;
        = localtime timelocal_nocheck 0, 0, 0, 3-$back_diff, 0, $y+1;

    my $ans 
        = 5 * int (
            (timelocal_nocheck(@MondayAfterLastFriday)
            -timelocal_nocheck(@firstMonday))
                /86400/7
          );

    $ans += 6-$d_01Jan if $d_01Jan > 1;
    $ans += $d_31Dec if $d_31Dec < 5;

    return $ans;

}

sub simple_days_count {
    my %wday = (
        "Mon" => 1, 
        "Tue" => 2, 
        "Wed" => 3, 
        "Thu" => 4, 
        "Fri" => 5, 
        "Sat" => 6, 
        "Sun" => 0, 
    );
    my $y = $_[0];
    my $day_var = timelocal_nocheck 0, 0, 0, 1, 0, $y;
    my $my_day = scalar localtime $day_var;

    my $d = $wday{(split " ", $my_day)[0]};
    
    my $i = 0;
    while ((split " ", $my_day)[4] == $y) {
        $i++ if ($d >= 1 && $d <= 5);
        $day_var = $day_var + 86400;
        $my_day = scalar localtime $day_var;
        $d = $wday{(split " ", $my_day)[0]};
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

    # Output:
    # simple_days_count: 0.491244077682495
    # count_work_days: 0.0362129211425781
}

