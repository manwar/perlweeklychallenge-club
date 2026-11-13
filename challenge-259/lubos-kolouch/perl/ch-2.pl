#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Line Parser (The Weekly Challenge 259 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl '{% id field1="value1" field2=42 %}'
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a template tag line (or multiline block).

Write a script to parse the line, extracting the tag name, key-value field
attributes (supporting unquoted numbers and double-quoted strings with escape
sequences), and optional multiline text body.

=head1 FUNCTIONS

=head2 parse_line($input)

Parses a single-line or multiline template tag string.

=over 4

=item * C<$input> - The string input to parse.

=back

Returns a hash reference with keys C<name>, C<fields>, and optionally C<text>.

=cut

signature_for parse_line => (
    method     => 0,
    positional => [Str],
);

sub parse_line ($input) {
    my %result;

    my ( $name, $attrs, $text );
    if ( $input =~ m/\A\s*\{%\s*(\w+)(.*?)\s*%\}(?:\r?\n([\s\S]*?)\r?\n\s*\{%\s*end\1\s*%\})?\s*\z/s ) {
        $name  = $1;
        $attrs = $2;
        $text  = $3;
    }
    else {
        ( $name, $attrs ) = ( $input =~ m/\{%\s*(\w+)(.*?)\s*%\}/s );
    }

    return {} unless defined $name;

    $result{name}   = $name;
    $result{fields} = {};

    while ( $attrs =~ m/(\w+)=(?:(-?\d+(?:\.\d+)?)|"((?:\\.|[^"\\])*)")/g ) {
        my $key     = $1;
        my $num_val = $2;
        my $str_val = $3;

        if ( defined $num_val ) {
            $result{fields}{$key} = 0 + $num_val;
        }
        else {
            $str_val =~ s/\\(.)/$1/g;
            $result{fields}{$key} = $str_val;
        }
    }

    if ( defined $text ) {
        $result{text} = $text;
    }

    return \%result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $input  = join( ' ', @args );
    my $result = parse_line($input);
    require Data::Dumper;
    say Data::Dumper::Dumper($result);
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            input    => q/{%  id   field1="value1"    field2="value2"  field3=42 %}/,
            expected => {
                name   => 'id',
                fields => {
                    field1 => 'value1',
                    field2 => 'value2',
                    field3 => 42,
                },
            },
        },
        {
            label    => 'Example 2 - escaped quotes',
            input    => q/{%  youtube title="Title \"quoted\" done" %}/,
            expected => {
                name   => 'youtube',
                fields => {
                    title => 'Title "quoted" done',
                },
            },
        },
        {
            label    => 'Example 3 - escaped backslash',
            input    => q/{%  youtube title="Title with escaped backslash \\\\" %}/,
            expected => {
                name   => 'youtube',
                fields => {
                    title => 'Title with escaped backslash \\',
                },
            },
        },
        {
            label    => 'Example 4 - multiline tag',
            input    => "{% id field1=\"value1\" field2=\"value2\" %}\nLINES\n{% endid %}",
            expected => {
                name   => 'id',
                fields => {
                    field1 => 'value1',
                    field2 => 'value2',
                },
                text   => 'LINES',
            },
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply(
            parse_line( $case->{input} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
