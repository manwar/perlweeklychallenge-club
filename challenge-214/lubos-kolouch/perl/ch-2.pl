use strict;
use warnings;

sub max_score {
    my @numbers = @_;
    return helper(\@numbers, {});
}

sub helper {
    my ($numbers, $memo) = @_;

    return 0 if scalar(@$numbers) == 0;

    my $key = join(',', @$numbers);
    return $memo->{$key} if exists $memo->{$key};

    my $max_score = 0;
    my $i = 0;
    while ($i < scalar(@$numbers)) {
        my $j = $i;
        while ($j < scalar(@$numbers) && $numbers->[$j] == $numbers->[$i]) {
            $j++;
        }

        my $length = $j - $i;
        my @next_numbers = (@$numbers[0 .. $i - 1], @$numbers[$j .. scalar(@$numbers) - 1]);
        my $score = $length * $length + helper(\@next_numbers, $memo);
        $max_score = $max_score > $score ? $max_score : $score;
        $i = $j;
    }

    $memo->{$key} = $max_score;
    return $max_score;
}

# Test cases
my @numbers1 = (2, 4, 3, 3, 3, 4, 5, 4, 2);
my @numbers2 = (1, 2, 2, 2, 2, 1);
my @numbers3 = (1);
my @numbers4 = (2, 2, 2, 1, 1, 2, 2, 2);

print max_score(@numbers1), "\n";  # Output: 23
print max_score(@numbers2), "\n";  # Output: 20
print max_score(@numbers3), "\n";  # Output: 1
print max_score(@numbers4), "\n";  # Output: 40

