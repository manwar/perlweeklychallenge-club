#!/usr/bin/env raku
#`{
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-08
Challenge 211 Toeplitz Matrix ( Raku )
-------------------------------------------
}

my @matrix = [ [4, 3, 2, 1],[5, 4, 3, 2],[6, 5, 4, 3], ];

#my @matrix = [ [1,2,3],[3,2,1], ];

my $rows = @matrix.elems;
my $cols = @matrix[0].elems;


my $r = 0;
my $c = 0;
my @out = ();
my $flag = 0;

sub CheckDiag(@o) {
    if @o.unique.elems != 1 {
        $flag = -1;
    }
}

sub Diag($c is copy,$r is copy) {
    @out = ();
    while $r < $rows {
        @out.push: @matrix[$r][$c];
        if $r == $rows - 1 {
            CheckDiag(@out);
            return;
        } else {
            if $c == $cols - 1 {
                CheckDiag(@out);
                last;
            }
            $c++;
            $r++;
        }
    }
}

say "Input matrix = ",@matrix;

$c = 0;
$r = 0;
while $c < $cols - 1 {
    Diag($c,$r);
    $c++;
}

$r = 1;
$c = 0;
while $r < $rows - 1 {
    Diag($c,$r);
    $r++;
}

$flag == -1 ?? say "Output: false" !! say "Output: true";

#`{
-------------------------------------------
SAMPLE OUTPUT
Input matrix = [[4 3 2 1] [5 4 3 2] [6 5 4 3]]
Output: true

Input matrix = [[1 2 3] [3 2 1]]
Output: false
-------------------------------------------
}


