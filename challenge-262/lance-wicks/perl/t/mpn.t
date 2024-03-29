use Test2::V0 -target => 'MPN';

subtest "Example 1" => sub {
    my @ints = (-3, 1, 2, -1, 3, -2, 4);
    is $CLASS->positives(@ints), 4;
    is $CLASS->negatives(@ints), 3;
    is $CLASS->max_pos_or_neg(@ints), 4;
};

subtest "Example 2" => sub {
    my @ints = (-1, -2, -3, 1);
    is $CLASS->positives(@ints), 1;
    is $CLASS->negatives(@ints), 3;
    is $CLASS->max_pos_or_neg(@ints), 3;
};

subtest "Example 3" => sub {
    my @ints = (1, 2);
    is $CLASS->positives(@ints), 2;
    is $CLASS->negatives(@ints), 0;
    is $CLASS->max_pos_or_neg(@ints), 2;
};

subtest "Example 3" => sub {
    my @ints = (1, 2);
    is $CLASS->positives(@ints), 2;
    is $CLASS->negatives(@ints), 0;
    is $CLASS->max_pos_or_neg(@ints), 2;
};

subtest "Zero is neither positive or negative" => sub {
    my @ints = (-0,+0,0);
    is $CLASS->positives(@ints), 0;
    is $CLASS->negatives(@ints), 0;
    is $CLASS->max_pos_or_neg(@ints), 0;
};

done_testing;