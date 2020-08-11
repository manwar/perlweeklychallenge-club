# Test: perl6 ch2.p6
use v6.d;

# Box configurations
my %boxes = (
    R => { weight => 1,  amount => 1  },
    B => { weight => 1,  amount => 2  },
    G => { weight => 2,  amount => 2  },
    Y => { weight => 12, amount => 4  },
    P => { weight => 4,  amount => 10 },
);

sub MAIN () {
    # knapsack with unlimited boxes and 15 kg max
    knapsack(%boxes, 15, Inf);

    # knapsack with 2 3 4 boxes and 15kg max
    knapsack(%boxes, 15, 2);
    knapsack(%boxes, 15, 3);
    knapsack(%boxes, 15, 4);
}

sub knapsack (%boxes, Int $max_weight, Num() $max_boxes) {
    my $total_weight = 0;
    my $total_boxes  = 0;
    my $total_amount = 0;
    my $set_of_boxes = '';

    for %boxes.keys.sort(&sort-value-weight) -> $key {
        my $box = %boxes.{$key};

        # While there is space or weight left
        while (1) {
            # Check for space or weight
            last unless
                $total_weight + $box.{'weight'} <=
                $max_weight;

            last unless
                !$max_boxes ||
                ($max_boxes && $total_boxes + 1 <=
                 $max_boxes);

            $total_boxes++;
            $set_of_boxes ~= $key;
            $total_weight += $box.{'weight'};
            $total_amount += $box.{'amount'};
        }
    }

    say 'Max weight: ' ~ $max_weight ~
        ', max boxes: ' ~ $max_boxes ~
        '. Boxes in knapsack: ' ~
        $set_of_boxes ~
        ' ' ~ $total_weight ~ 'kg ' ~
        '£' ~ $total_amount;
}

# Sort function to sort by value then weight
sub sort-value-weight {
    my $value_a =
        %boxes.{$^a}.{'amount'} /
        %boxes.{$^a}.{'weight'};

    my $value_b =
        %boxes.{$^b}.{'amount'} /
        %boxes.{$^b}.{'weight'};

    my $weight_a =
        %boxes.{$^a}.{'weight'};

    my $weight_b =
        %boxes.{$^b}.{'weight'};

    if ( $value_b > $value_a ) {
        return 1;
    } elsif ( $value_b == $value_a ) {
        return ($weight_b > $weight_a) ?? 1 !! -1;
    } else {
        return -1;
    }
}

