#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-1.json';
use experimental qw(signatures vlb);

use POSIX 'Inf';

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
    $0 - largest interval

    usage: $0 [-examples] [-tests] [-verbose] [N]

    -examples
        run the examples from the challenge
     
    -tests
        show all intervals

    -verbose
        print intermediate maximum intervals

    N
        a positive integer

    EOS
}


### Input and Output

say largest_interval(shift, $verbose);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/20/ch-400.html#task-1

# integer decadic logarithm
sub ldi {
    length(shift) - 1;
}

# number of trailing zeroes
sub ntz {
    shift =~ /0*$/;
    $+[0] - $-[0];
}

# detect and process duplicate digits:
# - provide increment if duplicates
# - provide next value if unique
# force termination when $i exceeds the
# largest possible number having no duplicate digits
sub dupl ($i) {
    if ($i =~ /(.)(?<=(?=\1).{2,10})/) {
        return (1, 10**(ldi($i) - $-[1]))
    } else {
        my $transition = 11 * 10**(ldi($i) - 1);
        my $next = $i < $transition ?
            $transition : 10 ** (ldi($i) + 1);
        my $s = 0;
        $s = $s * 10 + $_ for 1 .. ntz($next) - 1;
        $next -= $s;
        $next = Inf if $next > 9876543210;
        return (0, $next);
    }
}

sub largest_interval ($n, $verbose=undef) {
    my ($i, $run, $max) = (11, 0, 0);
    while ($i <= $n) {
        my ($skip, $x) = dupl($i);
        if ($skip) {
            $run += $x;
            $i += $x;
        } else {
            $max = $run;
            printf "[%d, %d]: %d\n", $i - $run, $i - 1, $run if $verbose;
            $run = 0;
            $i = $x;
        }
    }
    $max + 1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [largest_interval(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
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
        largest_interval(1e10, 1);
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
