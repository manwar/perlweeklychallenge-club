use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my %categories = ("electronics" => 1, "grocery" => 1, "pharmacy" => 1, "restaurant" => 1);

sub run($codes, $names, $status) {
    my @result;

    for (my $i = 0; $i < scalar(@$codes); $i++) {
        push @result, $codes->[$i] =~ /^\w+$/ && exists $categories{$names->[$i]} && $status->[$i] eq "true" ? 1 : 0;
    }
    return [ @result ];
}

is_deeply(
    run(
        ['A123', 'B_456', 'C789', 'D@1', 'E123'],
        ['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'],
        ['true', 'false', 'true', 'true', 'true'],
    ),
    [1, 0, 1, 0, 1],
    'Example 1'
);

is_deeply(
    run(
        ['Z_9', 'AB_12', 'G01', 'X99', 'test'],
        ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'],
        ['true', 'true', 'false', 'true', 'true'],
    ),
    [1, 1, 0, 1, 0],
    'Example 2'
);

is_deeply(
    run(
        ['_123', '123', '', 'Coupon_A', 'Alpha'],
        ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'],
        ['true', 'true', 'false', 'true', 'true'],
    ),
    [1, 1, 0, 1, 1],
    'Example 3'
);

is_deeply(
    run(
        ['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'],
        ['electronics', 'electronics', 'grocery', 'grocery'],
        ['true', 'true', 'true', 'true'],
    ),
    [1, 1, 1, 1],
    'Example 4'
);

is_deeply(
    run(
        ['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'],
        ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'],
        ['true', 'true', 'true', 'true', 'false'],
    ),
    [1, 1, 1, 1, 0],
    'Example 5'
);

