#!/usr/bin/perl
# The Weekly Challenge 
# Task 1 Self-descriptive numbers
# Usage: $ ch-1.pl N
#        first N self-descriptive numbers

use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations combinations);
use Integer::Partition;

my $COUNT = $ARGV[0] || 3;

# math: ref to "the twelvefold way"
sub n_multisubset_of_X {
    my $n = $_[0];
    my $sum = $_[1];
    my %hash; 
    my $i = Integer::Partition->new($sum);
    
    while (my $partition = $i->next) {
        my @p = permutations($partition);
        foreach my $subp (@p) {
            $hash{join "," , @$subp} = 1 if scalar @$subp == $n;
        }
    }
    my @ans;
    foreach my $subp (keys %hash) {
        push @ans, [split "," , $subp];
    }
    return @ans;
}

# boolean subroutine check whether a number is self-descriptive
sub check_descr {
    my @digit = split "", $_[0];
    my $k = 0;
    my $is_self_descr = 1;

    while ($is_self_descr && $k <= $#digit ) {
        my $check = 0;
        for (@digit) {
            $check++ if $_ == $k;
        }
        $is_self_descr = ($is_self_descr && $digit[$k] == $check); 

        $k++;
    }

    return $is_self_descr;
}






# ============== MAIN ==================

my @self_descr_num = ();

my $length = 3;
while (scalar @self_descr_num < $COUNT && $length <= 10) {
    my $z_num = $length-1;
    while ($z_num > 0 && scalar @self_descr_num < $COUNT) {
        my @z_positions = combinations([1..$length-1], $z_num);
        my @non_z = n_multisubset_of_X( 
                        $length - $z_num - 1 ,
                        $length - $z_num);
        foreach my $nz (@non_z) {
            foreach my $zp (@z_positions) {
                my @my_non_z = @$nz;
                my @dc;
                $dc[0] = $z_num;
                $dc[$_] = -1 for 1..($length-1);
                $dc[$_] = 0 for @$zp;
                for (1..$length-1) {
                    if ($dc[$_] == -1) {
                        $dc[$_] = shift @my_non_z;
                    }
                } 
                my $candidate = join "", @dc; 
                push @self_descr_num, $candidate if check_descr($candidate);
            }
        }

        $z_num--;
    }
    $length++
}


@self_descr_num = sort {$a<=>$b} @self_descr_num;

print join "\n", @self_descr_num[0..$COUNT-1];
print "\n";



