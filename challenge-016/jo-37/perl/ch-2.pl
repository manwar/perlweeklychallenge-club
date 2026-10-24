#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use experimental 'signatures';

use bigint;
use Math::Prime::Util qw(fromdigits todigits);
use Digest::SHA 'sha256';

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - validate Bitcoin address

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        string containing a bitcoin address

    EOS
}


### Input and Output

say 0 + validate_bitcoin_addr(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/24/ch-016.html#task-2

sub validate_bitcoin_addr ($addr) {
    state $B58Chars = '123456789' .
        'ABCDEFGHJKLMNPQRSTUVWXYZ' .
        'abcdefghijkmnopqrstuvwxyz';
    $addr =~ /^[$B58Chars]{27,35}$/ or return 0;
    my @b58digits = map index($B58Chars, $_), split //, $addr;
    my $int = fromdigits \@b58digits, length $B58Chars;
    my @bytes = todigits $int, 256, 25;
    my $bytes = pack 'C*', @bytes;
    my $chk = substr sha256(sha256(substr $bytes, 0, 21)), 0, 4;
    $chk eq substr $bytes, -4 or 0;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [0 + validate_bitcoin_addr(@$args)];
        is $result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;
    my $exmp = JSON->new->utf8->boolean_values(0, 1)->decode(<<~'EOF');
    {
      "challenge": {
        "week": "016",
        "task": 2,
        "name": "Validating Bitcoin addresses"
      },
      "input_vars": [ "$addr" ],
      "examples": [
        {
          "name": "Example 1",
          "in": ["1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"],
          "out": [ true ]
        },
        {
          "name": "Example 2",
          "in": ["3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"],
          "out": [ true ]
        }
      ]
    }
    EOF

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
