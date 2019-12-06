## Please see file perltidy.ERR
#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Perl weekly challenge 37 task 2
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (),
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 12/06/2019 04:49:02 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use DateTime::Event::Sunrise;

my $sun_London = DateTime::Event::Sunrise->new( longitude => -0.118092, latitude => +51.509865 );

my $diff;

for my $day ( 1 .. 30 ) {
    # there is no 31.11...
     my $dt_nov = DateTime->new(year      => 2019,
                                 month     =>    11,
                                 day       =>   $day,
                                 time_zone => 'Europe/London');

     my $dt_dec = DateTime->new(year      => 2019,
                                 month     =>    12,
                                 day       =>   $day,
                                 time_zone => 'Europe/London');

	my $daylight_nov =  $sun_London->sunset_datetime ($dt_nov)->epoch - $sun_London->sunrise_datetime($dt_nov)->epoch;

   	my $daylight_dec =  $sun_London->sunset_datetime ($dt_dec)->epoch - $sun_London->sunrise_datetime($dt_dec)->epoch;                                
	
	$diff += ($daylight_dec-$daylight_nov)/3600;

}

say "$diff hours";
