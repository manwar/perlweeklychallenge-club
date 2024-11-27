use strict;
use warnings FATAL => 'all';
use Getopt::Long;
use Method::Signatures;
use Test::More;

my $run_tests;
GetOptions("test" => \$run_tests);

func get_number_of_similar_dominos(ArrayRef $dominos_list){
    my %dominos_vs_count;
    my $result = 0;
    foreach my $domino_piece (@{$dominos_list}){
        $dominos_vs_count{join(' ',sort(@{$domino_piece}))}++;
    }
    foreach my $count (values(%dominos_vs_count)){
        if ($count > 1){
            $result += $count;
        }
    }
    return $result;
}


# Test suite

if (defined $run_tests){
    subtest 'test_with_example_array_1' => \&test_with_example_array_1;
    subtest 'test_with_example_array_2' => \&test_with_example_array_2;
    subtest 'test_with_example_array_3' => \&test_with_example_array_3;
    done_testing();
}


func test_with_example_array_1(){
    my @example_list = ([1,3], [3,1], [2,4], [6,8]);
    my $result = get_number_of_similar_dominos(\@example_list);
    ok $result == 2;
}

func test_with_example_array_2(){
    my @example_list = ([1,2], [2,1], [1,1], [1,2], [2,2]);
    my $result = get_number_of_similar_dominos(\@example_list);
    ok $result == 3;
}

func test_with_example_array_3(){
    my @example_list = ([1,2], [2,1], [30,1], [1,30], [2,2]);
    my $result = get_number_of_similar_dominos(\@example_list);
    ok $result == 4;
}









