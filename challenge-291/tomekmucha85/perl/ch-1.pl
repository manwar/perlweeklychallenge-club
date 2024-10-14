use strict;
use warnings;
use Getopt::Long;
use Test::More;

my $run_tests;
GetOptions("test" => \$run_tests);

sub find_middle_index{
    my $total_sum = 0;
    foreach my $integer (@_){
        $total_sum += $integer
    }
    my $accumulated_sum = 0;
    my $counter = 0;
    my $previous_integer = undef;
    foreach my $integer (@_){
        if ($accumulated_sum == $total_sum-($accumulated_sum+$integer) and defined($previous_integer)){
            return $counter;
        }
        $counter++;
        $previous_integer = $integer;
        $accumulated_sum += $integer;
    }
    return -1;
}

# Test suite

if (defined $run_tests){
   subtest 'test_with_example_arrays' => \&test_with_example_arrays;
   done_testing;
}

sub test_with_example_arrays{
    my @example_array_1 = (-1,1,3,8,2,1);
    my $expected_result_1 = 3;
    my @example_array_2 = (2,3,-1,8,4);
    my $expected_result_2 = 3;
    my @example_array_3 = (1, -1, 4);
    my $expected_result_3 = 2;
    my @example_array_4 = (2,5);
    my $expected_result_4 = -1;
    my @test_data = ([\@example_array_1, $expected_result_1],
                     [\@example_array_2, $expected_result_2],
                     [\@example_array_3, $expected_result_3],
                     [\@example_array_4, $expected_result_4]);
    foreach my $test_set (@test_data){
        my ($example_array, $expected_result) = @{$test_set};
        my $result =  find_middle_index(@{$example_array});
        ok $result == $expected_result, "$result equals $expected_result";
    }
};
