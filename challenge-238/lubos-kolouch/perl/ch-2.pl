use strict;
use warnings;
use feature 'say';
use List::Util qw(reduce);

# Function to calculate persistence steps
sub persistence_steps {
    my $num = shift;
    my $count = 0;
    while ($num >= 10) {
        $count++;
        $num = reduce { $a * $b } split('', $num);
    }
    return $count;
}

# Function to sort array based on persistence steps
sub persistence_sort {
    my @arr = @_;
    return sort {
        my $steps_a = persistence_steps($a);
        my $steps_b = persistence_steps($b);
        $steps_a <=> $steps_b || $a <=> $b
    } @arr;
}

# Test Cases
use Test::More;

my @test1 = persistence_sort(15, 99, 1, 34);
is_deeply(\@test1, [1, 15, 34, 99], 'Test Case 1');

my @test2 = persistence_sort(50, 25, 33, 22);
is_deeply(\@test2, [22, 33, 50, 25], 'Test Case 2');

done_testing();
