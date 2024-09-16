my @coins = 50, 25, 10, 5, 1;
my $count;

sub make-change ($amount, $limit) {
    for @coins -> $coin {
        next if $coin > $amount;
        # Prevent duplicate combinations in different orders
        next if $coin > $limit;
        my $rest = $amount - $coin;
        if $rest == 0 {
            $count++;
        } else {
            make-change($rest, $coin);
        }
    }
    return $count;
}

my @tests = 9, 15, 100;
for @tests -> $test {
    $count = 0;
    printf "%-5d => ", $test;
    say make-change $test, 50;
}
