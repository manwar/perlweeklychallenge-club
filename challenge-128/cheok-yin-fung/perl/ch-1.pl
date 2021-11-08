#!/usr/bin/perl
# The Weekly Challenge 128
# Task 1 Maximum Sub-Matrix
# Usage: $ ch-1.pl 
use v5.12.0;
use warnings;
use List::Util qw/max/;
use Test::More tests => 5;
use Test::Deep;

my $input_bin;

$input_bin = [
    [1,1,], 
    [1,1,] 
];

say "Input:";
print_matrix($input_bin);

say "Output:";
print_matrix(max_sub_matrix($input_bin));




sub max_sub_matrix {
    my $bin = $_[0];
    my $M = scalar $bin->@*;
    my $N = 2 + scalar $bin->[0]->@*;

    my @arr_bin;
    my @arr_dec;
    for my $i (0..$M-1) {
        push @arr_bin, join("", $bin->[$i]->@*) ;
        push @arr_dec, 2**(2+$bin->[0]->$#*)+2*oct("0b".$arr_bin[$i])+1;
    }


    #  === BEGIN: use the last row as reference and initialization ===
    my $btm_line = sprintf("%0b", my_not($arr_dec[-1], $N)); 
    $btm_line =~ tr/01/ox/;
    my $max_area = contiguous_block_of_xs($btm_line);
    my $max_width = $max_area;
    my $max_height = 1;
    #  === END: use the last row as reference and initialization =====

    for my $i (0..$M-2) {

        my $temp = $arr_dec[$i];
        my $tmp_temp = sprintf("%0b", my_not($temp, $N)); 
        $tmp_temp =~ tr/01/ox/;

    #  ====== BEGIN: whether the i-th row contains a large number of x's ===
        my $the_row_ones = contiguous_block_of_xs($tmp_temp);
        if ($the_row_ones > $max_area) {
            $max_height = 1;
            $max_width = $the_row_ones;
            $max_area = $the_row_ones;
        }
    #  ====== END: whether the i-th row contains a large number of x's =====

    #  === BEGIN: check from the next row to the bottom of the matrix ===
        for my $j ($i+1..$M-1) {
            $temp = not_or( $temp, $arr_dec[$j], $N);      
        
            my $x = sprintf("%0b",$temp);  
            $x =~ tr/01/ox/;
            my $this_height = $j-$i+1;
            my $this_width = contiguous_block_of_xs($x);
 
            my $this_area = $this_width * $this_height;
            if ($this_area > $max_area) {
                $max_height = $this_height;
                $max_width = $this_width;
                $max_area = $this_area;
            }

    #  ============ BEGIN: preparation for next loop ================
            $temp = ~$temp;  
    #  ============ END: preparation for next loop ==================
    #  === END: check from the next row to the bottom of the matrix ===

        }
    }
    return zeros($max_height, $max_width) if $max_area > 0;
    return [];
}



sub zeros {
    my $height = $_[0];
    my $width = $_[1];
    my @a;
    for (1..$height) {
        push @a, [('0') x $width];
    }
    return [@a]; 
}



sub contiguous_block_of_xs {
    my @arr = split //, $_[0];
    my @ans;
    my $counter = 0;
    while ( $counter < scalar @arr ) {
        my $i = 0;
        $ans[$counter] = 0;

        while (defined($arr[$counter+$i]) && $arr[$counter+$i] eq "x") {
            $ans[$counter]++;
            $i++;
        }
        $counter++;
    }
    return max( @ans ) if scalar @ans > 0;
    return 0;
}



sub my_not {
    my $N = $_[1];
    return ~$_[0] & (2**($N-1)-1);
}



sub not_or {
    my $N = $_[2];
    return ~($_[0] | $_[1]) & (2**($N-1)-1) ;
}


sub print_matrix {
    my $m = $_[0];
    say "[", (join " ", $m->[$_]->@*), "]" for (0..$m->$#*);
    say "[]" if scalar $m->@* == 0;
}



cmp_deeply(
    max_sub_matrix(
        [[1,0,0,0,1,0,],
         [1,1,0,0,0,1,],
         [1,0,0,0,0,0,]]
    ) ,
    [ [0,0], [0,0] ,[0,0] ],
    "Example 1",
);


cmp_deeply(
    max_sub_matrix(
       [[ 0,0,1,1 ],
        [ 0,0,0,1 ],
        [ 0,0,1,0 ]]
    ) ,
    [ [0,0], [0,0] ,[0,0] ] ,
    "Example 2"
);


cmp_deeply(
    max_sub_matrix(
       [[ 0,1,1,1 ],
        [ 0,0,0,0 ],
        [ 1,1,1,0 ]]
    ) ,
    [ [0,0,0,0] ] ,
    "Test 1"
);


cmp_deeply(
    max_sub_matrix(
        [ [1,0,0,0,1,0,],
          [1,1,0,0,0,1,],
          [1,0,0,0,0,0,],
          [1,0,0,0,0,0,] ]
    ) ,
    [ [0,0,0,0,0], [0,0,0,0,0]],
    "Test 2",
);


cmp_deeply(
    max_sub_matrix(
       [  [qw/0 1 1 1 0 1 0 1/],
          [qw/0 1 0 0 0 1 1 0/],
          [qw/1 1 1 0 1 1 1 1/],
          [qw/0 1 1 1 1 0 0 0/],
          [qw/1 1 1 1 0 0 0 0/],
          [qw/0 0 0 1 0 0 0 0/],
          [qw/0 0 1 1 1 0 1 1/],
          [qw/0 0 1 1 1 0 0 0/] ]
    ),
    [ [0,0,0,], [0,0,0,], [0,0,0,]],
    "Test 3"
);
