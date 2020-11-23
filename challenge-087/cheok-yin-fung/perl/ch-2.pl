#!/usr/bin/perl
# very similar to #084 Find Squares Task
use strict;
use warnings;
#use Test::More tests => 8;
#Usage: ch-2.pl [matrix height] [matrix width] [matrix entries]
#Example: 
#input: ch-2.pl  10 6 0 1 1 1 0 0 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 0 0 1 1 1 1 0 1 0 1 0 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 

#output: 2x3 matrix with every entry 1

sub print_matrix {
    my @mat = @{$_[0]};  
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};
    for my $j (0..$M-1) {
        print "[", join(", ", @{$mat[$j]}), "]" ;
        print "\n";
    }
}

sub find_rect {
    my @mat = @{$_[0]};  
    my $nsq = 0;
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};
    my $largest_area = 0;
    my $rect_width;
    my $rect_height;

    for my $i (0..$N-2) {
        for my $j (0..$M-2) {
            for my $k (reverse $i+1..$N-1) {
                if (all_ones(\@mat,$i,$k,$j)) {
                    for my $l (reverse $j+1..$M-1) {
                        if (($k-$i+1)*($l-$j+1) > $largest_area) {
                            my $count = $l;
                            my $bool;
                            do {
                                $bool = all_ones(\@mat, $i, $k, $count);
                                $count = $count-1;
                            } while ($count > $j && $bool);
                            if ($bool and $count==$j) {
                                $largest_area = ($k-$i+1)*($l-$j+1);
                                $rect_width = $k-$i+1;
                                $rect_height = $l-$j+1;
                            }
                        }
                    }
                }
            }     
        }
    }

    if ($largest_area > 0) {
        print "\n\n";
        for my $j (1..$rect_height) {
            print "[";
            for my $i (1..$rect_width-1) {
                print "1 "
            }
            print "1]\n";
        } 
        print "area:", $largest_area, "\n"; # Testing Lines
    }

    return $largest_area;
}

sub all_ones {
    my @mat = @{$_[0]};
    my $start_col = $_[1];
    my $end_col = $_[2];
    my $row = $_[3];
    my $count = $start_col;
    while ( $count <= $end_col && ${$mat[$row]}[$count]) {
        $count++;
    }
    if ($count==$end_col+1) { 
        return 1;
    } else 
    {
       return undef;
    } 
}

if ($ARGV[0]) {
    my @f = @ARGV;
    my $M = shift @f;
    my $N = shift @f;
    my @matrix = ();
    die "Input Parameters Error" unless scalar @f == $M*$N;
    for my $j (0..$M-1) {
        push @matrix , [ @f[$N*$j..$N*$j+$N-1] ]; 
    }
    print_matrix([@matrix]);
    print 0, "\n" if !(find_rect([@matrix]));
}


=pod
ok(find_rect([[ 0,1,0,1 ], [ 0, 0, 1,0 ], [ 1, 1 ,0 ,1],[1, 0, 0, 1 ]] )== 0,
    "Test Case 1");
ok(find_rect([[ 1 ,1, 0, 1 ], [ 1, 1 ,0 ,0 ],  [ 0, 1, 1 ,1 ],  [ 1, 0, 1, 1 ]]
    )== 4,  "Test Case 2");
ok(find_rect([[ 0 ,1 ,0 ,1 ], [ 1, 0 ,1 ,0 ], [ 0 ,1 ,0 ,0 ], [ 1, 0 ,0 ,1 ]]
    ) == 0,  "Test case 3");
ok(find_rect([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]]
    ) == 16, "a 4x4 matrix with every entry being 1");

ok(find_rect([[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1]]
    ) == 15, "a 3x5 matrix with every entry being 1");

ok(find_rect([
    [ 0,0,0,1,0,0,],
    [ 1,1,1,0,0,0,],
    [ 0,0,1,0,0,1,],
    [ 1,1,1,1,1,0,],
    [ 1,1,1,1,1,0,]]) == 10, "Example 1");

ok(find_rect([
    [ 1,0,1,0,1,0,],
    [ 0,1,0,1,0,1,],
    [ 1,0,1,0,1,0,],
    [ 0,1,0,1,0,1,]]) == 0, "Example 2");

ok(find_rect([
    [ 0,0,0,1,1,1],
    [ 1,1,1,1,1,1],
    [ 0,0,1,0,0,1],
    [ 0,0,1,1,1,1],
    [ 0,0,1,1,1,1]]) == 8, "Example 3");
=cut
