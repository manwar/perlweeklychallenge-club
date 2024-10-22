use strict;
use warnings FATAL => 'all';
use Method::Signatures;
use Getopt::Long;
use Test::More;

my $run_tests;
GetOptions("test" => \$run_tests);

func check_if_largest_element_is_at_least_twice_larger_than_any_other(ArrayRef $integers){
    my $current_winner_index=0;
    my @integers = @{$integers};
    if (scalar(@integers) == 1){
        return 0;
    }
    my $largest_so_far = shift(@integers);
    my $largest_so_far_index = 0;
    my $index = 1;
    for my $integer (@integers){
        if ($integer>$largest_so_far){
            if (($largest_so_far == 0) or $integer/$largest_so_far >= 2){
                $current_winner_index = $index;
            }
            else{
                $current_winner_index = -1;
            }
            $largest_so_far = $integer;
            $largest_so_far_index = $index;
        }
        else{
            if (($integer != 0) and $largest_so_far/abs($integer) < 2){
                $current_winner_index = -1;
            }
        }
        $index++;
    }
    return $current_winner_index;
}

# Test suite

if (defined $run_tests){
    subtest 'test_with_example_array_1' => \&test_with_example_array_1;
    subtest 'test_with_example_array_2' => \&test_with_example_array_2;
    subtest 'test_with_example_array_3' => \&test_with_example_array_3;
    subtest 'test_with_example_array_4' => \&test_with_example_array_4;
    subtest 'test_with_example_array_5' => \&test_with_example_array_5;
    subtest 'test_with_example_array_6' => \&test_with_example_array_6;
    done_testing;
}

func test_with_example_array_1(){
    my @integers = (2,4,1,0);
    ok check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers) == 1;
}

func test_with_example_array_2(){
    my @integers = (1,2,3,4);
    ok check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers) == -1;
}

func test_with_example_array_3(){
    my @integers = (10,2,3,5);
    ok check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers) == 0;
}

func test_with_example_array_4(){
    my @integers = (1,2,2,5,-100);
    ok check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers) == -1;
}

func test_with_example_array_5(){
    my @integers = (0,0,5,0,0,0);
    ok check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers) == 2;
}

func test_with_example_array_6(){
    my @integers = (5,0,-1,-100);
    print("Result is ".check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers)."\n");
    ok check_if_largest_element_is_at_least_twice_larger_than_any_other(\@integers) == -1;
}

