#!/usr/bin/env perl

# Challenge 259
#
# Task 2: Line Parser
# Submitted by: Gabor Szabo
#
# You are given a line like below:
#
# {%  id   field1="value1"    field2="value2"  field3=42 %}
#
#
# Where
#
# a) "id" can be \w+.
# b) There can be 0  or more field-value pairs.
# c) The name of the fields are \w+.
# b) The values are either number in which case we don't need double quotes or
#    string in which case we need double quotes around them.
#
#
# The line parser should return structure like below:
#
# {
#        name => id,
#        fields => {
#            field1 => value1,
#            field2 => value2,
#            field3 => value3,
#        }
# }
#
#
# It should be able to parse the following edge cases too:
#
# {%  youtube title="Title \"quoted\" done" %}
#
#
# and
#
# {%  youtube title="Title with escaped backslash \\" %}
#
#
# BONUS: Extend it to be able to handle multiline tags:
#
# {% id  filed1="value1" ... %}
# LINES
# {% endid %}
#
#
# You should expect the following structure from your line parser:
#
# {
#        name => id,
#        fields => {
#            field1 => value1,
#            field2 => value2,
#            field3 => value3,
#        }
#        text => LINES
# }

use Modern::Perl;
use Parse::FSM::Lexer;
use Data::Dump 'dump';

my $text = "@ARGV";
my $data = parse($text);
say dump($data);

sub parse {
    my(@text) = @_;
    my $data = {};

    my $lex = Parse::FSM::Lexer->new;
    $lex->from_list($text);

    # start marker
    (my $token = $lex->get_token()) or die "start marker missing";
    $token->[0] eq "{" or die "start marker missing, got ", $token->[0];
    ($token = $lex->get_token()) or die "start marker missing";
    $token->[0] eq "%" or die "start marker missing, got ", $token->[0];

    # name
    ($token = $lex->get_token()) or die "name missing";
    $token->[0] eq 'NAME' or die "name expected";
    $data->{name} = $token->[1];

    # fields
    for (;;) {
        # field name
        ($token = $lex->get_token()) or die "field or end marker missing";
        last if $token->[0] eq '%';
        $token->[0] eq 'NAME' or die "field name expected, got ", $token->[0];
        my $field_name = $token->[1];

        # =
        ($token = $lex->get_token()) or die "'=' expected";
        $token->[0] eq '=' or die "'=' expected, got ", $token->[0];

        # value
        ($token = $lex->get_token()) or die "field value expected";
        ($token->[0] eq 'NUM' || $token->[0] eq 'STR') or die "field value expected, got ", $token->[0];
        my $field_value = $token->[1];

        $data->{fields}{$field_name} = $field_value;
    }

    ($token = $lex->get_token()) or die "end marker missing";
    $token->[0] eq '}' or die "end marker missing, got ", $token->[0];

    defined($token = $lex->get_token()) and die "extra input, got ", $token->[0];

    return $data;
}
