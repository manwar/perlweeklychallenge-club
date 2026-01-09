#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Time::Piece;
use Time::Seconds;
use Type::Params    qw(compile);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-1.pl - Last Sunday

=head1 SYNOPSIS

  perl ch-1.pl 2022
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

List the last Sunday of every month in the given year.

=cut

my $INT_CHECK = compile(Int);

sub last_sundays ($year) {
    ($year) = $INT_CHECK->($year);
    die 'Expected a positive year' if $year <= 0;

    my @out;
    for my $month ( 1 .. 12 ) {
        my $first_next = $month == 12
          ? Time::Piece->strptime( sprintf( '%04d-01-01', $year + 1 ), '%Y-%m-%d' )
          : Time::Piece->strptime( sprintf( '%04d-%02d-01', $year, $month + 1 ), '%Y-%m-%d' );

        my $d = $first_next - ONE_DAY;    # last day of month
        $d -= ONE_DAY while $d->wday != 1;    # 1=Sunday
        push @out, $d->strftime('%Y-%m-%d');
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <year>\n" if @args != 1;
    my $year = 0 + $args[0];
    say for @{ last_sundays($year) };
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $expected = [
        qw(
          2022-01-30
          2022-02-27
          2022-03-27
          2022-04-24
          2022-05-29
          2022-06-26
          2022-07-31
          2022-08-28
          2022-09-25
          2022-10-30
          2022-11-27
          2022-12-25
        )
    ];

    Test::More::plan( tests => 1 );
    Test::More::is_deeply( last_sundays(2022), $expected, 'Example: year 2022' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 last_sundays($year)

Returns an arrayref of dates (YYYY-MM-DD).

=cut
