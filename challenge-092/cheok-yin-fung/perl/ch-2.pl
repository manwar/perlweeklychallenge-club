#!/usr/bin/perl
# The Weekly Challenge 092
# Task 2 Insert Interval
use strict;
use warnings;
use Test::More tests => 3;
use Test::Deep;

my $MAXLIM =  10000;
my $MINLIM = -10000;

my @input = ([1,5], [7,9]);
my $new_intv = [ shift @ARGV, shift @ARGV ] ;
my @result = @{insert_interval(\@input, $new_intv)};

print "before insertion: " ; print_couples(@input);
print "after insertion : " ; print_couples(@result);


sub insert_interval {
    my @S = @{$_[0]};
    my @result;
    my $N = $_[1];

    unshift @S, [$MINLIM, $S[0]->[0] - 1 ];
    push @S, [$S[-1]->[1] + 1 , $MAXLIM];

    my $i = -1;
    my $j;

    do { $i++; } while ( $i <= $#S-1 && 
            $N->[0] >= $S[$i+1]->[0] );
    if ($N->[0] > $S[$i]->[1]) {$i++;}

    $j = $i-1;

    do { $j++; } while ( $j <= $#S-1 && 
           $N->[1] >= $S[$j+1]->[1]);

    if ($j < $#S && $N->[1] >= $S[$j+1]->[0]) {$j++;}

    #    print "$i   $j\n";  #testing line 

    if ($i == 0 and $j == $#S) {
        push @result, $N;
    }
    elsif ($i == $j and $j == 0) {
        shift @S;
        unshift @S, $N; 
        pop @S;
        @result = @S;
    } elsif ($i == 0 and $j <= $#S-1) {
        push @result, [
            $N->[0], 
            ($N->[1] > $S[$j]->[1]) ? $N->[1] : $S[$j]->[1] 
        ];
        for my $k ($j+1..$#S-1) {
            push @result, $S[$k];
        }
    } elsif ($i > 0 and $j <= $#S-1) {
        for my $k (1..$i-1) {
            push @result, $S[$k];
        }
        push @result, [
            ($N->[0] < $S[$i]->[0]) ? $N->[0] : $S[$i]->[0] ,
            ($N->[1] > $S[$j]->[1]) ? $N->[1] : $S[$j]->[1] ];
        for my $k ($j+1..$#S-1) {
            push @result, $S[$k];
        }
    } elsif ($i < $#S and $j == $#S) {
        for my $k (1..$i-1) {
            push @result,  $S[$k]  ;
        }
        push @result, [ 
            ($N->[0] < $S[$i]->[0]) ? $N->[0] : $S[$i]->[0] ,
             $N->[1]
         ];

    } elsif ($i == $j and $j == $#S) {
        shift @S;
        pop @S;
        push @S, $N;
        @result = @S;
    }


    return \@result;
}

sub print_couples {
    my @r = @_;
    my $a = pop @r; 
    for (@r) {
        print "(", $_->[0], "," ,$_->[1], "), ";
    }
    print "(", $a->[0],"," ,$a->[1], ")", "\n";
}


cmp_deeply( 
    insert_interval([([1,4], [8,10])], [2,6]), 
    [[1,6],[8,10]] , 
    "Example 1" 
);
cmp_deeply( 
    insert_interval([[1,2], [3,7], [8,10]], [5,8]),
    [[1,2],[3,10]] ,
    "Example 2"
);
cmp_deeply(
    insert_interval([[1,5], [7,9]], [10,11]),
    [[1,5],[7,9],[10,11]],
    "Example 3"
);
