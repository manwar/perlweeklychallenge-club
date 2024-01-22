use strict;
use warnings;

sub unique_sum_zero {
    my ($n) = @_;

    # Generate a list of `n` unique integers that sum to zero.

    my @result = map { $_, -$_ } ( 1 .. ( $n / 2 ) );
    push @result, 0 if $n % 2 != 0;
    return @result;
}

# Tests
my @test1 = unique_sum_zero(5);
print "Test 1 (5): @test1\n";
die "Test 1 failed" unless sum(@test1) == 0;

my @test2 = unique_sum_zero(3);
print "Test 2 (3): @test2\n";
die "Test 2 failed" unless sum(@test2) == 0;

my @test3 = unique_sum_zero(1);
print "Test 3 (1): @test3\n";
die "Test 3 failed" unless sum(@test3) == 0;

sub sum {
    my @arr   = @_;
    my $total = 0;
    $total += $_ for @arr;
    return $total;
}
