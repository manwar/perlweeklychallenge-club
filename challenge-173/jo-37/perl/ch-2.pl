#!/usr/bin/perl -s

use v5.16;
use bigint;
use Test2::V0;
# Need --force to install, see comment in week 168.
use List::Gen ':iterate';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [N]

-examples
    run the examples from the challenge
 
N
    Print the first N numbers from Sylvester's sequence.

EOS


### Input and Output

gen_sylvester()->say(shift);


### Implementation

# Build a generator for Sylvester's sequence using the recurrence
# relation starting with the value "2".
sub gen_sylvester {
	iterate{$_ * ($_ - 1) + 1}->from(2);
}


### Examples and tests

sub run_tests {
    is gen_sylvester()->take(10),
        [qw(2 3 7 43 1807 3263443 10650056950807
            113423713055421844361000443
            12864938683278671740537145998360961546653259485195807
            165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443)],
        'task 2';

    done_testing;
    exit;
}
