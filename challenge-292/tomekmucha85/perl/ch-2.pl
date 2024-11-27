use strict;
use warnings FATAL => 'all';
use List::Util qw(min);
use Method::Signatures;
use Getopt::Long;
use Test::More;
use feature qw(say);

my $run_tests;
GetOptions("test" => \$run_tests);

func solve_zuma(ArrayRef $solutions, ArrayRef $balls_line, ArrayRef $hand, Int $depth = 0){
    my @hand_copy = @{$hand};
    my $balls_as_string = join(' ', @{$balls_line});
    # Purge existing triplets - works also with words like 'green' or 'blue', not only single letters
    while ($balls_as_string =~ s/([A-Za-z]+)\s(\1\s?){2,}//g){}; # Delete every word repeating three or more times
    my @purged_line = split(' ', $balls_as_string);
    if (scalar(@purged_line) == 0){
        push(@{$solutions}, $depth);
    }

    # Add next ball
    for my $ball_index (0..(scalar(@hand_copy)-1)) {
        my $ball = $hand_copy[$ball_index];
        my @remaining_balls = @hand_copy;
        splice(@remaining_balls, $ball_index, 1);
        if (scalar(@remaining_balls)>0){
            foreach my $index (0 .. scalar(@purged_line)) {
                my @purged_line_copy = @purged_line;
                my $ball_before;
                my $ball_after;
                if (defined($purged_line_copy[$index+1])){
                    $ball_after = $purged_line_copy[$index+1];
                }
                if ($index>0){
                    $ball_before = $purged_line_copy[$index-1];
                }
                # There is no point in inserting a ball between two balls colored differently
                if ((defined($ball_before) and ($ball eq $ball_before)) or (defined($ball_after) and ($ball eq $ball_after))){
                    splice(@purged_line_copy, $index, 0, $ball); # Insert at position $index replacing 0 elements
                    solve_zuma($solutions, \@purged_line_copy, \@remaining_balls, $depth + 1);
                }
            }
        }
    }
}

func tell_how_many_moves_are_needed_to_solve_zuma(Str $board, Str $hand){
    my @possibilities;
    solve_zuma(\@possibilities, [split('', $board)], [split('', $hand)]);
    if(scalar(@possibilities) < 1){
        return -1;
    }
    else{
        return min(@possibilities);
    }

}


# Test suite

if (defined $run_tests){
    subtest 'test_with_example_array_1' => \&test_with_example_array_1;
    subtest 'test_with_example_array_2' => \&test_with_example_array_2;
    subtest 'test_with_example_array_3' => \&test_with_example_array_3;
    subtest 'test_with_example_array_4' => \&test_with_example_array_4;
    subtest 'test_with_example_array_5' => \&test_with_example_array_5;
    subtest 'test_with_author_given_array_2' => \&test_with_author_given_array_1;
    subtest 'test_with_author_given_array_2' => \&test_with_author_given_array_2;
    subtest 'test_with_author_given_array_3' => \&test_with_author_given_array_3;
   done_testing;
}

func test_with_example_array_1(){
    my $board = 'bbby';
    my $hand = 'bgyy';
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == 2;
}


func test_with_example_array_2(){
    my $board = 'bbbyg';
    my $hand = 'bvyyg';
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == -1;
}

func test_with_example_array_3(){
    my $board = 'ybyy';
    my $hand = 'bvybg';
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == 2;
}

func test_with_example_array_4(){
    my $board = 'bb';
    my $hand = 'v';
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == -1;
}

func test_with_example_array_5(){
    my $board = 'rrgrr';
    my $hand = 'ggr';
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == 2;
}

func test_with_author_given_array_1(){
    my $board = "WRRBBW";
    my $hand = "RB";
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == -1;
}

func test_with_author_given_array_2(){
    my $board = "WWRRBBWW";
    my $hand = "WRBRW";
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == 2;
}

func test_with_author_given_array_3(){
    my $board = "G";
    my $hand = "GGGGG";
    my $result = tell_how_many_moves_are_needed_to_solve_zuma($board, $hand);
    print("Result is: ".$result."\n");
    ok $result == 2;
}
