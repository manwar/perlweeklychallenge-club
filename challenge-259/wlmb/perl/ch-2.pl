#!/usr/bin/env perl
# Perl weekly challenge 259
# Task 2:  Line Parser
#
# See https://wlmb.github.io/2024/03/04/PWC259/#task-2-line-parser
use v5.36;
use Parse::RecDescent;
use Data::Dumper;
local $/;
my $input=<>;
our @result;
my $grammar=q{
  {my $id;}
  startrule: record(s) eof
      { $return = $item[1] }
  record: single lines
      { $return = {
          %{$item[1]},
        text => join " ", $item[2]->@* }
      }
  | single
  single: '{%' id keyval(s) '%}'
      { $return = { name => $item[2],  fields => { map {%$_} $item[3]->@*} };   }
  id: /\w+/
      { $id=$item[1]; }
  lines: line(s) '{%' "end" "$id" '%}'
     { $return = $item[1]; }
  line: /.*/
      { $return=$item[1]; $item[1]=~/^\{%/?undef:1; }
  keyval: key "=" val
      { $return = {$item[1]=>$item[3]} }
  key: /\w+/
  val: number | string
  number: /\d+/
  string: /"(?:[^"\n]|\\")*"/
  eof: /^\Z/
};
my $parser=Parse::RecDescent->new($grammar);
my $parse=$parser->startrule($input);
say Dumper($parse);
