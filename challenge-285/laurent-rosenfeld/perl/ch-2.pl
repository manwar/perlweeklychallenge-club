use strict;
use warnings;
no warnings 'recursion';
use feature 'say';

my @coins = (50, 25, 10, 5, 1);
my $count;

sub make_change  {
    my ($amount, $limit) = @_;
    for my $coin (@coins)  {
        next if $coin > $amount;
        # Prevent duplicate combinations in different orders
        next if $coin > $limit;
        my $rest = $amount - $coin;
        if ($rest == 0) {
            $count++;
        } else {
            make_change($rest, $coin);
        }
    }
    return $count;
}

my @tests = (9, 15, 50, 100);
for my $test (@tests) {
    $count = 0;
    printf "%-5d => ", $test;
    say make_change $test, 50;
}
