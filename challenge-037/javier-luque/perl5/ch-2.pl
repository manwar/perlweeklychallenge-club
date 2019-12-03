#!/usr/bin/perl
# Test: ./ch2.pl
use strict;
use warnings;
use URI;
use Web::Scraper;
use feature qw /say/;
use String::Util qw /trim/;
use DateTime;
use Time::Seconds;

my $nov = DateTime->new(
    year  => 2019,
    month => 11,
    day   => 1
);

my $dec = DateTime->new(
    year  => 2019,
    month => 12,
    day   => 1
);

compare_lengths($nov, $dec);

# Compare the daylight lengths of 2 months
sub compare_lengths {
    my ($date1, $date2) = @_;

    # Get the data from the web
    my $date1_data =
        get_data($date1->month, $date1->year);
    my $date2_data =
        get_data($date2->month, $date2->year);

    # Calculate totals
    my $date1_total = calculate_daylight_total($date1_data);
    my $date2_total = calculate_daylight_total($date2_data);
    my $difference = $date1_total - $date2_total;

    # Print the output
    say $date1->month_abbr . ' ' . $date1->year . ' has ' .
        Time::Seconds->new($date1_total)->pretty .
        ' of daylight.';

    say $date2->month_abbr . ' ' . $date2->year . ' has ' .
        Time::Seconds->new($date1_total)->pretty .
        ' of daylight.';

    say "The difference is: " .
        Time::Seconds->new($difference)->pretty . '.';
}

# Calculates the total daylight hours from data
sub calculate_daylight_total {
    my ($data) = @_;
    my $total = 0;

    for my $time_string (@{$data}) {
        $total += convert_time_to_seconds($time_string);
    }

    return $total;
}

# Convert hh::mm::ss to seconds
sub convert_time_to_seconds {
    my ($hh, $mm, $ss) = split(':', shift);
    return $hh * 3600 + $mm * 60 + 60;
}

# Get the data from the web
sub get_data {
    my ($month, $year) = @_;
    my @data;

    # Scrape the date
    my $url = 'https://www.timeanddate.com/sun/uk/london?' .
        "month=$month&year=$year";

    my $times = scraper {
        process 'table[id="as-monthsun"] td', "times[]" => {
            td_text => 'TEXT',
        }
    };

    my $res = $times->scrape( URI->new( $url ) );

    # Parse the times
    for my $time (@{$res->{times}}) {
        my $e_time = trim($time->{td_text});
        push @data, $e_time
            if ($e_time =~ /^(\d)+\:(\d)+\:(\d)+$/);
    }

    # Output the data
    return \@data;
}
