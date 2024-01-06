use strict;
use warnings;
use Test::More tests => 5;

sub max_alphanum_value {
    my @array = @_;
    my $max_value = 0;

    foreach my $s (@array) {
        my $value = ($s =~ /^\d+$/ ? int($s) : length($s));
        $max_value = $value if $value > $max_value;
    }

    return $max_value;
}

# Tests
is(max_alphanum_value("perl", "2", "000", "python", "r4ku"), 6, 'Test Example 1');
is(max_alphanum_value("001", "1", "000", "0001"), 1, 'Test Example 2');
is(max_alphanum_value(), 0, 'Test Empty Array');
is(max_alphanum_value("123", "456", "789"), 789, 'Test All Digits');
is(max_alphanum_value("abc", "def", "ghi"), 3, 'Test All Letters');

done_testing();
