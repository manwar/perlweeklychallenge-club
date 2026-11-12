#!/usr/bin/env perl
use v5.38;
use warnings;
use Time::Piece;
use Time::Seconds qw(ONE_DAY);
use Type::Params -sigs;
use Types::Standard qw(Str Int ArrayRef Optional);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Banking Day Offset (The Weekly Challenge 259 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 2018-06-28 3 2018-07-03
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a start date and offset counter. Optionally you also get a bank holiday date list.

Given a number (of days) and a start date, return the date adjusted to take into
account non-banking days (weekends and bank holidays).

=head1 FUNCTIONS

=head2 banking_day_offset($start_date, $offset, $bank_holidays)

Calculates the target date by advancing C<$offset> banking days from C<$start_date>,
skipping weekends (Saturday, Sunday) and dates listed in C<$bank_holidays>.

=over 4

=item * C<$start_date> - Start date in YYYY-MM-DD format.

=item * C<$offset> - Number of banking days to advance.

=item * C<$bank_holidays> - Optional array reference of holiday dates in YYYY-MM-DD format.

=back

Returns the resulting date in YYYY-MM-DD format.

=cut

signature_for banking_day_offset => (
    method     => 0,
    positional => [ Str, Int, Optional [ ArrayRef [Str] ] ],
);

sub banking_day_offset ( $start_date, $offset, $bank_holidays = [] ) {
    $bank_holidays //= [];
    my %holidays = map { $_ => 1 } @$bank_holidays;

    my $current = Time::Piece->strptime( "$start_date 12:00:00 UTC", "%Y-%m-%d %H:%M:%S %Z" );

    my $remaining = $offset;
    while ( $remaining > 0 ) {
        $current += ONE_DAY;
        my $ymd  = $current->strftime('%Y-%m-%d');
        my $wday = $current->wday;    # 1 = Sunday, 7 = Saturday

        next if $wday == 1 || $wday == 7;
        next if $holidays{$ymd};

        $remaining--;
    }

    return $current->strftime('%Y-%m-%d');
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $start_date = $args[0];
    my $offset     = int( $args[1] );
    my @holidays   = @args[ 2 .. $#args ];
    my $result     = banking_day_offset( $start_date, $offset, \@holidays );
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label         => 'Example 1',
            start_date    => '2018-06-28',
            offset        => 3,
            bank_holidays => ['2018-07-03'],
            expected      => '2018-07-04',
        },
        {
            label         => 'Example 2',
            start_date    => '2018-06-28',
            offset        => 3,
            bank_holidays => [],
            expected      => '2018-07-03',
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            banking_day_offset(
                $case->{start_date},
                $case->{offset},
                $case->{bank_holidays}
            ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
