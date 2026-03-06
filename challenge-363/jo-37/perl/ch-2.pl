#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use Net::IPv4Addr qw(ipv4_parse ipv4_network ipv4_in_network);


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
    $0 - subnet sheriff

    usage: $0 [-examples] [-tests] [ADDR DOMAIN]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    ADDR
        IPv4 address

    DOMAIN
        IPv4 CIDR subnet

    EOS
}


### Input and Output

say +(qw(true false))[!subnet_sheriff(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/06/ch-363.html#task-2

sub subnet_sheriff ($ip_addr, $domain) {
    my ($addr, $net);
    eval {
        local $SIG{__WARN__} = sub {};
        $addr = ipv4_parse($ip_addr);
        1
    } or return;
    eval {
        local $SIG{__WARN__} = sub {};
        $net = ipv4_network($domain);
        1
    } or return;

    ipv4_in_network($net, $addr);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = subnet_sheriff(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["192.168.1.45", "192.168.1.0/24"], T(), 'example 1'],
            [["10.0.0.256", "10.0.0.0/24"], F(), 'example 2'],
            [["172.16.8.9", "172.16.8.9/32"], T(), 'example 3'],
            [["172.16.4.5", "172.16.0.0/14"], T(), 'example 4'],
            [["192.0.2.0", "192.0.2.0/25"], T(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
