#!/usr/bin/perl

use v5.26;
use warnings;
use Getopt::Long;
use experimental 'signatures';

use Lingua::Any::Numbers ':std2';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();


usage() unless 1 || @ARGV;

sub usage {
    die <<~EOS;
    $0 - eban numbers

    usage: $0 N

    N
        print eban numbers from zero to N

    EOS
}


### Input and Output

say "@{[eban_numbers(shift)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/08/ch-148.html#task-2

sub eban_numbers {
     grep to_string($_) !~ /e/, 0 .. shift;
}


