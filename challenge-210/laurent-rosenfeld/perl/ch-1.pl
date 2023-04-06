sub sum_deleted_digits {
    # we can always delete all digits
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

for my $test ([<2 3 1>], [<1 1 2 2 2 3>])  {
    printf "%-15s => %d \n", "@$test", sum_deleted_digits @$test;
}
