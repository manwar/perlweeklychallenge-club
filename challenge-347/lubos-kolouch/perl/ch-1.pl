#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-1.pl - Format Date (Perl Weekly Challenge 347)

=head1 SYNOPSIS

  perl ch-1.pl "1st Jan 2025"
  perl ch-1.pl              # executes the example tests

=head1 DESCRIPTION

Parses an input such as C<10th Nov 2025> and emits it in ISO form
C<2025-11-10>. Validation follows the specification-provided sets of days,
months, and years.

=cut

my %MONTH_INDEX = (
    Jan => 1,
    Feb => 2,
    Mar => 3,
    Apr => 4,
    May => 5,
    Jun => 6,
    Jul => 7,
    Aug => 8,
    Sep => 9,
    Oct => 10,
    Nov => 11,
    Dec => 12,
);

sub format_date ($input) {
    state $check = compile(Str);
    ($input) = $check->($input);
    $input =~ s/^\s+|\s+$//g;

    my ( $day, $suffix, $month_name, $year ) =
      $input =~ /\A(\d{1,2})(st|nd|rd|th)\s+([A-Za-z]{3})\s+(\d{4})\z/
      or die 'Invalid date format';

    my $day_num = $day + 0;
    die 'Day out of range'       unless 1 <= $day_num && $day_num <= 31;
    die 'Invalid ordinal suffix' unless _suffix_for($day_num) eq $suffix;

    my $month_num = $MONTH_INDEX{$month_name} // die 'Unknown month abbreviation';

    my $year_num = $year + 0;
    die 'Year out of range' unless 1900 <= $year_num && $year_num <= 2100;

    return sprintf '%04d-%02d-%02d', $year_num, $month_num, $day_num;
}

sub _suffix_for ($day) {
    return 'th' if $day % 100 >= 11 && $day % 100 <= 13;
    return ( 'th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th' )[ $day % 10 ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die qq{Usage: perl $0 "1st Jan 2025"\n} if @args != 1;
    my $input = $args[0];
    say qq{Input:  \$str = "$input"};
    my $formatted = format_date($input);
    say qq{Output: "$formatted"};
}

sub _run_tests {
    require Test::More;
    Test::More->import();

    my @cases = (
        { label => 'Example 1', str => '1st Jan 2025',  expected => '2025-01-01' },
        { label => 'Example 2', str => '22nd Feb 2025', expected => '2025-02-22' },
        { label => 'Example 3', str => '15th Apr 2025', expected => '2025-04-15' },
        { label => 'Example 4', str => '23rd Oct 2025', expected => '2025-10-23' },
        { label => 'Example 5', str => '31st Dec 2025', expected => '2025-12-31' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = format_date( $case->{str} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=head1 FUNCTIONS

=head2 format_date($input)

Returns the ISO-formatted representation of C<$input>. Throws an exception when
the supplied string falls outside the allowed day, month, or year sets.

=cut
