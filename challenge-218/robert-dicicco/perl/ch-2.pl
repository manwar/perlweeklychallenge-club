#!/usr/bin/env perl
#---------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-27
# Challenge 218 MatrixScore.py ( Perl )
#---------------------------------------------
use strict;
use warnings;
use feature 'say';

my @matrix = ( [0,0,1,1],
             [1,0,1,0],
             [1,1,0,0] ) ;

sub GetColVal {
    my $c = shift;
    my @testmat = ();
    my $row = 0;

    while ($row < 3) {
        push(@testmat, $matrix[$row][$c]);
        $row++;
    }

    my $colval = binary_to_decimal(\@testmat);
    return $colval;
}


sub ToggleCol {
    my $c = shift;
    my $ov = GetColVal($c);
    my $row = 0;
    my @testmat = ();
    my $testval = 0;
    while ($row < 3) {
        my $x = $matrix[$row][$c];
        $x == 0 ? push(@testmat,1) : push(@testmat,0);
        $row++;
        $testval = binary_to_decimal(\@testmat);
    }
    if ($testval > $ov) {
        my $x = 0;
        while ($x < 4) {
            $matrix[$x][$c] = $testmat[$x];
            $x++;
        }
        print("Toggled column ",$c+1,"\n");
        ShowMatrix();
    }
}

sub ToggleRow {
    my $r = shift;
    my $ov = shift;
    my @testmat = ();
    my $col = 0;
    while ($col <= 3) {
        my $x = $matrix[$r][$col];
        $x == 0 ? push(@testmat,1) : push(@testmat,0);
        $col++;
    }
    my $testval = binary_to_decimal(\@testmat);
    if ($testval > $ov){
        @{$matrix[$r]} = @testmat;
        say "Toggle row ",$r+1;
        ShowMatrix();
    }
}

sub binary_to_decimal {
    my $b = shift;
    my @binary_array = @{$b};
    my $decimal = 0;
    my $power = scalar @binary_array - 1;
    for my $digit (@binary_array) {
        $decimal += $digit * (2 ** $power);
        $power -= 1;
    }
    return $decimal;
}

sub ShowMatrix {
    my $total = 0;
    my $cnt = 0;

    while ($cnt < 3) {
        print("@{$matrix[$cnt]}\n");
        $total += binary_to_decimal($matrix[$cnt]);
        $cnt++;
    }
    say "Total = ",$total;
    say "";
}

ShowMatrix();
my $myrow = 0;
while ($myrow < 3) {
    my $bd = binary_to_decimal($matrix[$myrow]);
    ToggleRow($myrow,$bd);
    $myrow++;
}

my $mycol = 0;
while($mycol < 4) {
    ToggleCol($mycol);
    $mycol++;
}

#---------------------------------------------
# SAMPLE OUTPUT
# perl .\MatrixScore.pl
# 0 0 1 1
# 1 0 1 0
# 1 1 0 0
# Total = 25

# Toggle row 1
# 1 1 0 0
# 1 0 1 0
# 1 1 0 0
# Total = 34

# Toggled column 3
# 1 1 1 0
# 1 0 0 0
# 1 1 1 0
# Total = 36

# Toggled column 4
# 1 1 1 1
# 1 0 0 1
# 1 1 1 1
# Total = 39
#---------------------------------------------


