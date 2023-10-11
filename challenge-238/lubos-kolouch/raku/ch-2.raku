# Function to calculate steps to reach a single-digit number
sub calc_steps(Int $num) {
    my $steps = 0;
    my $n = $num;

    while $n.chars > 1 {
        $n = [*] $n.comb.map(*.Int);
        $steps++;
    }

    return $steps;
}

# Function to perform persistence sort
sub persistence-sort(@arr) {
    return @arr.sort({ calc_steps($_) })».Int;
}

# Test cases
my @test1 = persistence-sort([15, 99, 1, 34]);
say @test1;  # Output should be [1, 15, 34, 99]

my @test2 = persistence-sort([50, 25, 33, 22]);
say @test2;  # Output should be [22, 33, 50, 25]
