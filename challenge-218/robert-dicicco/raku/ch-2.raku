#!/usr/bin/env raku
#---------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-26
# Challenge 218 MatrixScore.py ( Raku )
#---------------------------------------------
use v6;

my @matrix = [ [0,0,1,1],
           [1,0,1,0],
           [1,1,0,0], ];

sub ShowMatrix() {
    my $total = 0;
    my $cnt = 0;
    while $cnt <= 2 {
        say (@matrix[$cnt]);
        $total += binary_to_decimal(@matrix[$cnt]);
        $cnt++;
    }
    say "Total = ",$total;
    say "";
}

sub binary_to_decimal(@binary_array) {
    my $decimal = 0;
    my $power = @binary_array.elems - 1;
    for (@binary_array) -> $digit {
        $decimal += $digit * (2 ** $power);
        $power -= 1;
    }
    return $decimal;
}

sub ToggleRow($r, $ov) {
    my @testmat = [];
    my $col = 0;
    while $col <= 3 {
        my $x = @matrix[$r][$col++];
        $x == 0 ?? @testmat.push: 1 !! @testmat.push: 0;
    }
    my $testval = binary_to_decimal(@testmat);
    if $testval > $ov {
        say "Toggled row ",$r;
        @matrix[$r] = @testmat;
        ShowMatrix();
    }
}

sub ToggleCol($c) {
    my $ov = GetColVal($c);
    my $row = 0;
    my @testmat = [];
    my $testval = 0;
    while $row < 3 {
        @matrix[$row][$c] == 0 ?? @testmat.push: 1 !! @testmat.push: 0;
        $row++;
        $testval = binary_to_decimal(@testmat);
    }
    if $testval > $ov {
        for 0..3 -> $x {
            @matrix[$x][$c] = @testmat[$x];
        }
        print("Toggled column ",$c,"\n");
        ShowMatrix();
    }
}

sub GetColVal($c) {
    my @testmat = [];
    my $row = 0;
    while $row < 3 {
        @testmat.push: @matrix[$row][$c];
        $row++;
    }
    my $colval = binary_to_decimal(@testmat);
    return $colval;
}


####################################################
ShowMatrix();

for 0..2 -> $myrow {
    my $bd = binary_to_decimal(@matrix[$myrow]);
    ToggleRow($myrow, $bd);
}

for (0..3) -> $myrow {
    ToggleCol($myrow);
}

=begin comment
#---------------------------------------------
SAMPLE OUTPUT
raku .\MatrixScore.rk
[0 0 1 1]
[1 0 1 0]
[1 1 0 0]
Total = 25

Toggled row 0
[1 1 0 0]
[1 0 1 0]
[1 1 0 0]
Total = 34

Toggled column 2
[1 1 1 0]
[1 0 0 0]
[1 1 1 0]
Total = 36

Toggled column 3
[1 1 1 1]
[1 0 0 1]
[1 1 1 1]
Total = 39
#---------------------------------------------
=end comment
