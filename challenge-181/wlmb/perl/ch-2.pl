#!/usr/bin/env perl
# Perl weekly challenge 181
# Task 2: Hot day
#
# See https://wlmb.github.io/2022/09/05/PWC181/#task-2-hot-day
use v5.36;
use List::MoreUtils qw(pairwise);
use Date::Parse;
use DateTime;

my %temps;
while(<>){ # Input data from standard input in format YYYY-MM-DD, Temp
    chomp;
    my ($date, $temp)=split ", ";
    $temps{$date}=$temp;
}
my %datetimes;
for(keys %temps){ # check valid dates
    die "Wrong date $_" unless defined (my $time=str2time($_));
    $datetimes{$_}=DateTime->from_epoch($time); # Build DateTime object
}
my @sorted=sort {DateTime->compare($datetimes{$a}, $datetimes{$b})} keys %temps;
for(1..@sorted-1){
    die "Dates not consecutive"
        unless $datetimes{$sorted[$_]}->delta_days($datetimes{$sorted[$_-1]})->days==1;
    say $sorted[$_] if $temps{$sorted[$_]}>$temps{$sorted[$_-1]}
}
