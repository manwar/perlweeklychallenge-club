#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 349 Task 2: Meeting Point
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

sub meeting_point_if_then_else( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    for ( ref $path ? $path->@* : split "", $path ) {
        $_ eq "U" ? ++$y :
        $_ eq "D" ? --$y :
        $_ eq "L" ? --$x :
        $_ eq "R" ? ++$x : ();
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}

sub meeting_point_incr( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    my %incr_x = ( U => 0,  D => 0,  L => -1, R => +1 );
    my %incr_y = ( U => +1, D => -1, L => 0,  R => 0  );
    for ( ref $path ? $path->@* : split "", $path ) {
        $x += $incr_x{$_};
        $y += $incr_y{$_};
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}

sub meeting_point_incr_2( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    my %incr = (
        U => [ 0, +1 ],
        D => [ 0, -1 ],
        L => [ -1, 0 ],
        R => [ +1, 0 ] );
    for ( ref $path ? $path->@* : split "", $path ) {
        $x += $incr{$_}->[0];
        $y += $incr{$_}->[1];
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}

sub meeting_point_using_subs( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    my %move_subs = (
        U => sub { ++$y },
        D => sub { --$y },
        L => sub { --$x },
        R => sub { ++$x },
    );
    for ( ref $path ? $path->@* : split "", $path ) {
        $move_subs{$_}->();
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}

# *meeting_point = \&meeting_point_eq_if_then_else;
*meeting_point = \&meeting_point_using_subs;

use Test2::V0 qw( -no_srand );

is meeting_point( "ULD" ), F,
    'Example 1: meeting_point( "ULD" ) is false';
is meeting_point( "ULDR" ), T,
    'Example 2: meeting_point( "ULDR" ) is true';
is meeting_point( "UUURRRDDD" ), F,
    'Example 3: meeting_point( "UUURRRDDD" ) is false';
is meeting_point( "UURRRDDLLL" ), T,
    'Example 4: meeting_point( "UURRRDDLLL" ) is true';
is meeting_point( "RRUULLDDRRUU" ), T,
    'Example 5: meeting_point( "RRUULLDDRRUU" ) is true';

done_testing;


=for benchmark

use Benchmark qw( :all );

my @dirs = qw( U D L R );
srand( 2 );
my $test_data = [ map $dirs[ rand( @dirs ) ], 1..10000 ];

cmpthese( -1, {
    "if_then_else" => sub { meeting_point_if_then_else( $test_data ) },
    "incr"         => sub { meeting_point_incr( $test_data ) },
    "incr_2"       => sub { meeting_point_incr_2( $test_data ) },
    "using_subs"   => sub { meeting_point_using_subs( $test_data ) },
} );

=cut 
