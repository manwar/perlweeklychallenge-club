#!/usr/bin/perl
use strict;
use Data::Dumper;

my $M = $ARGV[0];
my $maxans = $M;  #starting point
if ($ARGV[1]) {$maxans = $ARGV[1];}
my @championqueens = ();
my @cube = ();
my $index = 0;


sub setcubeempty { 
    for my $i (0..$M-1) {
        for my $j (0..$M-1) {
            for my $k (0..$M-1) {
                $cube[$i][$j][$k] = 0;
            }
        }
    }
}

sub printsite {
    for my $i (0..$M-1) {
        for my $j (0..$M-1) {
            for my $k (0..$M-1) {
                if (${$cube[$i][$j]}[$k] != -1) {
                    #print ${$cube[$i][$j]}[$k];  #For TESTING
                    print "0 ";
                } 
                else {
                    print "Q ";
                }
            }
            print "\n";
        }
        print "\n";
    }
}

sub queenpower {
    my $x = $_[0];
    my $y = $_[1];
    my $z = $_[2];
    for my $k (0..$M-1) {$cube[$x][$y][$k]++ if $k!=$z; }
    for my $k (0..$M-1) {$cube[$x][$k][$z]++ if $k!=$y; }
    for my $k (0..$M-1) {$cube[$k][$y][$z]++ if $k!=$x; }

    #plane diagonal
    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($y+$k<$M)
           and ($x+$k>=0) and ($y+$k>=0) ) {
            $cube[$x+$k][$y+$k][$z]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($z+$k<$M)
           and ($x+$k>=0) and ($z+$k>=0) ) {
            $cube[$x+$k][$y][$z+$k]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($y+$k<$M) and ($z+$k<$M)
           and ($y+$k>=0) and ($z+$k>=0) ) {
            $cube[$x][$y+$k][$z+$k]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($y-$k<$M)
           and ($x+$k>=0) and ($y-$k>=0) ) {
            $cube[$x+$k][$y-$k][$z]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($z-$k<$M)
           and ($x+$k>=0) and ($z-$k>=0) ) {
            $cube[$x+$k][$y][$z-$k]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($y+$k<$M) and ($z-$k<$M)
           and ($y+$k>=0) and ($z-$k>=0) ) {
            $cube[$x][$y+$k][$z-$k]++;
        }
    }


    #space diagonals
    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($y+$k<$M) and ($z+$k<$M)
           and ($x+$k>=0) and ($y+$k>=0) and ($z+$k>=0) ) {
            $cube[$x+$k][$y+$k][$z+$k]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($y+$k<$M) and ($z-$k<$M)
           and ($x+$k>=0) and ($y+$k>=0) and ($z-$k>=0) ) {
            $cube[$x+$k][$y+$k][$z-$k]++;
        }
    }
    
    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x+$k<$M) and ($y-$k<$M) and ($z+$k<$M)
           and ($x+$k>=0) and ($y-$k>=0) and ($z+$k>=0) ) {
            $cube[$x+$k][$y-$k][$z+$k]++;
        }
    }

    for my $k (1-$M..$M-1) {
        if (($k!=0) and ($x-$k<$M) and ($y+$k<$M) and ($z+$k<$M)
           and ($x-$k>=0) and ($y+$k>=0) and ($z+$k>=0) ) {
            $cube[$x-$k][$y+$k][$z+$k]++;
        }
    }


}

setcubeempty;




sub checkemptiness {
    my $v = $M*$M*$M;
    for my $i (0..$M-1) {
        for my $j (0..$M-1) {
            for my $k (0..$M-1) {
                if ($cube[$i][$j][$k] != 0) {
                    $v--;
                } 
            }
        }
    }
    return $v;
}

sub allqueenspower {
    if (@_) {
        my @q = @_;
        for my $c (0..($#q-2)/3) {
            $cube[$q[3*$c]][$q[3*$c+1]][$q[3*$c+2]] = -1;
            queenpower($q[3*$c], $q[3*$c+1], $q[3*$c+2] );
        }
    }
}


sub putqueen {
    my $num_of_queens = shift @_;
    my $x = shift @_;
    my $y = shift @_;
    my $z = shift @_;
    my @queens = @_;
    setcubeempty;
    allqueenspower(@_);
    if ($cube[$x][$y][$z] == 0) {
        $cube[$x][$y][$z] = -1;
        queenpower($x, $y, $z);
        my $remaining = checkemptiness;
        if ($remaining == 0) {     
            if ($num_of_queens >= $maxans) {
                $maxans = $num_of_queens+1;
                $index=0;
                @championqueens = (@_, $x, $y, $z);
            } elsif ($num_of_queens+1 == $maxans) {
                $index++;
                @championqueens = (@_, $x, $y, $z);
            }
        }
        else {
            if (($x != $M-1) || ($y != $M-1) ||  ($z != $M-1)) {
                putqueen($num_of_queens+1, nextpos($x, $y, $z), $x, $y, $z, @queens );
            } 
        }
    }
    if (($x != $M-1) || ($y != $M-1) ||  ($z != $M-1)) {
        putqueen($num_of_queens, nextpos($x,$y,$z), @queens);
    } 
}

sub nextpos {
    my ($x, $y, $z) = @_;

    $x = $x+1;
    if ($x != $M) {return ($x, $y, $z); }
    else {
        $x = 0;
        $y = $y+1;
    } 
    if ($y != $M) {return ($x, $y, $z); }
    else {
        $y = 0;
        $z = $z+1;
    }
    if ($z != $M) {return ($x, $y, $z); }
    else {die "ERROR on nextpos";}
}


sub seekans {
    if ($M==2) {
        print "1 0\n0 0\n\n0 0\n0 0\n\n number of queens: 1\n";
        exit;
    }

    setcubeempty;
    putqueen(0, 0, 0, 0);

    print "INDEX:",  $index, "\n";
    setcubeempty;
    allqueenspower @championqueens;
    printsite;
    print "number of queens: $maxans \n";
}



seekans;


=pod
time perl m-queen.pl 4
INDEX:1343
2333
2243
333Q 
3Q43

323Q 
2Q43
3453
3344

1343
2343
2422
23Q2

23Q3
1222
3323
Q433

number of queens: 7 

real	0m44.125s
user	0m44.069s
sys	0m0.016s
=cut
