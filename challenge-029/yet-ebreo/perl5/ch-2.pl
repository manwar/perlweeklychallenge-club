#!/usr/bin/env perl
# Write a script to demonstrate calling a C function. 
# It could be any user defined or standard C function.
use strict;
use warnings;
use feature 'say';
use Memoize;

use Inline 'C';

my $start_run;
my $run_time;


$start_run = time();
print (perl_fib($_)." ") for 1..36;
$run_time  = time() - $start_run;
say "\nRun Time (Perl): $run_time sec\n";

memoize('perl_fib');
$start_run = time();
print (perl_fib($_)." ") for 1..36;
$run_time  = time() - $start_run;
say "\nRun Time (Perl-Memoized): $run_time sec\n";

$start_run = time();
print (fib($_)." ") for 1..36;
$run_time  = time() - $start_run;
say "\nRun Time (Inline-C): $run_time sec\n";

sub perl_fib { ($_[0] == 0) ? 0: ($_[0] == 1)?1:perl_fib($_[0]-1)+perl_fib($_[0]-2) }

__END__
__C__
unsigned long fib(int n) {
    if ( n == 0 )
        return 0;
    else if ( n == 1 )
        return 1;
    else
        return ( fib(n-1) + fib(n-2) );
}

=begin
#This was ran inside virtual box 
perl ch-2.pl 
1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 
121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352 
Run Time (Perl): 49 sec

1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 
121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352 
Run Time (Perl-Memoized): 0 sec

1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 
121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352 
Run Time (Inline-C): 1 sec
=cut