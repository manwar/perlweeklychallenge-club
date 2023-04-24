#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

main: {
    local $" = ',';
    local $, = ',';
    say map "(@$_)", wave_array([sort {$b <=> $a} @ARGV], [], 1, [])->@*;
}


### Implementation

# Recursive implementation:
# - If there is only one element in the list, it is appended to the
#   current wave if it agrees with the direction.
# - The first element of the wave array cannot be the smallest / largest
#   from the list as there would not be a suitable second element
#   otherwise.
# - Loop over unseen numbers only that agree with the direction.
# - On recursion to the next level, remove the currently selected
#   element, reverse the remaining and flip the direction.
sub wave_array ($list, $prefix, $dir, $result) {
    if (@$list == 1) {
        push @$result, [@$prefix, @$list]
            if @$prefix && ($list->[0] <=> $prefix->[-1]) * $dir >= 0;
        return;
    }
    my %seen_p;
	for my $p (0 .. $#$list - 1) {
        my @l = @$list;
        my $lp = splice @l, $p, 1;
        next if $seen_p{$lp};
        $seen_p{$lp} = 1;
        next if @$prefix && ($lp <=> $prefix->[-1]) * $dir < 0;
        wave_array([reverse @l], [@$prefix, $lp], -$dir, $result);
    }
    
    $result;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is wave_array([4, 3, 2, 1], [], 1, []),
            bag {item [2, 1, 4, 3]; item [4,1,3,2]; etc;}, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
