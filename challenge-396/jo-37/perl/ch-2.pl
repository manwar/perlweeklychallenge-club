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
use PDL::NiceSlice;


### Options and Arguments

my ($tests, $examples, $verbose, @shape);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'shape=i{1,}' => \@shape,
) or usage();

@shape = (1, -1, 1) unless @shape;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - trionic array

    usage: $0 [-examples] [-tests] [-shape S...] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -shape S...
        list of -1, 0 and 1 specifying the required shape.
        Default: 1 -1 1

    N...
        list of at least two Integers

    EOS
}


### Input and Output

say has_shape(\@shape, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/23/ch-396.html#task-2

sub has_shape {
    my $shape = long shift;
    my $arr = long @_;
    my $steps = (($arr(1:-1) - $arr(0:-2))->clip(-1, 1)->rle)[1];
    0 + ($steps->dim(0) == $shape->dim(0)) && eqvec $steps, $shape;
}

sub is_trionic {
    unshift @_, [1, -1, 1];
    goto &has_shape;
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [is_trionic(@$args)];
        is $result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;
    my $exmp = do {
        use autodie;
        local $/;
        open my $xfh, '<', EXMP;
        my $ex = JSON->new->utf8->boolean_values(0, 1)->decode(<$xfh>);
        close $xfh;
        $ex; 
    };

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is has_shape([1, 0, -1], 1, 2, 2, 1), 1, 'is mesa';
    }) : pass 'skip tests';

    exit;
}
