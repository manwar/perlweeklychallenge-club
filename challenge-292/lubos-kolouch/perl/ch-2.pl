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

ch-2.pl - Zuma Game (WWC 292 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl "WWRRBBWW" "WRBRW"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are playing a game of Zuma with a board string and a hand string of colored balls.
Inserting balls can eliminate consecutive groups of 3 or more identical balls.
Find the minimum number of balls to insert from your hand to clear the board, or -1 if impossible.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub eliminate ($board) {
    my $changed = 1;
    while ($changed) {
        $changed = ( $board =~ s/(.)\1{2,}//g ) ? 1 : 0;
    }
    return $board;
}

sub find_min_steps ( $board, $hand ) {
    ( $board, $hand ) = $ARGS_CHECK->( $board, $hand );

    my %hand_counts;
    $hand_counts{$_}++ for split //, $hand;

    my @queue = ( [ $board, \%hand_counts, 0 ] );
    my %visited;

    while (@queue) {
        my $current = shift @queue;
        my ( $current_board, $current_hand_ref, $steps ) = @$current;

        my %current_hand = %$current_hand_ref;

        return $steps if $current_board eq '';

        my $hand_key = join( '', map { $_ . $current_hand{$_} } sort keys %current_hand );
        my $state_key = "$current_board|$hand_key";

        next if exists $visited{$state_key};
        $visited{$state_key} = 1;

        for my $i ( 0 .. length($current_board) ) {
            for my $color ( sort keys %current_hand ) {
                next if ( $current_hand{$color} // 0 ) <= 0;

                my $new_board = substr( $current_board, 0, $i ) . $color . substr( $current_board, $i );
                $new_board = eliminate($new_board);

                my %new_hand = %current_hand;
                $new_hand{$color}--;
                delete $new_hand{$color} if $new_hand{$color} == 0;

                my $new_hand_key = join( '', map { $_ . $new_hand{$_} } sort keys %new_hand );
                my $new_state_key = "$new_board|$new_hand_key";

                next if exists $visited{$new_state_key};

                push @queue, [ $new_board, \%new_hand, $steps + 1 ];
            }
        }
    }

    return -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 board hand\n" if @args != 2;
    my $out = find_min_steps( $args[0], $args[1] );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', board => 'WRRBBW',    hand => 'RB',    expected => -1 },
        { label => 'Example 2', board => 'WWRRBBWW',  hand => 'WRBRW', expected => 2 },
        { label => 'Example 3', board => 'G',         hand => 'GGGGG', expected => 2 },
        { label => 'Example 4', board => 'RBYYBBRRB', hand => 'YRBGB', expected => 3 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( find_min_steps( $case->{board}, $case->{hand} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 eliminate($board)

Eliminates consecutive groups of three or more identical balls.

=head2 find_min_steps($board, $hand)

Returns the minimum balls from hand needed to clear the board, or -1 if impossible.

=cut
