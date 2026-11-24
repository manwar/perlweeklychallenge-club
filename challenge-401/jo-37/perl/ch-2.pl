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

use List::Util 'pairmap';
use List::MoreUtils 'frequency';
use List::Gather;
use Set::Bag;
use PDL;
use PDL::NiceSlice;
use PDL::Char;
use PDL::Opt::GLPK;
use PDL::CCS::Nd;


use constant WORDS =>
        qw(zero one two three four five six seven eight nine);

### Options and Arguments

my ($tests, $examples, $verbose, $solution);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'    => \$verbose,
    'solution=i'  => \$solution,
) or usage();

$solution ||= 3;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - reconstruct digits

    usage: $0 [-examples] [-tests] [-solution S] [STR]

    -examples
        run the examples from the challenge

    -tests
        run some tests

    -solution S
        set solution S
        1: anagrams
        2: distributed characters
        3: ILP (default)

    STR
        a string

    EOS
}


### Input and Output

say $solution == 1 ? reconstruct_digits_1(@ARGV) :
    $solution == 2 ? reconstruct_digits_2(@ARGV) :
    $solution == 3 ? reconstruct_digits_3(@ARGV) :
    die "solution $solution invalid";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/27/ch-401.html#task-2

# Anagrams
sub words ($w) {
    my $l = length $w;

    "([$w]{$l})(?(?{\$+ !~ m{" .
        join('', pairmap {
            "(?=" . "[^$a]*+$a" x $b . ")"
        } frequency split //, $w) .
        "}})(*FAIL))";
}

sub reconstruct_digits_1 ($str) {

    state $ws = join "|\n", map words($_), WORDS;
    state $words;
    $words || eval "\$words = qr{$ws}x; 1;" || die $@;

    join '', sort +gather {
        take $#- - 1 while $str =~ s/$words//;
    };
}

# Distributed Characters
sub str2bag {
    Set::Bag->new(map +($_, 1), split //, shift);
}

sub reconstruct_digits_2 ($str) {
    state $words = [map str2bag($_), WORDS];
    my $bag = str2bag($str);
    my $r = '';
    while (my ($i, $word) = each @$words) {
        my $diff;
        # try to pick $word
        while (eval {$diff = $bag - $word; 1}) {
            $r .= $i;
            $bag = $diff;
        }
    }

    $r;
}

# ILP
sub reconstruct_digits_3 ($str) {
    state $words = PDL::Char->new(WORDS);
    # drop \0:
    state $chars = do {my $tmp = $words->uniq; $tmp->where($tmp)};
    # constraint coefficients
    state $a = long($words == $chars->(*1,*1))->sumover->toccs;
    state $c = ones long, $a->dim(0);
    state $lb = zeroes $c;                 # lower bounds: zero
    state $ub = (2**31 - 1) * ones $c;     # upper bounds: no limit
    state $ctype = GLP_UP * ones long, $a->dim(1);  # constraint types: <=
    state $vtype = GLP_IV * ones $c;       # variable types: int

    # constraint rhs
    my $b = long(PDL::Char->new($str) == $chars->(*1))->sumover;

    glpk($c, $a, $b, $lb, $ub, $ctype, $vtype, GLP_MAX,
        my $xopt = null, null, my $status = null);
    die "GLPK failed" unless $status == GLP_OPT;

    # repeat digit according to solution
    join '', map $_->[1] x $_->[0],
        cat($xopt, sequence($xopt))->xchg(0, 1)->unpdl->@*;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    local $ENV{TABLE_TERM_SIZE} = 70;
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        subtest("$name: (@{fa(@$args)}) -> @{fa(@$expected)}" => sub {
            plan 3;
            {
                my $todo = todo 'preliminary #1';
                my $result = [reconstruct_digits_1(@$args)];
                is $result, $expected, "anagrams";
            }
            {
                my $todo = todo 'preliminary #2';
                my $result = [reconstruct_digits_2(@$args)];
                is $result, $expected, "distributed chars";
            }
            {
                my $result = [reconstruct_digits_3(@$args)];
                is $result, $expected, "ILP";
            }
        })
    }

    plan 2;
    my $exmp = do {
        use autodie;
        local $/;
        open my $xfh, '<', EXMP;
        my $ex = JSON->new->utf8->boolean_values(0, 1)->decode(<$xfh>);
        $ex;
    };

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        run_example ["xenowtingsetheinev"], ["2789"], "make a choice";
    }) : pass 'skip tests';

    exit;
}
