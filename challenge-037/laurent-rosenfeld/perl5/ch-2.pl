#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub hrs2sec {
    my ($hrs, $min, $sec) = split /:/, shift;
    return $hrs * 3600 + $min * 60 + $sec;
}
sub sec2hrs {
    my $sec = shift;
    my $hrs = int $sec / 3600;
    $sec = $sec % 3600;
    my $min = int $sec / 60;
    $sec = $sec % 60;
    return sprintf "$hrs:%02d:%02d", $min, $sec;
}
my (@nov, @dec);
my $aref = \@nov;
while (<DATA>) {
    chomp;
    $aref = \@dec if /^Dec/;
    next unless /^\d/;
    my ($date, $duration) = (split /\s+/)[0, 3];
    $aref->[$date] = hrs2sec $duration;
}
my $total_diff;
say "Daylight change between:";
for my $i (1..30) {
    my $diff = $dec[$i] - $nov[$i];
    $total_diff += $diff;
    my $dif_hrs = sec2hrs abs $diff;
    $dif_hrs = "- $dif_hrs" if $diff < 0;
    printf "%02d Nov and %02d Dec: $dif_hrs\n", $i, $i;
}
say "Average change between Nov and Dec: ", $total_diff < 0 ? "- " : "", sec2hrs (abs $total_diff / 30);

__DATA__

    Sunrise Sunset  Length

Nov 2019

1   06h53   16h34   9:40:44
2   06h55   16h32   9:37:10
3   06h56   16h30   9:33:37
4   06h58   16h28   9:30:07
5   07h00   16h27   9:26:38
6   07h02   16h25   9:23:11
7   07h03   16h23   9:19:45
8   07h05   16h22   9:16:22
9   07h07   16h20   9:13:01
10  07h09   16h18   9:09:42
11  07h10   16h17   9:06:25
12  07h12   16h15   9:03:11
13  07h14   16h14   8:59:59
14  07h16   16h12   8:56:50
15  07h17   16h11   8:53:44
16  07h19   16h10   8:50:40
17  07h21   16h08   8:47:39
18  07h22   16h07   8:44:42
19  07h24   16h06   8:41:48
20  07h26   16h05   8:38:57
21  07h27   16h04   8:36:09
22  07h29   16h03   8:33:25
23  07h31   16h01   8:30:45
24  07h32   16h00   8:28:09
25  07h34   15h59   8:25:36
26  07h35   15h59   8:23:08
27  07h37   15h58   8:20:44
28  07h38   15h57   8:18:24
29  07h40   15h56   8:16:09
30  07h41   15h55   8:13:59

Dec 2019

1   07h43   15h55   8:11:53
2   07h44   15h54   8:09:53
3   07h46   15h53   8:07:57
4   07h47   15h53   8:06:07
5   07h48   15h53   8:04:22
6   07h49   15h52   8:02:42
7   07h51   15h52   8:01:08
8   07h52   15h51   7:59:40
9   07h53   15h51   7:58:17
10  07h54   15h51   7:57:00
11  07h55   15h51   7:55:50
12  07h56   15h51   7:54:45
13  07h57   15h51   7:53:46
14  07h58   15h51   7:52:54
15  07h59   15h51   7:52:07
16  08h00   15h51   7:51:27
17  08h00   15h51   7:50:54
18  08h01   15h52   7:50:27
19  08h02   15h52   7:50:06
20  08h02   15h52   7:49:52
21  08h03   15h53   7:49:44
22  08h04   15h53   7:49:43
23  08h04   15h54   7:49:48
24  08h04   15h54   7:50:00
25  08h05   15h55   7:50:19
26  08h05   15h56   7:50:44
27  08h05   15h57   7:51:15
28  08h06   15h57   7:51:53
29  08h06   15h58   7:52:37
30  08h06   15h59   7:53:27
31  08h06   16h00   7:54:24
