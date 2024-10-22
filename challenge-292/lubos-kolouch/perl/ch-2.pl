#!/usr/bin/perl
use strict;
use warnings;

# Function to eliminate balls from the board
sub eliminate {
    my ($board) = @_;

    my $changed = 1;
    while ($changed) {
        $changed = 0;
        if ($board =~ s/(.)\1{2,}//g) {
            $changed = 1;
        }
    }
    return $board;
}

# Function to find the minimum steps to clear the board
sub find_min_steps {
    my ($board, $hand) = @_;

    # Initialize hand counts
    my %hand_counts;
    $hand_counts{$_}++ for split //, $hand;

    # Initialize queue for BFS
    my @queue = ( [ $board, \%hand_counts, 0 ] );

    # Visited states
    my %visited;

    while (@queue) {
        my $current = shift @queue;
        my ($current_board, $current_hand_ref, $steps) = @$current;

        # Copy hand counts to avoid shared references
        my %current_hand = %{$current_hand_ref};

        # If the board is empty, return the number of steps
        if ($current_board eq '') {
            return $steps;
        }

        # Generate a unique key for the current state
        my $hand_key = join('', sort map { $_ . $current_hand{$_} } keys %current_hand);
        my $state_key = $current_board . '|' . $hand_key;

        # Skip if we've already visited this state
        next if exists $visited{$state_key};
        $visited{$state_key} = 1;

        # Try inserting each ball in hand at each position
        for my $i (0 .. length($current_board)) {
            for my $color (keys %current_hand) {
                next if $current_hand{$color} == 0;

                # Insert the ball
                my $new_board = substr($current_board, 0, $i) . $color . substr($current_board, $i);

                # Eliminate balls
                $new_board = eliminate($new_board);

                # Decrease the hand count
                my %new_hand = %current_hand;
                $new_hand{$color}--;

                # Remove color from hand if count reaches zero
                delete $new_hand{$color} if $new_hand{$color} == 0;

                # Prepare the new state
                my $new_state = [ $new_board, \%new_hand, $steps + 1 ];

                # Generate a unique key for the new state
                my $new_hand_key = join('', sort map { $_ . $new_hand{$_} } keys %new_hand);
                my $new_state_key = $new_board . '|' . $new_hand_key;

                # Skip if we've already visited this state
                next if exists $visited{$new_state_key};

                # Enqueue the new state
                push @queue, $new_state;
            }
        }
    }

    # If we cannot clear the board
    return -1;
}

# Test cases
my @tests = (
    { board => "WRRBBW",    hand => "RB",     expected => -1 },
    { board => "WWRRBBWW",  hand => "WRBRW",  expected => 2 },
    { board => "G",         hand => "GGGGG",  expected => 2 },
    { board => "RBYYBBRRB", hand => "YRBGB",  expected => 3 },
);

foreach my $test (@tests) {
    my $result = find_min_steps($test->{board}, $test->{hand});
    print "Input: \$board = \"$test->{board}\", \$hand = \"$test->{hand}\"\n";
    print "Output: $result\n";
    print "Expected: $test->{expected}\n";
    print "-" x 40, "\n";
}
