use strict;
use warnings FATAL => 'all';
use Getopt::Long;
use Method::Signatures;
use Test::More;

my $run_tests;
GetOptions("test" => \$run_tests);


func calculate_linear_equation_from_2_points(ArrayRef $point_1, ArrayRef $point_2){
    # Solving linear equation for a line going through point 1 and 2
    # Using Cramer's rule
    # | x1 1 | * |a| = |y1|
    # | x2 1 |   |b|   |y2|
    #
    my ($point_1_x, $point_1_y) = ($point_1->[0], $point_1->[1]);
    my ($point_2_x, $point_2_y) = ($point_2->[0], $point_2->[1]);
    my $main_determinant = $point_1_x - $point_2_x;
    # Unable to construct equation
    if ($main_determinant == 0){
        return (undef, undef)
    }
    my $det_a = $point_1_y - $point_2_y;
    my $det_b = $point_1_x * $point_2_y - $point_1_y * $point_2_x;
    my $a_value = $det_a/$main_determinant;
    my $b_value = $det_b/$main_determinant;
    return($a_value, $b_value);
}

func tell_if_boomerang(ArrayRef $points){
    my @points_copy = @{$points};
    if (scalar(@points_copy != 3)){
        die ("You need exactly 3 points to form a boomerang!");
    }
    my ($point_1, $point_2, $point_3) = @points_copy;
    my ($value_a_first_line, $value_b_first_line) = calculate_linear_equation_from_2_points($point_1, $point_2);
    my ($value_a_second_line, $value_b_second_line) = calculate_linear_equation_from_2_points($point_2, $point_3);
    if (!defined($value_a_first_line) and !defined($value_a_second_line)){
        # There are two unsolvable sets of equations from 3 points.
        # Therefore we've got three distinct y values for same x => it must be a straight line, not a boomerang.
        return 0;
    }
    elsif (!(defined($value_a_first_line) or !(defined($value_b_second_line)))){
        # Two points stacked one over another (same x, different y), but the third breaks the line.
        return 1;
    }
    else{
        my $are_points_on_same_line = ($value_a_first_line == $value_a_second_line and $value_b_first_line == $value_b_second_line);
        if ($are_points_on_same_line == 1){
            return 0;
        }
        else{
            return 1;
        }
    }
}

# Test suite

if (defined $run_tests){
    subtest 'test_with_example_array_1' => \&test_with_example_array_1;
    subtest 'test_with_example_array_2' => \&test_with_example_array_2;
    subtest 'test_with_example_array_3' => \&test_with_example_array_3;
    subtest 'test_with_example_array_4' => \&test_with_example_array_4;
    subtest 'test_with_example_array_5' => \&test_with_example_array_5;
    subtest 'test_with_example_array_6' => \&test_with_example_array_6;
    done_testing();
}


func test_with_example_array_1(){
    my @example_list = ([1,1], [2,3], [3,2]);
    my $result = tell_if_boomerang(\@example_list);
    ok $result == 1;
}

func test_with_example_array_2(){
    my @example_list = ([1,1], [2,2], [3,3]);
    my $result = tell_if_boomerang(\@example_list);
    ok $result == 0;
}

func test_with_example_array_3(){
    my @example_list = ([1,1], [1,2], [2,3]);
    my $result = tell_if_boomerang(\@example_list);
    ok $result == 1;
}

func test_with_example_array_4(){
    my @example_list = ([1,1], [1,2], [1,3]);
    my $result = tell_if_boomerang(\@example_list);
    ok $result == 0;
}

func test_with_example_array_5(){
    my @example_list = ([1,1], [2,1], [3,1]);
    my $result = tell_if_boomerang(\@example_list);
    ok $result == 0;
}

func test_with_example_array_6(){
    my @example_list = ([0,0], [2,3], [4,5]);
    my $result = tell_if_boomerang(\@example_list);
    ok $result == 1;
}
