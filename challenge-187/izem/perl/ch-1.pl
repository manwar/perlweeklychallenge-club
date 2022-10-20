
=head1

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #1: Days Together

    Two friends, Foo and Bar gone on holidays seperately to the same city.
    You are given their schedule i.e. 'start date' and 'end date'.
    To keep the task simple, the date is in the form 'DD-MM' and all dates
    belong to the same calendar year i.e. between '01-01' and '31-12'. Also
    the year is 'non-leap year'. Also both dates are inclusive.
    Write a script to find out for the given schedule, how many days they
    spent together in the city, if at all.

=cut

use strict;
use warnings;
use feature 'say';

use POSIX      qw(strftime mktime);
use List::Util qw(min max);
use Test::More;
use Data::Dumper;

my $NONE_LEAP_YEAR = 2022 - 1900;
$Data::Dumper::Indent = 0;

my @cases = (
    {
        'args' => [
            { SD => '12-01', ED => '20-01' }, { SD => '15-01', ED => '18-01' }
        ],
        'expected' => 4
    },
    {
        'args' => [
            { SD => '02-03', ED => '12-03' }, { SD => '13-03', ED => '14-03' }
        ],
        'expected' => 0
    },
    {
        'args' => [
            { SD => '02-03', ED => '12-03' }, { SD => '11-03', ED => '15-03' }
        ],
        'expected' => 2
    },
    {
        'args' => [
            { SD => '30-03', ED => '05-04' }, { SD => '28-03', ED => '02-04' }
        ],
        'expected' => 4
    },
);

for my $case (@cases) {
    cmp_ok( daysTogether( @{ $case->{'args'} } ),
        '==', $case->{'expected'}, Dumper( $case->{'args'} ) );
}

done_testing( scalar @cases );

sub toDayOfYear {
    my ($date) = @_;
    my ( $day, $mon ) = $date =~ /^(\d\d)-(\d\d)$/;
    ( $day, $mon ) = ( int($day), int($mon) - 1 );
    return int(
        strftime(
            "%j", localtime( mktime( 0, 0, 0, $day, $mon, $NONE_LEAP_YEAR ) )
        )
    );
}

sub daysTogether {
    my ( $foo, $bar ) = @_;
    my ( $foo_sd, $foo_ed ) =
      ( toDayOfYear( $foo->{SD} ), toDayOfYear( $foo->{ED} ) );
    my ( $bar_sd, $bar_ed ) =
      ( toDayOfYear( $bar->{SD} ), toDayOfYear( $bar->{ED} ) );
    if ( $foo_sd > $bar_ed || $foo_ed < $bar_sd ) {
        return 0;
    }

    return min( $foo_ed, $bar_ed ) - max( $foo_sd, $bar_sd ) + 1;
}
