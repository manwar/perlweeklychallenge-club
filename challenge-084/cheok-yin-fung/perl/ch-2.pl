#!/usr/bin/perl
use strict;
use warnings;
#use Test::More tests => 4;
#use Data::Dumper;

if ($ARGV[0]) {
    my @f = @ARGV;
    my $M = shift @f;
    my $N = shift @f;
    my @matrix = ();
    die "Input Parameters Error" unless scalar @f == $M*$N;
    for my $counter (0..$M-1) {
        push @matrix , [ @f[$N*$counter..$N*$counter+$N-1] ]; 
    }

#    print Dumper(@matrix);
    print_matrix([@matrix]);
    print 'ans: ', find_sq([@matrix]), "\n"; 
} 
else {
    for(1..3) {
        print "[1,1,1,1]";
        print "\n";
    }
     print 'ans: ', find_sq([[1,1,1,1],[1,1,1,1],[1,1,1,1]]), "\n";  
     #all 1s, should be 8
}


sub print_matrix {
    my @mat = @{$_[0]};  
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};
    for my $i (0..$M-1) {
        print "[", join(", ", @{$mat[$i]}), "]" ;
        print "\n";
    }
}

sub find_sq {
    my @mat = @{$_[0]};  
    my $nsq = 0;
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};
    
    for my $i (0..$M-2) {
        for my $j (0..$N-2) {
            my $max_len_sq = $M-$i < $N-$j ? $M-$i : $N-$j;  #sign of the ineq
            for my $k (2..$max_len_sq) {
                $nsq++ if bool_contain_sq([@mat], $i, $j, $k);
            }     
        }
    }

    return $nsq;

}

sub bool_contain_sq {
    my @mat = @{$_[0]};
    my $r = $_[1];
    my $c = $_[2];
    my $len_side = $_[3];

    return (${$mat[$r]}[$c] && ${$mat[$r+$len_side-1]}[$c] &&
         ${$mat[$r]}[$c+$len_side-1] && ${$mat[$r+$len_side-1]}[$c+$len_side-1] );
}


=pod
ok(find_sq([[ 0,1,0,1 ], [ 0, 0, 1,0 ], [ 1, 1 ,0 ,1],[1, 0, 0, 1 ]] )== 1,
    "Example 1");
ok(find_sq([[ 1 ,1, 0, 1 ], [ 1, 1 ,0 ,0 ],  [ 0, 1, 1 ,1 ],  [ 1, 0, 1, 1 ]] 
    )== 4,  "Example 2");
ok(find_sq([[ 0 ,1 ,0 ,1 ], [ 1, 0 ,1 ,0 ], [ 0 ,1 ,0 ,0 ], [ 1, 0 ,0 ,1 ]]
    ) == 0,  "Example 3");
ok(find_sq([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]]
    ) == 14, "a 4x4 matrix with every entry being 1");
=cut
