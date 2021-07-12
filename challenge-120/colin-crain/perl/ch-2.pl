#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       what-angle-we-at.pl
#
#       Clock Angle
#         Submitted by: Mohammad S Anwar
#         You are given time $T in the format hh:mm.
# 
#         Write a script to find the smaller angle formed by the hands of an
#         analog clock at a given time.
# 
#         HINT: A analog clock is divided up into 12 sectors. One sector
#         represents 30 degree (360/12 = 30).
# 
#         Example
#         Input: $T = '03:10'
#         Output: 35 degree
# 
#         The distance between the 2 and the 3 on the clock is 30 degree.
#         For the 10 minutes i.e. 1/6 of an hour that have passed.
#         The hour hand has also moved 1/6 of the distance between the 3 and the
#         4, which adds 5 degree (1/6 of 30).
#         The total measure of the angle is 35 degree.
# 
#         Input: $T = '04:00'
#         Output: 120 degree

#         method:
#             Rolex wristwatches are known for their "sweep" second hand
#             movement; that is to say the hand does not move incrementally,
#             once a second, from one pip to the next, but rather is seen to
#             move in a continuous flow around the dial. This action is
#             remarkably difficult to achieve in a mechanical movement where the
#             fundamental timekeeping period is based on an oscillating
#             vibration, such as a pendulum. In fact it is ultimately
#             illusionary, based on a rapidly moving pendulum buffered by
#             springs to appear more fluid.
# 
#             With the introduction of inexpensive, accurate electric motors
#             much of the panache of the sweep hand has gone away, and the Rolex
#             has had to rely more on its rugged good looks and maybe the notion that
#             it's body is machined from a giant block of gold. But I digress.
#             In a pendulum-driven clock movement the action is commonly
#             designed to move with a two-second period: one across, and one
#             back. This can be precisely tuned by adjusting the length of the
#             pendulum arm, and forms the basis of all the timekeeping: each
#             half-swing is one tick, 60 of these comprise a minute, and three
#             thouand six hundred to an hour.
# 
#             It's not hard to make a clock with a sweep minute hand, where the
#             hand makes one revolution per hour in as many increments as the
#             pendulum allows. But this is not always advantagous: in a clock
#             without a second hand, such as one would find in a clock-tower,
#             having the minute hand fall between marks leads to ambiguity in
#             reading. One person may see 43 minutes past the hour, another 42.
#             It is often more desirable to have an intenal mechanism rachet
#             along counting pendulum swings on a gear, and only once a
#             revolution have a pin engage a mechanism and move the minute hand
#             one place. In this way the clock hand stays at 42 until the moment
#             arrives, when in moves all at onece to 43 and remains for another
#             minute until it moves again.
# 
#             On the other, other hand, no mechanical clock does this for the hour
#             hand. We go about our day and normally deal with time in a finer
#             granularity than the hour, and hence knowing that it's somewhere
#             between 1 and 2 is useful information in itself to know.
# 
#             So ignoring the second hand, in just the hours and minutes of many 
#             common clocks we have
#             two modes of moving the hand: continuous and discrete. With
#             respect to an angle swept from midnight or noon, the minute hand
#             will have moved six degrees every minute, always. As without 
#             further information we have no
#             idea how many seconds have elapsed since the last minute tick
#             we cannot improve on this
#             calculation even if we wanted to.
# 
#             For the hours, back to one of our previous other hands,
#             the hand moves a set amount for
#             each hour, but also takes a submovement between the pips based on
#             dividing the interval between two hour points into 60 minutes. The
#             final sweep amount for the hand at any given time will be the sum
#             of the two partial motions. 
            
            
            
            
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my $timestr = shift // qw ( 9:49);

my ($h, $m) = $timestr =~ /(\d?\d):(\d\d)/;
$h %= 12;
my $mdeg = $m * 6;
my $hdeg = $h * 30 + $m * 0.5;
my $ang = abs( $hdeg - $mdeg );
$ang = 360 - $ang if $ang > 180;

say "time: $timestr";
say "$ang degrees";

