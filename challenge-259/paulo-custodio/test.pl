#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2018-06-28  3  2018-07-03",   "2018-07-04");
test_line(1, "2018-06-28  3",               "2018-07-03");

test_block(2, <<'IN', <<'OUT');
{%  id   field1="value1"    field2="value2"  field3=42 %}
IN
{
  name => "id",
  fields => {
    field1 => "value1",
    field2 => "value2",
    field3 => 42,
  },
}
OUT
test_block(2, <<'IN', <<'OUT');
{%  youtube title="Title \"quoted\" done" %}
IN
{
  name => "youtube",
  fields => {
    title => "Title \"quoted\" done",
  },
}
OUT
test_block(2, <<'IN', <<'OUT');
{%  youtube title="Title with escaped backslash \\" %}
IN
{
  name => "youtube",
  fields => {
    title => "Title with escaped backslash \\",
  },
}
OUT

done_testing;
