#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(reduce sum0);

# You are given a positive integer $N.
#
# Write a script to find out all possible combination of Fibonacci Numbers required to get $N on addition.
#
# You are NOT allowed to repeat a number. Print 0 if none found.

my ($N) = @ARGV;

my @combinations = possible_fibonacci_combinations($N);

my $out =
  @combinations
  ? join( "\n", map { join( " + ", @$_ ) . ' = ' . $N } @combinations )
  : '0';

say $out;

sub possible_fibonacci_combinations($n) {
    my @fibs = fibs_up_to($n);
    return grep { sum0(@$_) == $n } subsequences(@fibs);
}

# returns the sequence of fibbonacci numbers smaller or equal to $n
sub fibs_up_to($n) {
    take_while( sub { $_[0] < $n }, mk_fib_gen() );
}

# returns a generator for the fibbonacci sequence.
# Note: The generated sequence will start at Fib(2)=1.
#       Fib(0) = 0 and Fib(1) = 1 are skipped
sub mk_fib_gen() {
    sub() {
        state $second_to_last = 0;
        state $last           = 1;

        my $fib = $last + $second_to_last;
        $second_to_last = $last;
        $last           = $fib;

        return $fib;
      }
}

# given a list this will return all non empty subsequences
sub subsequences(@list) {
    return unless @list;
    my ( $head, @rest ) = @list;
    return [$head] unless @rest;

    my $other = reduce { [ $b, [ $head, @$b ], @$a ] }[ [$head] ],
      subsequences(@rest);
    return @$other;
}

# repeatedly run $generator to generate a sequence of results where $cond holds
sub take_while ( $cond, $generator ) {
    my $x = $generator->();
    return $cond->($x) ? ( $x, take_while( $cond, $generator ) ) : ();
}
