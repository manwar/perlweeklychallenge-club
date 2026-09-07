#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use File::Temp qw(tempfile);

sub get_lines_range ( $file_name, $a, $b ) {
    return [] if $a < 1 || $b < $a;

    open my $fh, '<', $file_name or die "Could not open '$file_name': $!";
    my @lines = <$fh>;
    close $fh;

    chomp @lines;

    my $start_idx = $a - 1;
    my $end_idx   = $b - 1;
    $end_idx = $#lines if $end_idx > $#lines;

    return [] if $start_idx > $#lines;

    my @result = @lines[ $start_idx .. $end_idx ];
    return \@result;
}

sub display_lines ( $file_name, $a, $b ) {
    my $lines = get_lines_range( $file_name, $a, $b );
    say $_ for @$lines;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    my ( $fh, $filename ) = tempfile( UNLINK => 1 );
    for my $i ( 1 .. 20 ) {
        say $fh "L$i";
    }
    close $fh;

    my @expected_4_12 = map { "L$_" } 4 .. 12;
    is_deeply(
        get_lines_range( $filename, 4, 12 ),
        \@expected_4_12,
        'Lines range 4..12'
    );

    is_deeply(
        get_lines_range( $filename, 1, 3 ),
        [ 'L1', 'L2', 'L3' ],
        'Lines range 1..3'
    );

    is_deeply( get_lines_range( $filename, 5, 2 ), [], 'Invalid range 5..2' );

    done_testing();
}

