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

ch-2.pl - Balls and Boxes

=head1 SYNOPSIS

  perl ch-2.pl G0B1R2R0B0
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

The input string encodes colored balls in boxes as pairs: a color letter (R, G,
B) followed by a box digit (0-9). The task is to count how many boxes contain
all three colors.

=cut

my $STR_CHECK = compile(Str);

sub balls_and_boxes ($str) {
    ($str) = $STR_CHECK->($str);
    die 'Expected an even-length string of (Color,Box) pairs' if length($str) % 2 != 0;

    my @boxes;
    for my $i ( 0 .. 9 ) {
        $boxes[$i] = {};
    }

    my @chars = split //, $str;
    for ( my $i = 0; $i < @chars; $i += 2 ) {
        my $color = $chars[$i];
        my $box   = $chars[ $i + 1 ];
        die 'Invalid color' if $color !~ /\A[RGB]\z/;
        die 'Invalid box'   if $box !~ /\A[0-9]\z/;
        $boxes[$box]{$color} = 1;
    }

    my $count = 0;
    for my $box ( 0 .. 9 ) {
        ++$count if $boxes[$box]{R} && $boxes[$box]{G} && $boxes[$box]{B};
    }
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;
    my $str = $args[0];
    my $out = balls_and_boxes($str);
    say qq{Input: \$str = "$str"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'G0B1R2R0B0',         expected => 1 },
        { label => 'Example 2', str => 'G1R3R6B3G6B1B6R1G3', expected => 3 },
        { label => 'Example 3', str => 'B3B2G1B3',           expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( balls_and_boxes( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 balls_and_boxes($str)

Returns the number of boxes (0-9) that contain all three colors.

=cut
