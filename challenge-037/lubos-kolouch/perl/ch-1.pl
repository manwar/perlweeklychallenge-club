#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Weekdays in each month of 2019

=head1 SYNOPSIS

  perl ch-1.pl        # runs embedded tests and prints the month counts

=head1 DESCRIPTION

Calculate the number of weekdays (Mon-Fri) for each month in 2019.

=cut

use Time::Piece;
use Time::Seconds qw(ONE_DAY);

sub weekday_counts_2019 () {
    my %count = map { $_ => 0 } qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

    my $d = Time::Piece->strptime( '2019-01-01', '%Y-%m-%d' );
    while ( $d->year == 2019 ) {
        my $wday = $d->_wday;    # 0=Sun ... 6=Sat
        if ( $wday >= 1 && $wday <= 5 ) {
            ++$count{ $d->strftime('%b') };
        }
        $d += ONE_DAY;
    }

    return \%count;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $c = weekday_counts_2019();
    my %expected = (
        Jan => 23, Feb => 20, Mar => 21, Apr => 22, May => 23, Jun => 20,
        Jul => 23, Aug => 22, Sep => 21, Oct => 23, Nov => 21, Dec => 22,
    );
    Test::More::is_deeply( $c, \%expected, 'Official month counts for 2019' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    die "Run without arguments.\n" if @args;
    _run_tests();

    my $c = weekday_counts_2019();
    say "$_: $c->{$_} days" for qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
}

_run_cli(@ARGV);

