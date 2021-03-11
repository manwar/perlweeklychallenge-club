#!/usr/bin/perl
# The Weekly Challenge #103 Task 2
# What’s playing?
use strict;
use warnings;
use Text::CSV_XS qw/csv/;


chomp(my $start_time = <STDIN>);
chomp(my $current_time = <STDIN>);
chomp(my $file_name = <STDIN>);

my $playlist = csv (in => $file_name, sep_char => ",");

my $num_of_audio = scalar @{$playlist};
my @audio_pt = (0);
for my $i (1 .. $num_of_audio - 1) {
    $audio_pt[$i] = $audio_pt[$i-1] + $playlist->[$i-1]->[0];
}

my $tot_audio_length = 0;
for my $i (0 .. $num_of_audio - 1) {
    $tot_audio_length += $playlist->[$i]->[0];
}


my $seek_time = (1000*($current_time-$start_time)) % ($tot_audio_length) ;

my $ind = 0;
while ($audio_pt[$ind] <= $seek_time) {$ind++;} 
$ind--;


print $playlist->[$ind]->[1], "\n";
print format_time($seek_time - $audio_pt[$ind]), "\n";


sub format_time {
    my $t = int ($_[0]/1000);
    my $hr = int ($t / 3600);
    $t = $t - $hr*3600;
    my $min = int ($t / 60);
    $t = $t - $min * 60;
    my $sec = int ($t);
    $hr = addzeroifn($hr);
    $min = addzeroifn($min);
    $sec = addzeroifn($sec);

    return "$hr:$min:$sec"; 
}

sub addzeroifn {
    return "00" if $_[0] =~ /^0$/;
    return "0$_[0]" if $_[0] =~ /^\d$/;
    return $_[0];
}
