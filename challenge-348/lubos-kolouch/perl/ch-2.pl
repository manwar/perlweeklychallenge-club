#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(StrMatch);

=pod

=head1 NAME

ch-2.pl - Convert Time

=head1 SYNOPSIS

  perl ch-2.pl <source> <target>
  perl ch-2.pl             # runs the embedded tests

=head1 DESCRIPTION

Computes the minimal number of allowed operations needed to transform a source
24-hour clock stamp into a target one by adding 1, 5, 15, or 60 minutes. The
greedy strategy works because every duration divides the next larger one.

=cut

my $STAMP_CHECK = compile( StrMatch [qr/\A\d\d:\d\d\z/] );
my @OPERATIONS  = ( 60, 15, 5, 1 );

sub convert_time ( $source, $target ) {
    state $pair_check = compile( StrMatch [qr/\A\d\d:\d\d\z/], StrMatch [qr/\A\d\d:\d\d\z/], );
    ( $source, $target ) = $pair_check->( $source, $target );

    my $start = _minutes_from_midnight($source);
    my $end   = _minutes_from_midnight($target);
    my $diff  = $end - $start;
    $diff += 24 * 60 if $diff < 0;

    my $operations = 0;
    for my $step (@OPERATIONS) {
        $operations += int( $diff / $step );
        $diff %= $step;
    }

    return $operations;
}

sub _minutes_from_midnight ($stamp) {
    ($stamp) = $STAMP_CHECK->($stamp);
    my ( $hour, $minute ) = split /:/, $stamp, 2;
    die 'Invalid hour component'   if $hour < 0   || $hour > 23;
    die 'Invalid minute component' if $minute < 0 || $minute > 59;
    return ( $hour * 60 ) + $minute;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <source> <target>\n" if @args != 2;
    my ( $source, $target ) = @args;
    say qq{Input:  \$source = "$source"};
    say qq{        \$target = "$target"};
    my $steps = convert_time( $source, $target );
    say "Output: $steps";
}

sub _run_tests {
    require Test::More;
    Test::More->import();

    my @cases = (
        { label => 'Example 1', source => '02:30', target => '02:45', expected => 1 },
        { label => 'Example 2', source => '11:55', target => '12:15', expected => 2 },
        { label => 'Example 3', source => '09:00', target => '13:00', expected => 4 },
        { label => 'Example 4', source => '23:45', target => '00:30', expected => 3 },
        { label => 'Example 5', source => '14:20', target => '15:25', expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = convert_time( $case->{source}, $case->{target} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 convert_time($source, $target)

Returns the minimal number of permitted increments required to reach C<$target>
from C<$source>. Internally converts both timestamps to minutes past midnight
and applies a greedy decomposition.

=cut
