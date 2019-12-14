#! /opt/local/bin/perl
#
#        dimming_of_the_day.pl
#
#        PWC037 - Task #2
#         Write a script to find out the DayLight gain/loss in the month of
#         December 2019 as compared to November 2019 in the city of London. You
#         can find out sunrise and sunset data for November 2019 and December
#         2019 for London:
#            https://www.timeanddate.com/sun/uk/london?month=12&year=2019
#
#         method: To find the answer we will harvest the data from the posted
#             table, sum the total and compute a daily average for each month. For a
#             deeper look, we'll have a go at the daily rate of change over
#             each of the the 30 days that overlap the months.
#
#             The first order of business is to acquire the data. We go to the web
#             and cut and paste the data. However we note this is perilous, as it
#             appears to have a bit of both obvious and less so unicode mixed in
#             with the bog-standard text elements that easily translate to ascii.
#             This will haunt us in the regex later, but for now this gets us
#             started. We leave the tables whole, only copying the data section,
#             adding new, simple headers for the two months examined. So far so
#             good.
#
#             The regex for parsing the data will pull out the day of the month
#             and the daylength fields, capturing the hours, minutes and seconds.
#             On constructing this it immediately becomes apparent something has
#             gone wrong, because of what appear to be unicode characters
#             interspersed, specifically the arrow indicating the angular location
#             of the sunrise and sunset events {U+2191} UPWARD ARROW. It's fairly
#             straightforward to insert this into  our regex, which begins to
#             match again. Later on, past the fields we're interested in, there is
#             also a super sneaky substitution of '−' for '-', which is in fact a
#             codepoint for {U+2212} MINUS SIGN, but we'll ignore that one, and
#             stop matching before we reach it.
#
#             Once we have the data, we stash it in a data structure, a hash keyed
#             on days with the months as sub-keys, the hours, minutes and seconds
#             in an anonymous array. To do mathimatical operations on the times we
#             have a subroutine to convert to seconds, and another to display
#             seconds as a string like "hh:mm:ss". Massaging the data we reveal
#             just how far North London really sits. Good thing the North Atlantic
#             rain keeps it warm. We can observe the Juggernaut of shrinking
#             daylight slow as we approach the Solstice, yet even with increasing
#             day length the 30-day change continues to me negative throughout the
#             observation period, albeit slowed. The maximum observed shift in
#             hours is calculated and found to be (as expected) between November 1
#             and December 22, with a reduction of nearly two hours. The winter
#             solstice occurs in London at 4:19am on December 22.
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ':5.26';

## ## ## ## ## MAIN
my $month;
my $data = {};        ## data -> {day_dates} -> {month}

while (my $line = <DATA>) {
    next if $line =~ /^\s*$/;
    if ( $line =~ /^([A-Za-z]+)\s+(\d+)/ ) {
        $month = $1;
        next;
    }

    ## the parsing regex in all its glory:
    ## (\d+)\s+\d+:\d\d\s[apm]+\s↑\s[()0-9°]+\s+\d+:\d\d\s[apm]+\s↑\s[()0-9°]+\s+(\d+:\d\d:\d\d)\s\W(\d:\d\d)
    ##
    if ($line =~ /^ (\d+)                                ## the day number
                    \s+                                  ##
                    \d+:\d\d\s[apm]+\s↑\s[()0-9°]+       ## the sunrise time, with pesky upward arrow
                    \s+                                  ##
                    \d+:\d\d\s[apm]+\s↑\s[()0-9°]+       ## the sunset time, with pesky upward arrow
                    \s+                                  ##
                    (\d+):(\d\d):(\d\d)\s/x) {           ## the day length time, with captured hours, minutes, seconds
        $data->{$1}->{$month} = [$2, $3, $4];
    }
}

## calculate the daily averages for the months
my $nov = {name => "November"};
my $dec = {name => "December"};

for ($nov, $dec) {
    for my $day (keys $data->%*) {
        $_->{sum} += hms2s($data->{$day}->{$_->{name}}) if exists $data->{$day}->{$_->{name}};
        $_->{days}++ if exists $data->{$day}->{$_->{name}};
    }
    $_->{avg} = $_->{sum} / $_->{days};
    printf "%s averages %s of day length over %d days\n", $_->{name}, sec2display( $_->{avg} ), $_->{days};
}

printf "The daily amount of daytime was/will be reduced on average %s between November and December.\n\n",
            sec2display($dec->{avg} - $nov->{avg});


## insert the 30-day delta between months
my $delta;
for ( 1..30 ) {
    $delta = hms2s($data->{$_}->{December}) - hms2s($data->{$_}->{November});
    printf  " day %2d        30-day Δ  %s   (Nov %2d - Dec %2d) \n", $_, sec2display($delta), $_, $_;
}
##  ...and a special case for Dec 31
$delta = hms2s($data->{31}->{December}) - hms2s($data->{1}->{December});
printf  " day %2d        30-day Δ  %s   (Dec  1 - Dec 31) \n\n", 31, sec2display($delta);


## compute the largest reduction over the time period
## uses a trick to find max or min of a list by sorting and taking the first element
my %november = map { $_ => hms2s($data->{$_}->{November}) } (1..30);
my $longest_day = (sort {$november{$b} <=> $november{$a}} keys %november)[0];
my %december = map { $_ => hms2s($data->{$_}->{December}) } (1..31);
my $shortest_day = (sort {$december{$a} <=> $december{$b}} keys %december)[0];
printf "the maximum reduction of day length was between November %d and December %d, %s \n\n",
            $longest_day, $shortest_day, sec2display($december{$shortest_day}-$november{$longest_day});

## unpredictability disclaimer
print safe_harbour();



## ## ## ## ## SUBS

sub sec2display {
## given a time in seconds, returns a string of hh::mm::ss
    use integer;
    my $out = $_[0] < 0 ? "-" : "+";                        ## handle negative sign gracefully
    my $sec = abs(shift);
    my ($hours, $hrem) = ($sec / 3600, $sec % 3600);
    my ($mins, $secs)  = ($hrem / 60, $hrem % 60);
    $out .= sprintf "%d:%02d:%02d" , abs($hours), abs($mins), abs($secs);
    return $out;
}

sub hms2s {
## given an array ref of [h,m,s], returns seconds
    my ($h, $m, $s) = $_[0]->@*;
    return $h * 3600 + $m * 60 + $s;
}

sub safe_harbour {
    return<<'__END__';
SAFE HARBOUR STATEMENT
Except for astronomical information contained herein, the statements in this
release are forward-looking and made pursuant to the safe harbor provisions of
the Private Securities Litigation Reform Act of 1995. Forward-looking statements
involve known and unknown risks and uncertainties, which may cause the actual
sunlight observed in future periods to differ materially from forecasted or
expected results. Those risks include, among other things, impenetrable cloud
cover, eternal rain, general gloom and the off chance the sun may mysteriously
never rise at all. Those and other risks are more fully described in the
literature, specifically the works of Charles Dickens.
__END__

}

__DATA__
November 2019
1     6:53 am ↑ (112°)    4:34 pm ↑ (247°)    9:40:44    -3:35    5:00 am    6:27 pm    5:38 am    5:48 pm    6:18 am    5:09 pm    11:44 am (24.1°)    92.268
2     6:55 am ↑ (113°)    4:32 pm ↑ (247°)    9:37:10    -3:33    5:01 am    6:25 pm    5:40 am    5:47 pm    6:19 am    5:07 pm    11:44 am (23.8°)    92.243
3     6:56 am ↑ (113°)    4:30 pm ↑ (246°)    9:33:37    -3:32    5:03 am    6:24 pm    5:41 am    5:45 pm    6:21 am    5:05 pm    11:44 am (23.5°)    92.219
4     6:58 am ↑ (114°)    4:28 pm ↑ (246°)    9:30:07    -3:30    5:04 am    6:22 pm    5:43 am    5:43 pm    6:23 am    5:04 pm    11:44 am (23.2°)    92.195
5     7:00 am ↑ (114°)    4:27 pm ↑ (245°)    9:26:38    -3:29    5:06 am    6:21 pm    5:45 am    5:42 pm    6:24 am    5:02 pm    11:44 am (22.9°)    92.171
6     7:02 am ↑ (115°)    4:25 pm ↑ (245°)    9:23:11    -3:27    5:07 am    6:19 pm    5:46 am    5:40 pm    6:26 am    5:01 pm    11:44 am (22.6°)    92.147
7     7:03 am ↑ (115°)    4:23 pm ↑ (244°)    9:19:45    -3:25    5:09 am    6:18 pm    5:48 am    5:39 pm    6:28 am    4:59 pm    11:44 am (22.3°)    92.123
8     7:05 am ↑ (116°)    4:22 pm ↑ (244°)    9:16:22    -3:23    5:10 am    6:16 pm    5:49 am    5:38 pm    6:29 am    4:58 pm    11:44 am (22.0°)    92.100
9     7:07 am ↑ (116°)    4:20 pm ↑ (243°)    9:13:01    -3:21    5:12 am    6:15 pm    5:51 am    5:36 pm    6:31 am    4:56 pm    11:44 am (21.7°)    92.077
10    7:09 am ↑ (117°)    4:18 pm ↑ (243°)    9:09:42    -3:18    5:13 am    6:14 pm    5:52 am    5:35 pm    6:32 am    4:55 pm    11:44 am (21.4°)    92.055
11    7:10 am ↑ (117°)    4:17 pm ↑ (242°)    9:06:25    -3:16    5:15 am    6:13 pm    5:54 am    5:34 pm    6:34 am    4:53 pm    11:44 am (21.1°)    92.033
12    7:12 am ↑ (118°)    4:15 pm ↑ (242°)    9:03:11    -3:14    5:16 am    6:11 pm    5:55 am    5:32 pm    6:36 am    4:52 pm    11:44 am (20.9°)    92.011
13    7:14 am ↑ (118°)    4:14 pm ↑ (241°)    8:59:59    -3:11    5:18 am    6:10 pm    5:57 am    5:31 pm    6:37 am    4:51 pm    11:44 am (20.6°)    91.990
14    7:16 am ↑ (119°)    4:12 pm ↑ (241°)    8:56:50    -3:09    5:19 am    6:09 pm    5:58 am    5:30 pm    6:39 am    4:49 pm    11:44 am (20.3°)    91.969
15    7:17 am ↑ (119°)    4:11 pm ↑ (241°)    8:53:44    -3:06    5:20 am    6:08 pm    6:00 am    5:29 pm    6:40 am    4:48 pm    11:45 am (20.1°)    91.948
16    7:19 am ↑ (120°)    4:10 pm ↑ (240°)    8:50:40    -3:03    5:22 am    6:07 pm    6:01 am    5:28 pm    6:42 am    4:47 pm    11:45 am (19.8°)    91.928
17    7:21 am ↑ (120°)    4:08 pm ↑ (240°)    8:47:39    -3:00    5:23 am    6:06 pm    6:03 am    5:26 pm    6:44 am    4:46 pm    11:45 am (19.6°)    91.908
18    7:22 am ↑ (121°)    4:07 pm ↑ (239°)    8:44:42    -2:57    5:25 am    6:05 pm    6:04 am    5:25 pm    6:45 am    4:44 pm    11:45 am (19.3°)    91.889
19    7:24 am ↑ (121°)    4:06 pm ↑ (239°)    8:41:48    -2:54    5:26 am    6:04 pm    6:06 am    5:24 pm    6:47 am    4:43 pm    11:45 am (19.1°)    91.870
20    7:26 am ↑ (121°)    4:05 pm ↑ (238°)    8:38:57    -2:50    5:27 am    6:03 pm    6:07 am    5:24 pm    6:48 am    4:42 pm    11:46 am (18.9°)    91.851
21    7:27 am ↑ (122°)    4:04 pm ↑ (238°)    8:36:09    -2:47    5:29 am    6:02 pm    6:08 am    5:23 pm    6:50 am    4:41 pm    11:46 am (18.6°)    91.833
22    7:29 am ↑ (122°)    4:03 pm ↑ (238°)    8:33:25    -2:43    5:30 am    6:01 pm    6:10 am    5:22 pm    6:51 am    4:40 pm    11:46 am (18.4°)    91.815
23    7:31 am ↑ (123°)    4:01 pm ↑ (237°)    8:30:45    -2:40    5:31 am    6:01 pm    6:11 am    5:21 pm    6:53 am    4:39 pm    11:46 am (18.2°)    91.797
24    7:32 am ↑ (123°)    4:00 pm ↑ (237°)    8:28:09    -2:36    5:33 am    6:00 pm    6:13 am    5:20 pm    6:54 am    4:39 pm    11:47 am (18.0°)    91.780
25    7:34 am ↑ (123°)    3:59 pm ↑ (237°)    8:25:36    -2:32    5:34 am    5:59 pm    6:14 am    5:19 pm    6:56 am    4:38 pm    11:47 am (17.8°)    91.762
26    7:35 am ↑ (124°)    3:59 pm ↑ (236°)    8:23:08    -2:28    5:35 am    5:59 pm    6:15 am    5:19 pm    6:57 am    4:37 pm    11:47 am (17.6°)    91.745
27    7:37 am ↑ (124°)    3:58 pm ↑ (236°)    8:20:44    -2:23    5:37 am    5:58 pm    6:17 am    5:18 pm    6:58 am    4:36 pm    11:47 am (17.4°)    91.728
28    7:38 am ↑ (124°)    3:57 pm ↑ (236°)    8:18:24    -2:19    5:38 am    5:57 pm    6:18 am    5:17 pm    7:00 am    4:35 pm    11:48 am (17.2°)    91.712
29    7:40 am ↑ (125°)    3:56 pm ↑ (235°)    8:16:09    -2:15    5:39 am    5:57 pm    6:19 am    5:17 pm    7:01 am    4:35 pm    11:48 am (17.1°)    91.695
30    7:41 am ↑ (125°)    3:55 pm ↑ (235°)    8:13:59    -2:10    5:40 am    5:57 pm    6:20 am    5:16 pm    7:02 am    4:34 pm    11:49 am (16.9°)    91.679

December 2019
1     7:43 am ↑ (125°)    3:55 pm ↑ (235°)    8:11:53    -2:05    5:41 am    5:56 pm    6:22 am    5:16 pm    7:04 am    4:34 pm    11:49 am (16.8°)    91.664
2     7:44 am ↑ (126°)    3:54 pm ↑ (234°)    8:09:53    -2:00    5:42 am    5:56 pm    6:23 am    5:15 pm    7:05 am    4:33 pm    11:49 am (16.6°)    91.648
3     7:46 am ↑ (126°)    3:53 pm ↑ (234°)    8:07:57    -1:55    5:44 am    5:55 pm    6:24 am    5:15 pm    7:06 am    4:33 pm    11:50 am (16.5°)    91.633
4     7:47 am ↑ (126°)    3:53 pm ↑ (234°)    8:06:07    -1:50    5:45 am    5:55 pm    6:25 am    5:15 pm    7:08 am    4:32 pm    11:50 am (16.3°)    91.618
5     7:48 am ↑ (126°)    3:53 pm ↑ (234°)    8:04:22    -1:45    5:46 am    5:55 pm    6:26 am    5:14 pm    7:09 am    4:32 pm    11:50 am (16.2°)    91.604
6     7:49 am ↑ (127°)    3:52 pm ↑ (233°)    8:02:42    -1:39    5:47 am    5:55 pm    6:27 am    5:14 pm    7:10 am    4:32 pm    11:51 am (16.1°)    91.590
7     7:51 am ↑ (127°)    3:52 pm ↑ (233°)    8:01:08    -1:34    5:48 am    5:55 pm    6:28 am    5:14 pm    7:11 am    4:31 pm    11:51 am (15.9°)    91.577
8     7:52 am ↑ (127°)    3:51 pm ↑ (233°)    7:59:40    -1:28    5:49 am    5:54 pm    6:29 am    5:14 pm    7:12 am    4:31 pm    11:52 am (15.8°)    91.564
9     7:53 am ↑ (127°)    3:51 pm ↑ (233°)    7:58:17    -1:22    5:50 am    5:54 pm    6:30 am    5:14 pm    7:13 am    4:31 pm    11:52 am (15.7°)    91.552
10    7:54 am ↑ (127°)    3:51 pm ↑ (233°)    7:57:00    -1:16    5:51 am    5:54 pm    6:31 am    5:14 pm    7:14 am    4:31 pm    11:53 am (15.6°)    91.540
11    7:55 am ↑ (128°)    3:51 pm ↑ (232°)    7:55:50    -1:10    5:52 am    5:54 pm    6:32 am    5:14 pm    7:15 am    4:31 pm    11:53 am (15.6°)    91.528
12    7:56 am ↑ (128°)    3:51 pm ↑ (232°)    7:54:45    -1:04    5:52 am    5:54 pm    6:33 am    5:14 pm    7:16 am    4:31 pm    11:54 am (15.5°)    91.518
13    7:57 am ↑ (128°)    3:51 pm ↑ (232°)    7:53:46    -0:58    5:53 am    5:55 pm    6:34 am    5:14 pm    7:17 am    4:31 pm    11:54 am (15.4°)    91.507
14    7:58 am ↑ (128°)    3:51 pm ↑ (232°)    7:52:54    -0:52    5:54 am    5:55 pm    6:35 am    5:14 pm    7:18 am    4:31 pm    11:54 am (15.3°)    91.498
15    7:59 am ↑ (128°)    3:51 pm ↑ (232°)    7:52:07    -0:46    5:55 am    5:55 pm    6:36 am    5:14 pm    7:19 am    4:31 pm    11:55 am (15.3°)    91.489
16    8:00 am ↑ (128°)    3:51 pm ↑ (232°)    7:51:27    -0:39    5:56 am    5:55 pm    6:36 am    5:14 pm    7:19 am    4:31 pm    11:55 am (15.2°)    91.480
17    8:00 am ↑ (128°)    3:51 pm ↑ (232°)    7:50:54    -0:33    5:56 am    5:56 pm    6:37 am    5:15 pm    7:20 am    4:32 pm    11:56 am (15.2°)    91.472
18    8:01 am ↑ (128°)    3:52 pm ↑ (232°)    7:50:27    -0:27    5:57 am    5:56 pm    6:38 am    5:15 pm    7:21 am    4:32 pm    11:56 am (15.2°)    91.465
19    8:02 am ↑ (128°)    3:52 pm ↑ (232°)    7:50:06    -0:20    5:58 am    5:56 pm    6:38 am    5:15 pm    7:22 am    4:32 pm    11:57 am (15.1°)    91.458
20    8:02 am ↑ (128°)    3:52 pm ↑ (232°)    7:49:52    -0:14    5:58 am    5:57 pm    6:39 am    5:16 pm    7:22 am    4:33 pm    11:57 am (15.1°)    91.451
21    8:03 am ↑ (128°)    3:53 pm ↑ (232°)    7:49:44    -0:07    5:59 am    5:57 pm    6:40 am    5:16 pm    7:23 am    4:33 pm    11:58 am (15.1°)    91.445
22    8:04 am ↑ (128°)    3:53 pm ↑ (232°)    7:49:43    -0:01    5:59 am    5:58 pm    6:40 am    5:17 pm    7:23 am    4:34 pm    11:58 am (15.1°)    91.439
23    8:04 am ↑ (128°)    3:54 pm ↑ (232°)    7:49:48    +0:05    6:00 am    5:58 pm    6:41 am    5:17 pm    7:24 am    4:34 pm    11:59 am (15.1°)    91.434
24    8:04 am ↑ (128°)    3:54 pm ↑ (232°)    7:50:00    +0:11    6:00 am    5:59 pm    6:41 am    5:18 pm    7:24 am    4:35 pm    11:59 am (15.1°)    91.429
25    8:05 am ↑ (128°)    3:55 pm ↑ (232°)    7:50:19    +0:18    6:01 am    5:59 pm    6:41 am    5:19 pm    7:25 am    4:35 pm    12:00 pm (15.2°)    91.424
26    8:05 am ↑ (128°)    3:56 pm ↑ (232°)    7:50:44    +0:24    6:01 am    6:00 pm    6:42 am    5:19 pm    7:25 am    4:36 pm    12:00 pm (15.2°)    91.420
27    8:05 am ↑ (128°)    3:57 pm ↑ (232°)    7:51:15    +0:31    6:01 am    6:01 pm    6:42 am    5:20 pm    7:25 am    4:37 pm    12:01 pm (15.2°)    91.416
28    8:06 am ↑ (128°)    3:57 pm ↑ (232°)    7:51:53    +0:37    6:01 am    6:01 pm    6:42 am    5:21 pm    7:25 am    4:38 pm    12:01 pm (15.3°)    91.412
29    8:06 am ↑ (128°)    3:58 pm ↑ (232°)    7:52:37    +0:44    6:02 am    6:02 pm    6:42 am    5:21 pm    7:26 am    4:38 pm    12:02 pm (15.3°)    91.409
30    8:06 am ↑ (128°)    3:59 pm ↑ (232°)    7:53:27    +0:50    6:02 am    6:03 pm    6:43 am    5:22 pm    7:26 am    4:39 pm    12:02 pm (15.4°)    91.406
31    8:06 am ↑ (128°)    4:00 pm ↑ (232°)    7:54:24    +0:56    6:02 am    6:04 pm    6:43 am    5:23 pm    7:26 am    4:40 pm    12:03 pm (15.5°)    91.404
