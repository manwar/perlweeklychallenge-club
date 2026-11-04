#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use experimental 'signatures';


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
    $0 - Eertree nodes

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say "@{[eertree(shift)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/06/ch-145.html#task-2

package Eertree::Edonode;

sub new ($class, $palindrome) {
    bless {
        palindrome => $palindrome,
        length => defined($palindrome) ? length($palindrome) : -1,
        suffix => undef,
        transition => {},
    }, $class;
}

sub palindrome ($self) {
    $self->{palindrome};
}

sub length ($self) {
    $self->{length};
}

sub transition ($self, $char, $dest=undef) {
    if (@_ == 2) {
        return $self->{transition}{$char};
    }
    $self->{transition}{$char} = $dest;
    $self;
}

sub suffix ($self, $dest=undef) {
    if (@_ == 1) {
        return $self->{suffix};
    }
    $self->{suffix} = $dest;
    $self;
}

sub extend ($self, $c) {
    my $ex = $self->palindrome;
    $ex = $c . $ex if defined $ex;
    $ex .= $c;
    $ex;
}

package Eertree;

sub new ($class) {
    my $empty = Eertree::Edonode->new('');
    my $undef = Eertree::Edonode->new(undef);
    $empty->suffix($undef);
    $undef->suffix($undef);
    bless {
        empty => $empty,
        undef => $undef,
        source => '',
        current => $undef,
        sequence => [],
    }, $class;
}

sub _longest_predecessor ($self, $node) {
    for (; $node; $node = $node->suffix) {
        my $pos = length($self->{source}) - $node->length - 2;
        last if $pos >= 0 &&
            substr($self->{source}, $pos, 1) eq substr($self->{source}, -1);
    }
    $node;
}

sub add ($self, $c) {
    $self->{source} .= $c;
    my $predecessor = $self->_longest_predecessor($self->{current});
    my $pc = $predecessor->transition($c);
    return $self->{current} = $pc if $pc;

    my $palindrome = $predecessor->extend($c);
    my $new = Eertree::Edonode->new($palindrome);
    push $self->{sequence}->@*, $new;
    my $suffix = $new->length == 1 ?
        $self->{empty}
    :
        $self->_longest_predecessor($predecessor->suffix)->
            transition($c);
    $new->suffix($suffix);
    $predecessor->transition($c, $new);
    $self->{current} = $new;
}

sub palindromes ($self) {
    map $_->palindrome, $self->{sequence}->@*;
}

package main;

sub eertree ($s) {
    my $eertree = Eertree->new;
    $eertree->add($_) for split //, $s;
    $eertree->palindromes;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [eertree(@$args)];
        my $bag = bag {item $_ for @$expected; end};

        is $result, $bag,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }
    return unless $examples || $tests;

    plan 2;
    my $exmp = JSON->new->utf8->boolean_values(0, 1)->decode(<<~'EOF');
    {
      "challenge": {
        "week": 145,
        "task": 2 ,
        "name": "Palindromic Tree"
      },
      "input_vars": [ "$s" ],
      "examples": [
        {
          "name": "Example 1",
          "in": ["redivider"],
          "out": ["r", "redivider", "e", "edivide", "d", "divid", "i",
                 "ivi", "v"]
        },
        {
          "name": "Example 2",
          "in": ["deific"],
          "out": ["d", "e", "i", "ifi", "f", "c"]
        },
        {
          "name": "Example 3",
          "in": ["rotors"],
          "out": ["r", "rotor", "o", "oto", "t", "s"]
        },
        {
          "name": "Example 4",
          "in": ["challenge"],
          "out": ["c", "h", "a", "l", "ll", "e", "n", "g"]
        },
        {
          "name": "Example 5",
          "in": ["champion"],
          "out": ["c", "h", "a", "m", "p", "i", "o", "n"]
        },
        {
          "name": "Example 6",
          "in": ["christmas"],
          "out": ["c", "h", "r", "i", "s", "t", "m", "a"]
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
        plan 2;
        is [eertree('eertree')],
            [qw(e ee r t rtr ertre eertree)],
            'eertree';
        is [eertree('abacdabad')],
            [qw(a b aba c d dabad)], 'correct current node set?';
    }) : pass 'skip tests';

    exit;
}
