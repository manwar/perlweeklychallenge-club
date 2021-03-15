use strict;
no warnings;
use experimental 'switch';

my $S1 = $ARGV[0] ? $ARGV[0] : "sunday";
die "Please input two parameters. " if (!$ARGV[1] && $ARGV[0]);
my $S2 = $ARGV[1] ? $ARGV[1] : "monday";

print "$S1 -> $S2\n\n";

edit_dis($S1, $S2);

sub edit_dis {
    my $d;
    my $op_d;
    my $pre_d;
    my @A = ( '|' , (split //, $_[0]));  # "|" is a dummy variable
    my @B = ( '|' , (split //, $_[1]));
    my $n = scalar @A;
    my $m = scalar @B;
    
    $d->[0][0] = 0;
    $op_d->[0][0] = undef;
    $pre_d->[0][0] = undef;
    
    for my $i (1..$n-1) {
        $d->[$i][0] = $i;
        $op_d->[$i][0] = "insert";
        $pre_d->[$i][0] = [$i-1, 0];
    }

    for my $j (1..$m-1) {
        $d->[0][$j] = $j;
        $op_d->[0][$j] = "insert";
        $pre_d->[0][$j] = [0,$j-1];
    }
    
    for my $j (0..$m-1) {
        for my $i (0..$n-1) {
            my $op;
            my $pre;
            #1st step: check match/mismatch
            if ($A[$i] eq $B[$j]) {
                $op = "match"; 
                if ($i > 0 && $j > 0) {
                    $d->[$i][$j] = $d->[$i-1][$j-1];
                    $pre = [$i-1, $j-1];
                } elsif ($i>0) {
                    $d->[$i][$j] = $d->[$i-1][$j];
                    $pre = [$i-1, $j];
                } elsif ($j>0) {
                    $d->[$i][$j] = $d->[$i][$j-1];
                    $pre = [$i, $j-1];
                } else {
                    $d->[$i][$j] = 0;
                    $pre = undef;
                }
            } else {
                $op = "replace"; 
                if ($i != 0 && $j != 0) {
                    $d->[$i][$j] = $d->[$i-1][$j-1] + 1;
                    $pre = [$i-1, $j-1];
                }
                elsif ($i > 0) {
                    $op = "delete";
                    $d->[$i][$j] = $d->[$i-1][$j] + 1;
                    $pre = [$i-1, $j];
                }
                elsif ($j > 0) {
                    $op = "insert";
                    $d->[$i][$j] = $d->[$i][$j-1] + 1;
                    $pre = [$i, $j-1];
                }
                else {
                    $op = "ID";
                    $d->[$i][$j] = 1;
                    $pre = undef;
                }
            }

            # 2nd step: check if "insert" is efficient
            if ($j > 0 && $d->[$i][$j] > $d->[$i][$j-1]+1) {
                $op = "insert";
                $d->[$i][$j] = $d->[$i][$j-1]+1; 
                $pre = [$i, $j-1];
            }

            # 3rd step check if "delete" is efficient
            if ($i > 0 && $d->[$i][$j] > $d->[$i-1][$j]+1) {
                $op = "delete";
                $d->[$i][$j] = $d->[$i-1][$j]+1; 
                $pre = [$i-1, $j];
            }

            $op_d->[$i][$j] = $op;
            $pre_d->[$i][$j] = $pre;

        }
    }

    print "Edit distance: ", $d->[$n-1][$m-1], "\n\n";


    my @seq_op;
    my @abcA_op;
    my @abcB_op;
    my $sA = $n-1;
    my $sB = $m-1;
    while ($sA >= 0 && $sB >= 0 && defined $pre_d->[$sA][$sB]) {
        if ($op_d->[$sA][$sB] ne "match") {
            unshift @seq_op, $op_d->[$sA][$sB];
            unshift @abcA_op, $sA;
            unshift @abcB_op, $sB;
        }
        ($sA,$sB) = @{$pre_d->[$sA][$sB]};
    } 

    if ( scalar @seq_op == 0 ) {print "same word\n"; exit;}
    
    for my $k (0..$#seq_op) {
        print "Operation ",$k+1,": ";
        given ($seq_op[$k]) {
            when (/replace/) {
                print "replace the \'$A[$abcA_op[$k]]\' by \'$B[$abcB_op[$k]]\'";
            }
            when (/insert/) {
                if ($A[$abcA_op[$k]] ne "|") {
                    my $bef;
                    $bef = ($abcA_op[$k] <= $abcB_op[$k]) ? "after" : "before";
                    print "insert \'$B[$abcB_op[$k]]\' $bef the \'$A[$abcA_op[$k]]\'";
                } 
                else {
                    print "insert \'$B[$abcB_op[$k]]\' at the front";
                }
            }
            when (/delete/) {
                if ($B[$abcB_op[$k]] ne "|") {
                    my $bef;
                    $bef = ($abcA_op[$k] => $abcB_op[$k]) ? "after" : "before";
                    print "delete the \'$A[$abcA_op[$k]]\' $bef the \'$B[$abcB_op[$k]]\'";
                } 
                else {
                    print "delete the \'$A[$abcA_op[$k]]\' at the front.";
                }
            }
        };
        print "\n";

    }
    print "\nDONE!\n";
    return $d->[$n-1][$m-1];

}


