# The Weekly Challenge 147
# Task 1 Truncatable Prime
# version 0: Thursday, January 13, 2022 PM04:18:51 HKT
# version 1: Friday, January 14, 2022 AM01:20:32 

use v5.12.0;
use warnings;



my @ltp = ();
my @recent_ltp = (2,3,5,7);
my @new_ltp = ();

my @prime = (2,3,5,7);



sub is_prime {
    my $t = $_[0];
    for (my $k = 0; $prime[$k] <= sqrt($t) ;$k++) {
        return 0 if $t % $prime[$k] == 0;
    } 
    return 1;
}



sub append_arr_of_primes {
    my $max = $_[0];
    my $sqrtmax = sqrt($max);
    my @relatively_small_primes = grep { $_ <= $sqrtmax } @prime;
    HERE: for my $can ($relatively_small_primes[-1]+1..$max) {
        for my $p (@relatively_small_primes) {
            next HERE if $can % $p == 0
        }
        push @prime, $can;
    }
}



sub append_arr_of_ltp {
    my $target_size = $_[0];
    if ($target_size <= (scalar @ltp + scalar @recent_ltp)) {
        push @ltp, @recent_ltp;
        return;
    }
    for my $d (1..9) {
        for my $num (@recent_ltp) {
            my $new_num = $d . $num;
            push @new_ltp, $new_num if is_prime($new_num);
        }
    }
    push @ltp, @recent_ltp;
    @recent_ltp = @new_ltp;
    @new_ltp = ();
    append_arr_of_ltp($target_size);
}



append_arr_of_primes(1000);
append_arr_of_ltp(20);
say $_ for @ltp[0..19];

