#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Regexp::Common qw(number delimited);
use Clone 'clone';
use Data::Dump 'dd';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    string to be parsed

EOS


### Input and Output

dd line_parser(shift);


### Implementation

sub unescape {
    shift =~ s{\\(.)}{$1}gr;
}

sub line_parser {
    our %tmp;
    our $val;
    my $parsed;

    shift =~ m{
        (?{ local %tmp })
        \{% \s*+
        (?<NAME>\w++)
        (?{ $tmp{name} = $+{NAME}; })
        (?:
            \s++
            (?<KEY>\w++)=
            (?{ local $val; })
            (?:
                (??{qr{$RE{num}{dec}{-keep}
                        (?{ $val = 0 + $1; })
                    }x
                })
                |
                (??{qr{$RE{delimited}{-delim => q{'"}}{-esc => '\\'}{-keep}
                        (?{ $val = unescape($3); })
                    }x
                })
            )
            (?{ $tmp{fields}{$+{KEY}} = $val; })
        )*+
        \s*+ %\}
        (?:
            \n
            (?<LINES>.*?)
            \n
            (?{ $tmp{text} = $+{LINES}; })
            \{% \s*+
            end\g{NAME}
            \s*+ %\}
        )?
        (?{ $parsed = clone \%tmp; })
    }xs;

    $parsed;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is line_parser(
            '{%  id   field1="value1"    field2="value2"  field3=42 %}'
        ), {name => 'id',
            fields => {field1 => 'value1', field2 => 'value2', field3 => 42}},
            'example 1';
        is line_parser('{%  youtube title="Title \"quoted\" done" %}'),
            {name => 'youtube', fields => { title => q{Title "quoted" done}}},
            'example 2';
        is line_parser(
            '{%  youtube title="Title with escaped backslash \\\\" %}'
        ), {name => 'youtube',
            fields => {title => q{Title with escaped backslash \\}}},
            'example 3';
        is line_parser(<<'EOD'),
{% id  field1="value1" %}
LINE1
LINE2
{% endid %}
EOD
            {name => 'id', fields => {field1 => 'value1'},
                text => "LINE1\nLINE2"}, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is line_parser('{% no_fields %}'), {name => 'no_fields'}, 'no fields';
        is line_parser('{% no_end'), F(), 'incomplete';
        is line_parser('{% inval f1=abc %}'), F(), 'unquoted string';
        like line_parser('{% numstr f1="042" f2=043 f3=44.0e0 f4="45.0" f5="aaa" %}'),
            hash { field name => 'numstr'; field fields => hash {
                    field f1 => qr/^042$/; field f2 => qr/^43$/;
                    field f3 => qr/^44$/; field f4 => qr/^45\.0$/;
                    field f5 => qr/^aaa$/;}},
            'numbers';
        is line_parser(q{{% single_quote f1='one' %}}),
            {name => 'single_quote', fields => {f1 => 'one'}}, 'single quote';
	}

    done_testing;
    exit;
}
