#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 101
#               Task 1 - Pack a Spiral
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/27/2021 12:40:22 PM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

sub get_arr_shape {
    my $what = shift;

    # find the best dimension

    my $arr_size = scalar @$what;
    my $dimx = int(sqrt($arr_size));
    my $dimy = int($arr_size / $dimx);


    while ($arr_size % $dimx != 0) {
        $dimx--;
        $dimy = $arr_size / $dimx;
    }

    return ([$dimx, $dimy]);
}

sub get_spiral{
	my $what = shift;

    my @in_arr = @$what;

	my $dims = get_arr_shape(\@in_arr);
    my $x_max = $dims->[0];
    my $y_max = $dims->[1];

    my @pos = (0, 0);
	my $direction = ">";
	my @out_arr;
    my %seen_cells;
	while (1) {

        
		return \@out_arr unless @in_arr;

		$out_arr[$pos[0]][$pos[1]] = shift @in_arr;
        $seen_cells{$pos[0]}{$pos[1]} = 1;

		# can move in the direction we are walking?
		if ($direction eq ">") {
			if (($pos[1] + 1 < $x_max) and not ($seen_cells{$pos[0]}{$pos[1]+1})) {
				$pos[1]++;
			} else {
				$direction = "^";
                $pos[0]++;
                next;
			}
		}


		elsif ($direction eq "v") {
			if (($pos[0] - 1 >= 0 )  and not ($seen_cells{$pos[0]-1}{$pos[1]})) {
				$pos[0]--;
			} else {
				$direction = ">";
                $pos[1]++;
                next;
			}
		}

		elsif ($direction eq "<")  {
			if (($pos[1] - 1 >= 0) and not ($seen_cells{$pos[0]}{$pos[1]-1})){
				$pos[1]--;
				next;
			} else {
				$direction = "v";
                $pos[0]--;
                next;
			}
		}

		elsif ($direction eq "^") {
			if (($pos[0] + 1 < $y_max)  and not ($seen_cells{$pos[0]+1}{$pos[1]})) {
				$pos[0]++;
				next;
			} else {
				$direction = "<";
                $pos[1]--;
                next;
			}
		}
    }

    return \@out_arr;
}



sub print_the_array {
    my $what = shift;

    my $in_arr = get_spiral($what);

    my $row = scalar @$in_arr - 1;

    while ($row >= 0) {
        for (0..scalar @{$in_arr->[$row]} - 1) {
            print $in_arr->[$row][$_]." ";
        }
        $row--;
        print "\n";
    }
    print "\n";
}


print_the_array([1,2,3,4]);
print_the_array([1..6]);
print_the_array([1..12]);

use Test::More;

is_deeply(get_arr_shape([1,2,3,4]),[2,2]);
is_deeply(get_arr_shape([1..6]),[2,3]);
is_deeply(get_arr_shape([1..12]),[3,4]);
is_deeply(get_arr_shape([1..17]),[1,17]);

is_deeply(get_spiral([1,2,3,4]), [[1,2],[4,3]]);
is_deeply(get_spiral([1,2,3,4,5,6]), [[1,2],[6,3],[5,4]]);
is_deeply(get_spiral([1..12]), [[1,2,3],[10,11,4],[9,12,5],[8,7,6]]);
is_deeply(get_spiral([1..17]), [[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17]]);

done_testing;
