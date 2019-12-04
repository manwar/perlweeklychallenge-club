#!/usr/bin/env perl

# ch-2.pl - Daylight comparison from Nov to Dec 2019
#           Went a little over-spec on this one. :-)
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Getopt::Long;
use Astro::Sunrise;
use List::Util qw< all sum >;
use Pod::Usage;

# Defaults
my %o = (
    lat     => 51.5074,     # London
    lon     => -0.1278,
    tz      =>  0,          # GMT
    dst     =>  0,
    precise =>  1,
    polar   => 'retval',    # No Astro::Sunrise warnings in polar regions
    help    => sub { pod2usage( -verbose => 2 ) },
);
GetOptions( \%o, qw< lat=f lon|long=f alt=f tz=i precise! dst help > )
    or pod2usage(2);
delete $o{help};

# Parse and validate the yyyy-mm arguments
pod2usage('Expecting two yyyy-mm dates') if @ARGV != 2;
pod2usage('yyyy-mm format required') unless all { /^\d+\-\d\d?$/ } @ARGV;
my ($year1, $month1) = split '-', $ARGV[0];
my ($year2, $month2) = split '-', $ARGV[1];
pod2usage('Month must be 1..12') if $month1 < 1 or $month1 > 12 
                                 or $month2 < 1 or $month2 > 12;

# Calculate and display difference in daylight between months
say daylight_month(year => $year1, month => $month1, %o) 
  - daylight_month(year => $year2, month => $month2, %o);


# Sum up total daylight minutes in a given month
sub daylight_month {
    my %args = @_;

    sum map {
        my ($rise, $set) = sunrise( { %args, day => $_ } );
        ($rise,$set) = ('00:00', '24:00') if $rise eq 'day';
        ($rise,$set) = ('00:00', '00:00') if $rise eq 'night';

        my ($rise_hh, $rise_mm) = split ':', $rise;
        my ( $set_hh,  $set_mm) = split ':', $set;

        $set_hh * 60 + $set_mm - ( $rise_hh * 60 + $rise_mm );
    } 1 .. days_in( $args{year}, $args{month} );
}

# Return the number of days in the given month (with year specified so
# we can check if it is a leap year)
sub days_in {
    my ($y, $m) = @_;
    my @days = (undef, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    $days[2]++ if leap_year($y);
    $days[$m];
}

# Return true if year is a leap year
sub leap_year {
    my $y = shift;
    return 1 unless $y % 400;
    return 0 unless $y % 100;
    return 1 unless $y % 4;
    return 0;
}

__END__

=head1 SYNOPSIS

    ch-2.pl
        [--lat=<DEG> --long=<DEG>] 
        [--tz=<OFS> ] [--dst]
        [--alt=<DEG>]
        [--noprecise]
        [--help]
        yyyy-mm yyyy-mm

Examples:

    ch-2.pl --lat=40.7128 --long=-74.0060 1999-01 2019-01 # NY

    ch-2.pl 2019-11 2019-12 # London, challenge-037 parameters

=head1 OPTIONS SUMMARY

    --lat=<DEG>     Latitude, in degrees        Default: 51.5074
    --long=<DEG>    Longitude, in degrees       Default:  0.1278
    --tz=<OFS>      Timezone, offset from GMT   Default:  0
    --alt=<DEG>     Altitude of sun in degrees  Default: -0.8333
    --dst           Use Daylight Savings Time   Default:   False

=head1 DESCRIPTION

F<ch-2.pl> calculates the difference in daylight between two different months
(specified by C<yyyy-mm> arguments), for a given location in the world. We can
optionally correct for Daylight Savings Time.

=head1 OPTIONS

=over 4

=item --lat=<DEG>

=item --long=<DEG>

Latitude and longitude in degrees North and East, respectively. For South or
West coordinates, use negative values.

=item --tz=<OFS>

The timezone to use, as an offset from GMT.

=item --noprecise

Use a quick calculation for the sunrise and sunset times, rather than the
slower, more precise default. In most cases the calculation will differ by
a few minutes.

=item --alt=<DEG>

The altitude of the sun, in decimal degrees. This setting can be used to
achieve the various nautical, astronomical, and civil "sunset" definitions
in use.

By default, we use -0.833 degrees, which is when the sun's upper limb touches
the mathematical horizon, accounting for atmospheric refraction.

=back

=head1 POLAR LOCATIONS

Locations around the North and South pole experience complete daylight or
complete darkness for many consecutive days in summer and winter. This script
handles these cases by considering the day to be 24 hours of daylight or
darkness, accordingly.

=head1 SEE ALSO

=over 4

=item L<Astro::Sunrise>

The C<perldoc> documentation for C<Astro::Sunrise> explains many of these
options in more detail.

=back

=head1 AUTHOR

B<Ryan Thompson> E<lt>rjt@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Ryan Thompson

This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

L<http://dev.perl.org/licenses/artistic.html>
