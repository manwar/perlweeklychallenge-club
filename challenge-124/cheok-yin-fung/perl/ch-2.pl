#!/usr/bin/perl
# The Weekly Challenge - 124
# Task 2 Tug of War
# Usage: ch-2.pl @input
use strict;
use warnings;
use List::Util qw/sum any max min first/;
use v5.10.0;
use Test::More tests => 6;
use Data::Dumper;
use experimental 'switch';

my @in = @ARGV;
@in = (1, 2, 4, 5, 7, 8) if !defined($ARGV[0]);

die "At least 2 terms.\n" unless scalar @in > 1;

if (scalar @in >= 5 ) {
    say_ans_for_tug_of_war( tug_of_war([@in])->@* );
}
else { 
    say_ans_for_tug_of_war( tug_of_small_war([@in])->@* );
}



sub tug_of_small_war {
    my @inp = $_[0]->@*;
    @inp = sort {$a<=>$b} @inp;
    given(scalar @inp) {
        when (4) { return [ [$inp[0], $inp[3]] , [ $inp[1], $inp[2] ] ];  
                 }
        when (2) { return [ [$inp[0]] , [$inp[1]] ]; 
                 }
        when (3) {
                  my $sum01 = $inp[0]+$inp[1];
                  my $sum02 = $inp[0]+$inp[2];
                  my $sum12 = $inp[1]+$inp[2];
                  if (abs($sum01-$inp[2])<=abs($sum02-$inp[1])) {
                      return [ [$inp[0], $inp[1] ] , [ $inp[2] ] ] 
                          if abs($sum12-$inp[0]) >= abs($sum01-$inp[2]);  
                  }
                  else { 
                      return [ [$inp[0], $inp[2] ] , [ $inp[1] ] ]  
                          if abs($sum12-$inp[0]) >= abs($sum02-$inp[1]);  
                  }
                  return [ [$inp[1], $inp[2] ] , [ $inp[0] ] ];  
                 }
    } 
}



sub tug_of_war { 
    my @S = $_[0]->@*;
    warn "At least 5 terms for this subroutine.\n" unless scalar @S >= 5;
    my ($mark1, $mark2);

    my $s = sum @S;

    my $odd_term = scalar @S % 2 == 1;
    my $odd_sum  = $s % 2 == 1;

    if ($odd_sum) {
        $mark1 = $s >= 0 ? int ($s / 2) : ($s-1)/2;
        $mark2 = 1 + $mark1;
    } 
    else {
        $mark1 = $s / 2;
        $mark2 = $mark1;
    }

    @S = sort {$a<=>$b} @S;

    my (@arr0, @arr1);

    for (0..$#S) {
        if ($_ % 2 == 0) {
            push @arr0, $S[$_]; 
        } else {
            push @arr1, $S[$_];
        }
    }

    my $sum_initial = sum @arr0;

    my ($diff_arr_h, $diff_arr_m);



    my $temp_m = min ($#arr1, int $#S/2);
    $diff_arr_h = [map { $arr1[$_] - $arr0[$_-1] } (1..$#arr1)];
    $diff_arr_m = [map { $arr1[$_] - $arr0[$_] } (0..$temp_m)];

=pod
  #  TESTING INFO
    say "@S";
    print "sum of \@S: ", $s, "\n";
    say "sum of \@arr0: ", $sum_initial;
    print "sum of \@arr1: ", (sum @arr1), "\n"; 
    say "mark(s): ", $mark1, " ", $mark2;
    say "arr0: ", "@arr0";
    say "arr1: ", "@arr1";
    say " h  :   @{$diff_arr_h}";
    say " m  : @{$diff_arr_m}";
=cut 
    if ($odd_term) {
        if (2*$sum_initial > $s) {
            # if $S[-1] is relatively large # example: -1 -2 3 4 5
            #  then use the map {-$_} and call tug_of_war again
            my ( $na0, $na1 ) = tug_of_war([map { -$_ } @S])->@*;
            # "used odd term and large last term method";
            return [ [ reverse map {-$_} $na0->@*  ] , [ reverse map {-$_} $na1->@* ]  ];
        }
        elsif (2*$sum_initial == $s) {
            return [ [@arr0], [@arr1] ]; 
        }
    }

    my $soln_h = closest_sum_to_target( 
                    $diff_arr_h, 
                    $mark1 - $sum_initial, 
                    $mark2 - $sum_initial, 
                 ); 
    my $soln_m = closest_sum_to_target( 
                    $diff_arr_m, 
                    $mark1 - $sum_initial, 
                    $mark2 - $sum_initial, 
                 ); 
    if ($soln_m->[1] <= $soln_h->[1]) {
        foreach (@{$soln_m->[0]}) {
            # "use m"
            my $temp_c = $arr0[$_];
            $arr0[$_] = $arr1[$_];
            $arr1[$_] = $temp_c;
        }
    }
    else {
        foreach (@{$soln_h->[0]}) {
            # "use h";
            my $temp_c = $arr0[$_];
            $arr0[$_] = $arr1[1+$_];
            $arr1[$_+1] = $temp_c;
        }
    }
    return [ [@arr0], [@arr1] ];
}



sub say_ans_for_tug_of_war {
    my @a0 = $_[0]->@*;
    my @a1 = $_[1]->@*;
    say "TOTAL: " , sum(@a0, @a1);
    say "";
    say "(", "@a0", ") ==> ", sum @a0;
    say "(", "@a1", ") ==> ", sum @a1;
}



sub closest_sum_to_target {
    my @array = $_[0]->@*;
    my $target1 = $_[1];
    my $target2 = $_[2];
    warn "\$target1 should be smaller or equal to \$target2" if $target1 > $target2;
    my $exact = undef;
    my %indices_to_values = ( [] => 0 );
    my $generation_aged = [ [] ];
    my $generation_new = [];
    my $current_sum_smaller;
    my $current_ind_smaller;
    my $current_sum_larger;
    my $current_ind_larger;
    my $n = 0;
    while ( !$exact && $n < scalar @array ) {
        foreach my $arr ($generation_aged->@*) {
            foreach my $i (0..$#array) {
               # check_if_@array_contain_i, _if_yes_then_next__
                next if any { $_ == $i } $arr->@*;
                my $arr_cp = $n>0 ? [$arr->@*] : [] ;
                push $arr_cp->@*, $i;
                my $my_sum = $array[$i];
                if ($n > 0) {
                    $my_sum += $indices_to_values{$arr};
                }
               # check_if_values_of_hash_indices_to_values_contain_i, _if_yes_then_next__
                next if any { $_ == $my_sum && $_ != 0 } values %indices_to_values;    #[*]
                push $generation_new->@*, $arr_cp;
                $indices_to_values{$arr_cp} = $my_sum;
                if ($my_sum == $target1 || $my_sum == $target2) {
                    $exact = $arr_cp;
                }
                elsif ($my_sum < $target1) {
                    if (!defined($current_sum_smaller) || $current_sum_smaller < $my_sum) {
                        $current_sum_smaller = $my_sum; 
                        $current_ind_smaller = $arr_cp;
                    }
                }
                elsif ($my_sum > $target2) {
                    if (!defined($current_sum_larger) || $my_sum < $current_sum_larger) {
                        $current_sum_larger = $my_sum; 
                        $current_ind_larger = $arr_cp; 
                    }
                }
                last if defined($exact);
            }
            last if defined($exact);
        }
        $generation_aged = $generation_new;
        $generation_new = [];
        $n++;
    }

    # return [ [@arr of inpd] => sum of values , diff to the target ]
    if (defined($exact)) {
        return [ $exact, 0 ]; 
    } 
    else {
       # "No exact solutions."
        my $temp_smaller = $current_sum_smaller;
        my $temp_larger = $current_sum_larger;
        if ( defined($temp_smaller) && 
                (    !defined($temp_larger)
                  || (($target1 - $temp_smaller) <= ($temp_larger - $target2)) 
                )
           ) {
            return [ 
                $current_ind_smaller, 
                $target1 - $temp_smaller
            ];
        }
        else {
            return [ 
                $current_ind_larger, 
                $temp_larger - $target2
            ];
        }
    }
}



say "";
say "TEST";
ok (manual_test([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], 10), "Example Set 1");
ok (manual_test([10, -15, 20, 30, -25, 0, 5, 40, -5], 0), "Example Set 2");
ok (manual_test([1..100], 0), "natural numbers");
ok (manual_test([-26, -2, 3, 4, 5], 18), "a big negative");
ok (manual_test([-1, -2, 3, 4, 11], 1), "a big positive");
ok (manual_test([-1, 0, 0, 1, 5], 3), "-1 and 0,0,1,5");

sub manual_test {
    my @set = $_[0]->@*;
    my $expected_diff = $_[1];
    my $script_ans = tug_of_war( [@set] );
    my @subset0 = $script_ans->[0]->@*;
    my @subset1 = $script_ans->[1]->@*;
    my $test_diff = abs( sum(@subset0) - sum(@subset1) ); 
    say "@set";
    say "expected diff: ", $expected_diff;
    say "test diff: ", $test_diff;
    say "@subset0";
    say "@subset1";
    return ($test_diff == $expected_diff) 
       && ( abs(scalar @subset0 - scalar @subset1) <= 1 ), 
}


done_testing();

