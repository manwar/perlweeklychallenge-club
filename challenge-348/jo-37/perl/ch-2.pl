#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'sum';
use DateTime::Format::Strptime;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - convert time

    usage: $0 [-examples] [-tests] ] [SOURCE TARGET]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    SOURCE TARGET
        two time strings in the format HH:MM

    EOS
}


### Input and Output

say convert_time(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/21/ch-348.html#task-2

sub convert_time {
    state $div = [5, 3, 4, 24];
    state $parser = DateTime::Format::Strptime->new(pattern => "%R",
        strict => 1, on_error => 'croak');

    my ($s, $t) = map $parser->parse_datetime($_), @_;
    my $diff = ($t - $s)->in_units('minutes') % (24 * 60);

    use integer;
    sum map +($diff % $_, $diff /= $_)[0], @$div;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = convert_time(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["2:30", "2:45"], 1, 'example 1'],
            [["11:55", "12:15"], 2, 'example 2'],
            [["9:00", "13:00"], 4, 'example 3'],
            [["23:45", "0:30"], 3, 'example 4'],
            [["14:20", "15:25"], 2, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["12:00", "11:59"], 32, 'max'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
