#!/usr/bin/perl
use warnings;
use strict;

use Text::CSV_XS;

sub format_time {
    my ($ms) = @_;
    my $seconds = int($ms / 1000);
    my $minutes = int($seconds / 60);
    $seconds %= 60;
    my $hours = int($minutes / 60);
    $minutes %= 60;
    return sprintf "%02d:%02d:%02d", $hours, $minutes, $seconds
}

sub what's_playing {
    my ($start_time, $current_time, $file) = @_;
    my @media;

    my $csv = 'Text::CSV_XS'->new({binary => 1, auto_diag => 1});
    open my $in, '<:encoding(UTF-8)', $file or die $!;
    my $sum = 0;
    while (my $row = $csv->getline($in)) {
        $row->[0] += $sum;
        push @media, $row;
        $sum = $row->[0];
    }

    my $i = 0;
    my $time = 1000 * ($current_time - $start_time) % $sum;
    ++$i while $media[$i][0] <= $time;
    return [$media[$i][1],
            format_time($i ? $time - $media[ $i - 1 ][0] : $time)]
}

use Test::More tests => 6;

my $input = << '__INPUT__';
1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"
__INPUT__

is_deeply what's_playing(1606134123, 1614591276, \$input),
    ['Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)',
     '00:10:24'],
    'Example';

is_deeply what's_playing(10, 21, \$input),
    ['Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)',
     '00:00:11'],
    'Beginning';

is_deeply what's_playing(0, 11910604 + 11910603, \$input),
    ['Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)',
     '00:28:33'],
    'End of the 2nd cycle';

my $input_long = << '__INPUT__';
3600000,"One hour"
7200000,"Two hours"
600000,"Ten minutes"
__INPUT__

is_deeply what's_playing(0, 3600, \$input_long),
    ['Two hours', '00:00:00'],
    'Start of the 2nd track';

is_deeply what's_playing(0, 10799, \$input_long),
    ['Two hours', '01:59:59'],
    'One sec before the 3rd track';

is_deeply what's_playing(0, 125_340, \$input_long),
    ['Ten minutes', '00:09:00'],
    'Nine minutes into the 3rd track, 11th cycle';
