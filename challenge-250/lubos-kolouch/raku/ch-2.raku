use Test;

sub max-alphanum-value(*@array) {
    my $max-value = 0;

    for @array -> $s {
        my $value = $s ~~ /^\d+$/ ?? $s.Int !! $s.chars;
        $max-value = $value if $value > $max-value;
    }

    return $max-value;
}

# Tests
is max-alphanum-value("perl", "2", "000", "python", "r4ku"), 6, 'Test Example 1';
is max-alphanum-value("001", "1", "000", "0001"), 1, 'Test Example 2';
is max-alphanum-value(), 0, 'Test Empty Array';
is max-alphanum-value("123", "456", "789"), 789, 'Test All Digits';
is max-alphanum-value("abc", "def", "ghi"), 3, 'Test All Letters';

done-testing;
