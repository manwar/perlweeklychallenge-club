#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-2.json';
use experimental 'signatures';

use PDL;
use PDL::Opt::GLPK;

### Options and Arguments

my ($tests, $examples, $verbose, @name, $count, $limit, @weight, @amount);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'name=s{1,}' => \@name,
    'count=i'     => \$count,
    'limit=i'     => \$limit,
    'weight=i{1,}' => \@weight,
    'amount=i{1,}' => \@amount,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 0 && @name && $count && $limit && @weight && @amount;

sub usage {
    die <<~EOS;
    $0 - Knapsack problem

    usage: $0 [-examples] [-tests] [-name NAME... -count COUNT
        -limit LIMIT -weight WEIGHT... -amount AMOUNT...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -name NAME...
        item names

    -count COUNT
        maximum number of items

    -limit LIMIT
        maximum total weight

    -weight WEIGHT...
        item weights

    -amount AMOUNT...
        item amounts

    EOS
}


### Input and Output

say "@{[knapsack(\@name, $count, $limit, \@weight, \@amount)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/25/ch-036.html#task-2

sub knapsack ($name, $maxcount, $maxweight, $weight, $amount) {
    die "invalid number of weights" if @$name != @$weight;
    die "invalid number of amounts" if @$name != @$amount;
    my $c = pdl $amount;
    my $a = pdl $weight, ones($c);
    my $b = pdl $maxweight, $maxcount;
    my $ctype = pdl GLP_UP * ones($a->dim(1));
    my $vtype = pdl GLP_BV * ones($c);
    glpk($c, $a, $b, zeroes($c), zeroes($c), $ctype, $vtype, GLP_MAX,
        my $xopt = null, my $fopt = null, my $status = null);
    die "status: $status" if $status != GLP_OPT;
    (\my %name)->@{@$name} = $xopt->list;

    grep $name{$_}, @$name;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [knapsack(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }

    plan 2;
    my $exmp = JSON->new->utf8->boolean_values(0, 1)->decode(<<~'EOF');
    {
      "challenge": {
        "week": "036",
        "task": 2,
        "name": "Knapsack problem"
      },
      "input_vars": [ "$names", "$maxcount", "$maxweight", "$weight", "$amount" ],
      "examples": [
        {
          "name": "Example 1",
          "in": [["R", "B", "G", "Y", "P"], 5, 15, [1, 1, 2, 12, 4], [1, 2, 2, 4, 10]],
          "out": ["R", "B", "G", "P"]
        },
        {
          "name": "Example 2",
          "in": [["R", "B", "G", "Y", "P"], 2, 15, [1, 1, 2, 12, 4], [1, 2, 2, 4, 10]],
          "out": ["B", "P"]
        },
        {
          "name": "Example 3",
          "in": [["R", "B", "G", "Y", "P"], 3, 15, [1, 1, 2, 12, 4], [1, 2, 2, 4, 10]],
          "out": ["B", "G", "P"]
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
