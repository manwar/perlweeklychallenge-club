#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental 'signatures';

use Lingua::Any::Numbers ':std2';

### Options and Arguments

my ($tests, $examples, $verbose, $lang);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'lang=s'    => \$lang,
    'available' => sub {say for available_languages(); exit(0)},
) or usage();

$lang //= 'EN';

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - spellbound sorting

    usage: $0 [-examples] [-tests] [-available] [-lang LANG] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -available
        list available languages

    -lang LANG
        use language LANG. Default: EN

    N...
        list of numbers

    EOS
}


### Input and Output

lang: {
    for (available_languages()) {
        last lang if $_ eq $lang;
    }
    die "lang not supported: $lang\n";
}

say "@{[spellbound_sorting($lang, @ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/20/ch-362.html#task-2

sub spellbound_sorting ($lang, @list) {
    map $_->[0], sort {$a->[1] cmp $b->[1]}
        map [$_, to_string($_, $lang)], @list;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [spellbound_sorting(@$args)];
        is $result, $expected,
            "$name: (@$args) ->  @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[EN => 6, 7, 8, 9 ,10], [8, 9, 7, 6, 10], 'example 1'],
            [[EN => -3, 0, 1000, 99], [-3, 99, 1000, 0], 'example 2'],
            [[FR => 1, 2, 3, 4, 5], [5, 2, 4, 3, 1], 'example 3 French'],
            [[EN => 1, 2, 3, 4, 5], [5, 4, 1, 3, 2], 'example 3 English'],
            [[EN => 0, -1, -2, -3, -4], [-4, -1, -3, -2, 0], 'example 4'],
            [[EN => 100, 101, 102], [100, 101, 102], 'example 5'],
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
