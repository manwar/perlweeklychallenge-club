#!/usr/bin/perl
# Test: ./ch2.pl
use strict;
use warnings;

# Box configurations
my $boxes = {
    R => { weight => 1,  amount => 1  },
    B => { weight => 1,  amount => 2  },
    G => { weight => 2,  amount => 2  },
    Y => { weight => 12, amount => 4  },
    P => { weight => 4,  amount => 10 },
};

# knapsack with unlimited boxes and 15 kg max
knapsack($boxes, 15, 0);

# knapsack with 2 3 4 boxes and 15kg max
knapsack($boxes, 15, 2);
knapsack($boxes, 15, 3);
knapsack($boxes, 15, 4);

sub knapsack {
    my ($boxes, $max_weight, $max_boxes) = @_;
    my $total_weight = 0;
    my $total_boxes  = 0;
    my $total_amount = 0;
    my $set_of_boxes;

    # Order the boxes by which
    # gives the most value, followed by weight.
    for my $key ( sort sort_value_weight keys %$boxes ) {
        my $box = $boxes->{$key};

        # While there is space or weight left
        while (1) {
            # Check for space or weight
            last unless
                $total_weight + $box->{weight} <=
                $max_weight;

            last unless
                !$max_boxes ||
                ($max_boxes && $total_boxes + 1 <=
                 $max_boxes);

            $total_boxes++;
            $set_of_boxes .= $key;
            $total_weight += $box->{weight};
            $total_amount += $box->{amount};
        }
    }

    print 'Max weight: ' . $max_weight;
    print ', max boxes: ' . $max_boxes
        if ($max_boxes);
    print '. Boxes in knapsack: ' .
        $set_of_boxes;
    print ' ' . $total_weight . 'kg ';
    print '£' . $total_amount . "\n";
}

# Sort function to sort by value then weight
sub sort_value_weight {
    my $value_a =
        $boxes->{$::a}->{amount} /
        $boxes->{$::a}->{weight};

    my $value_b =
        $boxes->{$::b}->{amount} /
        $boxes->{$::b}->{weight};

    my $weight_a =
        $boxes->{$::a}->{weight};

    my $weight_b =
        $boxes->{$::b}->{weight};

    if ( $value_b > $value_a ) {
        return 1;
    } elsif ( $value_b == $value_a ) {
        return ($weight_b > $weight_a) ? 1 : -1;
    } else {
        return -1;
    }
}
