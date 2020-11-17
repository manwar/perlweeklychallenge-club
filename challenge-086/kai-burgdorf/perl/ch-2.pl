#!/usr/bin/perl

use strict;
use warnings;

my $board_input =
"[ _ _ _ 2 6 _ 7 _ 1 ], [ 6 8 _ _ 7 _ _ 9 _ ], [ 1 9 _ _ _ 4 5 _ _ ], [ 8 2 _ 1 _ _ _ 4 _ ], [ _ _ 4 6 _ 2 9 _ _ ], [ _ 5 _ _ _ 3 _ 2 8 ], [ _ _ 9 3 _ _ _ 7 4 ], [ _ 4 _ _ 5 _ _ 3 6 ], [ 7 _ 3 _ 1 8 _ _ _ ]";

my $board_obj = init_board_hash($board_input);

solve();
print_board();

sub init_board_hash {
    my ($input) = @_;

    my $board_hash;
    my @rows = split( ",", $input );

    my $i = 1;
    for my $row (@rows) {

        my @values = split( " ", $row );
        shift @values;
        pop @values;

        my $j = 1;
        for my $value (@values) {
            $board_hash->{$i}->{$j} = ( $value eq "_" ) ? [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] : [$value];
            $j++;
        }

        $i++;
    }

    return $board_hash;
}

sub solve {

    while ( !is_solved() ) {
        for ( my $i = 1 ; $i <= 9 ; $i++ ) {
            for ( my $j = 1 ; $j <= 9 ; $j++ ) {
                $board_obj->{$i}->{$j} = get_possibilities( $i, $j );
            }
        }
    }
}

sub is_solved {

    for ( my $i = 1 ; $i <= 9 ; $i++ ) {
        for ( my $j = 1 ; $j <= 9 ; $j++ ) {

            if ( not defined $board_obj->{$i}->{$j} ) {
                return 0;
            }
            if ( ref( $board_obj->{$i}->{$j} ) eq "ARRAY" && scalar @{ $board_obj->{$i}->{$j} } != 1 ) {
                return 0;
            }
        }
    }

    return 1;
}

sub get_possibilities {
    my ( $i, $j ) = @_;

    my @possibilities = ();

    for ( my $k = 1 ; $k <= 9 ; $k++ ) {
        if ( defined $board_obj->{$i}->{$j} && scalar @{ $board_obj->{$i}->{$j} } == 1 ) {
            return $board_obj->{$i}->{$j};
        }
        if ( fits_in_row( $i, $k ) == 1 && fits_in_col( $j, $k ) && fits_in_box( $i, $j, $k ) ) {
            push( @possibilities, $k );
        }
    }

    return \@possibilities;
}

sub fits_in_row {
    my ( $row, $value ) = @_;

    for ( my $i = 1 ; $i <= 9 ; $i++ ) {

        if ( not defined $board_obj->{$row}->{$i} ) {
            next;
        }
        if ( ref( $board_obj->{$row}->{$i} ) eq 'ARRAY' ) {
            my @arr = @{ $board_obj->{$row}->{$i} };
            if ( scalar @arr == 1 && $arr[0] == $value ) {
                return 0;
            }
        }
        else {
            if ( $board_obj->{$row}->{$i} == $value ) {
                return 0;
            }
        }

    }
    return 1;
}

sub fits_in_col {
    my ( $col, $value ) = @_;

    for ( my $i = 1 ; $i <= 9 ; $i++ ) {

        if ( not defined $board_obj->{$i}->{$col} ) {
            next;
        }
        if ( ref( $board_obj->{$i}->{$col} ) eq 'ARRAY' ) {
            my @arr = @{ $board_obj->{$i}->{$col} };
            if ( scalar @arr == 1 && $arr[0] == $value ) {
                return 0;
            }
        }
        else {
            if ( $board_obj->{$i}->{$col} == $value ) {
                return 0;
            }
        }

    }

    return 1;
}

sub fits_in_box {
    my ( $row, $col, $value ) = @_;

    my $box_values = get_box_values( $row, $col );

    for my $box_value ( @{$box_values} ) {
        if ( $box_value == $value ) {
            return 0;
        }
    }

    return 1;
}

sub get_box_values {
    my ( $row, $col ) = @_;

    my @box_values;

    my $tl_corner_row = $row;
    my $tl_corner_col = $col;

    if ( $tl_corner_row % 3 == 2 ) {
        $tl_corner_row = $row - 1;
    }
    elsif ( $tl_corner_row % 3 == 0 ) {
        $tl_corner_row = $row - 2;
    }

    if ( $tl_corner_col % 3 == 2 ) {
        $tl_corner_col = $col - 1;
    }
    elsif ( $tl_corner_col % 3 == 0 ) {
        $tl_corner_col = $col - 2;
    }

    for ( my $i = $tl_corner_row ; $i < $tl_corner_row + 3 ; $i++ ) {
        for ( my $j = $tl_corner_col ; $j < $tl_corner_col + 3 ; $j++ ) {
            my $value = "";

            if ( not defined $board_obj->{$i}->{$j} ) {
                next;
            }
            if ( ref( $board_obj->{$i}->{$j} ) eq "ARRAY" && scalar @{ $board_obj->{$i}->{$j} } == 1 ) {
                push( @box_values, @{ $board_obj->{$i}->{$j} }[0] );
            }
        }
    }

    return \@box_values;
}

sub print_board {

    for ( my $i = 1 ; $i <= 9 ; $i++ ) {
        for ( my $j = 1 ; $j <= 9 ; $j++ ) {
            print " @{$board_obj->{$i}->{$j}}[0] ";
            if ( $j == 3 || $j == 6 ) {
                print " | ";
            }
        }
        print "\n";
        if ( $i == 3 || $i == 6 ) {
            print "- - - - - - - - - - - - - - - - -\n";
        }
    }
}
