#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Problem: A guest house had a policy that the light remain ON as long as the at least one guest is in the house. 
# There is guest book which tracks all guest in/out time. Write a script to find out how long in minutes the light were ON.

# Solution: Instead of just totaling records from a database, I wanted to create an Internet-of-Things "object" with an ON/OFF state and running meter.
# It will solve the problem, but since it's a live meter, that ticks off the seconds, it has to run from 9:10AM to 11:00AM to calculate the problem total

use constant {
	ON  => 1,
	OFF => 0,
};

my $guest_book_data = {
	Alex 	=> {IN=> '09:10', OUT=>'09:45'},
	Arnold 	=> {IN=> '09:15', OUT=>'09:33'},
	Bob 	=> {IN=> '09:22', OUT=>'09:55'},
	Charlie => {IN=> '09:25', OUT=>'10:05'},
	Steve 	=> {IN=> '09:33', OUT=>'10:01'},
	Roger  	=> {IN=> '09:44', OUT=>'10:12'},
	David 	=> {IN=> '09:57', OUT=>'10:23'},
	Neil  	=> {IN=> '10:01', OUT=>'10:19'},
	Chris 	=> {IN=> '10:10', OUT=>'11:00'},
};

# instead of waiting 21 hours to see the solution, I added 3 hrs to the table and kicked it off. See output below  
my $guest_book_plus_3hr = {
	Alex 	=> {IN=> '12:10', OUT=>'12:45'},
	Arnold 	=> {IN=> '12:15', OUT=>'12:33'},
	Bob 	=> {IN=> '12:22', OUT=>'12:55'},
	Charlie => {IN=> '12:25', OUT=>'13:05'},
	Steve 	=> {IN=> '12:33', OUT=>'13:01'},
	Roger  	=> {IN=> '12:44', OUT=>'13:12'},
	David 	=> {IN=> '12:57', OUT=>'13:23'},
	Neil  	=> {IN=> '13:01', OUT=>'13:19'},
	Chris 	=> {IN=> '13:10', OUT=>'14:00'},
};

my $guest_book = $guest_book_plus_3hr; 

# Our LIGHT and GUEST "objects"
my $LIGHT = {
	created_at => time(),
	state      => OFF, # Hotel light state on/off
	meter      => 0, # total time on, in seconds
};
my $GUEST = 0;
my $guest_count = $GUEST;

# convert the guest book data into a live stream in the array @guest;
my @guest;
foreach (keys %$guest_book) {
	my $href = $guest_book->{$_};
	push @guest, "$href->{IN} IN $_";
	push @guest, "$href->{OUT} OUT $_";
}
@guest = sort(@guest);
say join(', ',@guest);

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
printf("Time now is: %02d:%02d:%02d\n", $hour, $min, $sec);
say "Light object created at: " . $LIGHT->{created_at};

# loop forever, controlling light, displaying it's meter and announcing guest arrival/departures
$| = 1;
while (1) {
	hotel_check_in_out();

	$LIGHT->{state} = ON  if ($GUEST >= 1 and $LIGHT->{state} == OFF);
	$LIGHT->{state} = OFF if ($GUEST == 0 and $LIGHT->{state} == ON);
	$LIGHT->{meter}++ if ($GUEST);

	my $light = $LIGHT->{state} ? 'ON ' : 'OFF';
	my @time = gmtime($LIGHT->{meter});
	printf ("\rLight meter: %4d days %4d hours %4d mins %4d secs. Total Guests: $GUEST. Light is $light " , @time[7,2,1,0]);
}

sub hotel_check_in_out {
	return unless (@guest); # instead of a fixed array this could be an MQTT message or some other feed

	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
	$hour = sprintf "%02d", $hour;
	$min  = sprintf "%02d", $min;
	my ($time,$IO,$g) = split(/ /,$guest[0]);
	#say "$hour:$min $time";
	if ("$hour:$min" eq $time) {
		shift @guest;
		$GUEST += ($IO eq 'IN') ? 1 : -1;
		printf("\n\nNew Arrival: $g at %02d:%02d:%02d\n", $hour, $min, $sec)     if ($GUEST > $guest_count);
		printf("\n\nGuest Departure: $g at %02d:%02d:%02d\n", $hour, $min, $sec) if ($GUEST < $guest_count);
		$guest_count = $GUEST;
	}
	sleep 1;
}

__END__

12:10 IN Alex, 12:15 IN Arnold, 12:22 IN Bob, 12:25 IN Charlie, 12:33 IN Steve, 12:33 OUT Arnold, 12:44 IN Roger, 12:45 OUT Alex, 12:55 OUT Bob, 12:57 IN David, 13:01 IN Neil, 13:01 OUT Steve, 13:05 OUT Charlie, 13:10 IN Chris, 13:12 OUT Roger, 13:19 OUT Neil, 13:23 OUT David, 14:00 OUT Chris
Time now is: 11:27:47
Light object created at: 1576776467
Light meter:    0 days    0 hours    0 mins    0 secs. Total Guests: 0. Light is OFF

New Arrival: Alex at 12:10:00
Light meter:    0 days    0 hours    5 mins    0 secs. Total Guests: 1. Light is ON

New Arrival: Arnold at 12:15:00
Light meter:    0 days    0 hours   12 mins    0 secs. Total Guests: 2. Light is ON

New Arrival: Bob at 12:22:00
Light meter:    0 days    0 hours   15 mins    0 secs. Total Guests: 3. Light is ON

New Arrival: Charlie at 12:25:00
Light meter:    0 days    0 hours   23 mins    0 secs. Total Guests: 4. Light is ON

New Arrival: Steve at 12:33:00
Light meter:    0 days    0 hours   23 mins    0 secs. Total Guests: 5. Light is ON

Guest Departure: Arnold at 12:33:01
Light meter:    0 days    0 hours   34 mins    0 secs. Total Guests: 4. Light is ON

New Arrival: Roger at 12:44:00
Light meter:    0 days    0 hours   35 mins    0 secs. Total Guests: 5. Light is ON

Guest Departure: Alex at 12:45:00
Light meter:    0 days    0 hours   45 mins    0 secs. Total Guests: 4. Light is ON

Guest Departure: Bob at 12:55:00
Light meter:    0 days    0 hours   47 mins    0 secs. Total Guests: 3. Light is ON

New Arrival: David at 12:57:00
Light meter:    0 days    0 hours   51 mins    0 secs. Total Guests: 4. Light is ON

New Arrival: Neil at 13:01:00
Light meter:    0 days    0 hours   51 mins    0 secs. Total Guests: 5. Light is ON

Guest Departure: Steve at 13:01:01
Light meter:    0 days    0 hours   55 mins    0 secs. Total Guests: 4. Light is ON

Guest Departure: Charlie at 13:05:00
Light meter:    0 days    0 hours   60 mins    0 secs. Total Guests: 3. Light is ON

New Arrival: Chris at 13:10:00
Light meter:    0 days    1 hours    2 mins    0 secs. Total Guests: 4. Light is ON

Guest Departure: Roger at 13:12:00
Light meter:    0 days    1 hours    9 mins    0 secs. Total Guests: 3. Light is ON

Guest Departure: Neil at 13:19:00
Light meter:    0 days    1 hours   13 mins    0 secs. Total Guests: 2. Light is ON

Guest Departure: David at 13:23:00
Light meter:    0 days    1 hours   50 mins    0 secs. Total Guests: 1. Light is ON

Guest Departure: Chris at 14:00:00
Light meter:    0 days    1 hours   50 mins    0 secs. Total Guests: 0. Light is OFF

