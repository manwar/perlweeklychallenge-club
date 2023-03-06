# The Weekly Challenge 206
# Task 1 Shortest Time
use v5.30.0;
use warnings;
use List::MoreUtils qw/slide/;
use List::Util qw/min/;

sub st {
    my @arr = map { hhmm_to_min($_) } @_; 
    @arr = sort {$a <=> $b} @arr;
    my @diff = slide {$b-$a} @arr;
    push @diff, $arr[0]+24*60-$arr[-1];
    return min @diff;
}

sub hhmm_to_min {
    my ($h, $m) = split ":", $_;
    ($h, $m) = map { substr($_, 0, 1) eq "0"
                     ? substr($_, 1, 1)
                     : $_ } ($h, $m);
    return $h*60+$m;
}

use Test::More tests => 3;
ok st("00:00", "23:55", "20:00") == 5;
ok st("01:01", "00:50", "00:57") == 4;
ok st("10:10", "09:30", "09:00", "09:55") == 15;
