#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
#       -- Dave Rolsky

# Time is broken.

use Carp;
use DateTime;
use DateTime::Calendar::Chinese
    ;    # which requires DateTime::Astro, which requires MPFR or won't build

# we can specify a specific year, or we can get a whole cycle
my ($year) = @ARGV;
if ( defined $year ) {
    croak 'Not A Year' unless $year !~ /\D/;
    my ( $year, $animal, $branch, $stem, $name, $element ) =
        chinese_zodiac($year);
    say join " ", "\t", $year, "\t", $element, $animal;
}

else {
    # Show The Current Cycle
    for my $y ( 1984 .. 2043 ) {
        my ( $year, $animal, $branch, $stem, $name, $element ) =
            chinese_zodiac($y);
        say join " ", "\t", $year, "\t", $element, $animal;
    }
}
exit;

sub chinese_zodiac ( $greg_year ) {

    # there is a problem I'm ignoring here.

    # chinese new year is not bound specifically to a point in the
    # planet's orbit around the local star. it floats, and occurs
    # somewhere between mid-January and mid-February by the Gregorian
    # calendar.

    # this means that, if run on Jan 2 2021, we MIGHT expect to see
    # that it's Metal Ox, but it was still Metal Rat (which is the
    # name of an effects pedal from ProCo, IIRC, and implies a series
    # of SF novels from Harry Harrison).

    # this code *should* respect the truth and not the failed expectations
    # of the user, but any code that goes from first principles would
    # likely blow it for about the first month of the year

    my $dt = DateTime->now();
    $dt->set_year($greg_year);
    my $chdt = DateTime::Calendar::Chinese->from_object( object => $dt );
    $chdt->set_time_zone("Asia/Hong_Kong");

    my $animal  = ucfirst $chdt->zodiac_animal;
    my $branch  = ucfirst $chdt->terrestrial_branch_py;
    my $stem    = ucfirst $chdt->celestial_stem_py;
    my $name    = ucfirst $chdt->year_name_py;
    my $element = translate_element($stem);
    return $greg_year, $animal, $branch, $stem, $name, $element;
}

sub translate_element ( $stem ) {

    # There's also Yin and Yang, which we were not
    # told to identify, but explains the two results
    # in the following hash

    # Wood, Fire, Earth, Metal, Water
    my %elements = (
        Jia3  => 'Wood',
        Yi3   => 'Wood',
        Bing3 => 'Fire',
        Ding1 => 'Fire',
        Ji3   => 'Earth',
        Wu4   => 'Earth',
        Geng1 => 'Metal',
        Xin1  => 'Metal',
        Gui3  => 'Water',
        Ren2  => 'Water',
    );
    return $elements{$stem};
}

