#!/usr/bin/perl
use warnings;
use strict;

use Marpa::R2 ();

my $dsl = << '__DSL__';
lexeme default = latm => 1
:default ::= action => ::first

BonusStruct ::= Struct
              | Struct (nl) Lines (End)                 action => bonus
End         ::= (begin ws) (Endid) (ws end)             action => []
Endid       ::= ('end') Id                              action => check_id
Struct      ::= (begin) (ws) Id (ws) Fields (ws) (end)  action => struct
Id          ::= word
Lines       ::= char Lines                              action => concat
              | char
Fields      ::= Field (ws) Fields                       action => merge
              | Field
Field       ::= Name (eq) Value                         action => name_val
Name        ::= word
Value       ::= Number
              | (qq) Quoted (qq)
Number      ::= digit
              | nonz Digits                             action => concat
Digits      ::= digit Digits                            action => concat
              | digit
Quoted      ::= Char Quoted                             action => concat
              | Char
Char        ::= bs                                      action => bs
              | dq                                      action => dq
             || char

begin ~ '{%'
end   ~ '%}'
qq    ~ '"'
word  ~ [\w]+
bs    ~ '\\'
dq    ~ '\"'
char  ~ [\s\S]
eq    ~ '='
digit ~ [0-9]
nonz  ~ [1-9]
ws    ~ [\s]+
nl    ~ [\n]
__DSL__

sub concat   { $_[1] . $_[2] }
sub name_val { +{$_[1] => $_[2]} }
sub merge    { +{%{ $_[1] }, %{ $_[2] }} }
sub struct   { $_[0] = $_[1]; {name => $_[1], fields => $_[2]} }
sub bonus    { +{%{ $_[1] }, text => $_[2]} }
sub check_id { $_[0] eq $_[1] or die "Invalid id" }
sub bs       { '\\' }
sub dq       { '"' }

my $grammar = 'Marpa::R2::Scanless::G'->new({source => \$dsl});
use experimental qw{ signatures };
sub line_parser($input) {
    my $value_ref = $grammar->parse(\$input, 'main');
    return $$value_ref
}

use Test2::V0;
plan 5;

is line_parser('{%  id   field1="value1"    field2="value2"  field3=42 %}'),
          {
              name => 'id',
              fields => {
                  field1 => 'value1',
                  field2 => 'value2',
                  field3 => 42,
              }
          }, 'Example 1';

is line_parser('{%  youtube title="Title \"quoted\" done" %}'),
          { name => 'youtube', fields => {title => 'Title "quoted" done'}},
          'Double quotes';

is line_parser('{%  youtube title="Title with escaped backslash \\\\" %}'),
          {
              name => 'youtube',
              fields => {
                  title => 'Title with escaped backslash \\'
              }
          },
          'Backslash';

is line_parser('{% id  filed1="value1" %}
LINES
{% endid %}'),
          {
              name => 'id',
              fields => {
                  filed1 => 'value1'
              },
              text => "LINES\n"
          },
          'bonus';

my $e = dies {
    line_parser(join "\n",
                '{% id  filed1="value1" %}',
                'LINES',
                '{% endOTHERID %}'
    ) };
like $e, qr/Invalid id/, 'Fails';
