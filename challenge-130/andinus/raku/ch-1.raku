#| find integer that appears odd number of times
sub MAIN(*@nums) {
    my Bool %seen;
    %seen{$_} = !%seen{$_} for @nums;
    put %seen.grep(*.value).map(*.key);
}
