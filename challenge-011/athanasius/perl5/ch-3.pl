#!perl

################################################################################
=comment

Perl Weekly Challenge 011
=========================

Challenge #3
------------

Using [ https://openweathermap.org/current |Open Weather Map API], write a
script to fetch the current weather for an arbitrary city. Note that you will
need to sign up for Open Weather Map's free tier and then wait a couple hours
before your API key will be valid. This challenge was proposed by *Joelle
Maslak*. The API challenge is *optional* but would love to see your solution.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 Perlmonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use utf8;
use Const::Fast;
use DateTime;
use Getopt::Long;
use JSON;
use LWP::UserAgent ();

const my $API_KEY   =>  <redacted>;
const my $TIMEOUT   =>  30;     # seconds
const my $URL       => 'http://api.openweathermap.org/data/2.5/weather?q=';
const my $URL_ID    => 'http://api.openweathermap.org/data/2.5/weather?id=';
const my $S_PER_MIN =>  60;
const my $MIN_PER_H =>  60;
const my $S_PER_HR  =>  $S_PER_MIN * $MIN_PER_H;
const my $ABSZERO_C => -273.15;
const my $ABSZERO_F => -459.67;
const my $K_PER_F   =>  9 / 5;
const my $USAGE     => "\nUsage: perl $0 --city <string> --country <string>\n" .
                         "   or  perl $0 --city_id <positive integer>\n"       .
                         "   or  perl $0 --help\n";

$| = 1;

MAIN:
{
    my ($city_id, $city, $country, $help, $response);

    GetOptions
    (
        'city_id=i' => \$city_id,
        'city=s'    => \$city,
        'country=s' => \$country,
        'help'      => \$help,

    ) or die $USAGE;

    die $USAGE if $help ||
                !(defined $city_id || (defined $city && defined $country));

    $response = get_weather($city_id, $city, $country);

    if ($response->is_success)
    {
        report($city_id, $city, $country, $response);
    }
    else
    {
        die "\nError: ", $response->status_line, "\n";
    }
}

sub get_weather
{
    my ($city_id, $city, $country) = @_;

    my $url  =  defined($city_id) ? "$URL_ID$city_id" : "$URL$city,$country";
       $url .= "&APPID=$API_KEY";
    my $ua   =  LWP::UserAgent->new(timeout => $TIMEOUT);
    my $resp =  $ua->get($url);

    return $resp;
}

sub report
{
    my ($city_id, $city, $country, $response) = @_;

    my $json     = JSON->new->allow_nonref;
    my $weather  = $json->decode($response->{_content});
    my $location = defined($city_id) ? "city with ID $city_id" :
                                       "$city, $country";

    print "\nDetails of the current weather for $location:\n";

    report_location($weather);
    report_weather ($weather);
    report_temps   ($weather);
    report_snow    ($weather);
    report_rain    ($weather);
    report_wind    ($weather);
    report_pressure($weather);
    report_times   ($weather);
}

sub report_location
{
    my ($weather)  = @_;
    my  $city      = $weather->{name};
    my  $country   = $weather->{sys}{country};
    my  $id        = $weather->{id};
    my  $latitude  = $weather->{coord}{lat};
        $latitude  = sprintf "%.2f°%s", abs($latitude),
                             ($latitude  < 0 ? 'S' : 'N') if defined $latitude;
    my  $longitude = $weather->{coord}{lon};
        $longitude = sprintf "%.2f°%s", abs($longitude),
                             ($longitude < 0 ? 'W' : 'E') if defined $longitude;

    if (defined $city || defined $country || defined $id || defined $latitude ||
        defined $longitude)
    {
        print "\nLocation\n";
        printf  "  City:          %s\n", $city      // 'N/A';
        printf  "  Country code:  %s\n", $country   // 'N/A';
        printf  "  City ID:       %d\n", $id        // 'N/A';
        printf  "  Latitude:      %s\n", $latitude  // 'N/A';
        printf  "  Longitude:     %s\n", $longitude // 'N/A';
    }
}

sub report_weather
{
    my ($weather)    = @_;
    my  $description = $weather->{weather}[0]{description};
    my  $summary     = $weather->{weather}[0]{main};
        $summary    .= ' (' . $description .  ')'    if defined $summary &&
                                                        defined $description;
    my  $cloudiness  = $weather->{clouds}{all};
        $cloudiness .=                        '%'    if defined $cloudiness;
    my  $humidity    = $weather->{main}{humidity};
        $humidity   .=                        '%'    if defined $humidity;
    my  $visibility  = $weather->{visibility};
        $visibility  = commify($visibility) . ' m'   if defined $visibility;

    if (defined $summary || defined $cloudiness || defined $humidity ||
        defined $visibility)
    {
        print "\nWeather\n";
        printf  "  Summary:       %s\n", $summary    // 'N/A';
        printf  "  Cloudiness:    %s\n", $cloudiness // 'N/A';
        printf  "  Humidity:      %s\n", $humidity   // 'N/A';
        printf  "  Visibility:    %s\n", $visibility // 'N/A';
    }
}

sub report_temps
{
    my ($weather) = @_;

    my $min = $weather->{main}{temp_min};
       $min = sprintf("%2.0f°C (%.0f°F)", k2c($min), k2f($min)) if defined $min;
    my $max = $weather->{main}{temp_max};
       $max = sprintf("%2.0f°C (%.0f°F)", k2c($max), k2f($max)) if defined $max;
    my $cur = $weather->{main}{temp};
       $cur = sprintf("%2.0f°C (%.0f°F)", k2c($cur), k2f($cur)) if defined $cur;

    if (defined $min || defined $max || defined $cur)
    {
        print "\nTemperatures\n";
        printf  "  Minimum:       %s\n", $min // 'N/A';
        printf  "  Maximum:       %s\n", $max // 'N/A';
        printf  "  Current:       %s\n", $cur // 'N/A';
    }
}

sub report_snow
{
    my ($weather) = @_;
    my  $snow_1h  = $weather->{snow}{'1h'};
        $snow_1h .= ' mm' if defined $snow_1h;
    my  $snow_3h  = $weather->{snow}{'3h'};
        $snow_3h .= ' mm' if defined $snow_3h;

    if (defined $snow_1h || defined $snow_3h)
    {
        print "\nSnow\n";
        printf  "  Volume (1 hr): %s\n", $snow_1h // 'N/A';
        printf  "  Volume (3 hr): %s\n", $snow_3h // 'N/A';
    }
}

sub report_rain
{
    my ($weather) = @_;
    my  $rain_1h  = $weather->{rain}{'1h'};
        $rain_1h .= ' mm' if defined $rain_1h;
    my  $rain_3h  = $weather->{rain}{'3h'};
        $rain_3h .= ' mm' if defined $rain_3h;

    if (defined $rain_1h || defined $rain_3h)
    {
        print "\nRain\n";
        printf  "  Volume (1 hr): %s\n", $rain_1h // 'N/A';
        printf  "  Volume (3 hr): %s\n", $rain_3h // 'N/A';
    }
}

sub report_wind
{
    my ($weather)  = @_;
    my  $speed     = $weather->{wind}{speed};
        $speed     = sprintf("%.1f m/s", $speed)     if defined $speed;
    my  $direction = $weather->{wind}{deg};
        $direction = sprintf("%d°",      $direction) if defined $direction;

    if (defined $speed || defined $direction)
    {
        print "\nWind\n";
        printf  "  Speed:         %s\n", $speed     // 'N/A';
        printf  "  Direction:     %s\n", $direction // 'N/A';
    }
}

sub report_pressure
{
    my ($weather)   = @_;
    my  $pressure   = $weather->{main}{pressure};
        $pressure   = commify($pressure)   . ' hPa' if defined $pressure;
    my  $sea_level  = $weather->{main}{sea_level};
        $sea_level  = commify($sea_level)  . ' hPa' if defined $sea_level;
    my  $grnd_level = $weather->{main}{grnd_level};
        $grnd_level = commify($grnd_level) . ' hPa' if defined $grnd_level;

    if (defined $pressure  || defined $sea_level || defined $grnd_level)
    {
        print "\nAir pressure\n";
        printf  "  Sea level:     %s\n", $pressure   if defined $pressure;
        printf  "  Sea level:     %s\n", $sea_level  if defined $sea_level;
        printf  "  Ground level:  %s\n", $grnd_level if defined $grnd_level;
    }
}

sub report_times
{
    my ($weather) = @_;
    my  $seconds  = $weather->{timezone};
    my ($current, $sunrise, $sunset, $timezone);

    if (defined $seconds)
    {
        $timezone = DateTime::Duration->new(seconds => $seconds);
        $current  = DateTime->from_epoch(epoch => $weather->{dt});

        if (defined $current)
        {
            $current->add_duration($timezone);
            $current = $current->hms . ', ' . $current->ymd;
        }

        $sunrise = DateTime->from_epoch(epoch => $weather->{sys}{sunrise});

        if (defined $sunrise)
        {
            $sunrise->add_duration($timezone);
            $sunrise = $sunrise->hms . ', ' . $sunrise->ymd;
        }

        $sunset  = DateTime->from_epoch(epoch => $weather->{sys}{sunset});

        if (defined $sunset)
        {
            $sunset->add_duration($timezone);
            $sunset = $sunset->hms . ', ' . $sunset->ymd;
        }

        my $hours    = abs int ($seconds / $S_PER_HR);
        my $minutes  = abs int(($seconds % $S_PER_HR) / $S_PER_MIN);
           $timezone = sprintf "UTC%s%02d:%02d", (($seconds < 0) ? '-' : '+'),
                                $hours, $minutes;
    }

    if (defined $timezone || defined $current || defined $sunrise ||
        defined $sunset)
    {
        print "\nTimes (local)\n";
        printf  "  Timezone:      %s\n", $timezone // 'N/A';
        printf  "  Current:       %s\n", $current  // 'N/A';
        printf  "  Sunrise:       %s\n", $sunrise  // 'N/A';
        printf  "  Sunset:        %s\n", $sunset   // 'N/A';
    }
}

# Convert temperature in Kelvin to degrees Celsius

sub k2c
{
    my ($kelvin) = @_;

    return $kelvin + $ABSZERO_C;
}

# Convert temperature in Kelvin to degrees Fahranheit

sub k2f
{
    my ($kelvin) = @_;

    return ($kelvin * $K_PER_F) + $ABSZERO_F;
}

# Separate groups of 3 digits (in the integer part of a number) with commas

sub commify
{
    my ($string) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $string =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/gr;
}

################################################################################
