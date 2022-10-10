#!/usr/bin/env raku
use Test;

is-deeply mask-code('ab-cde-123', '123.abc.420', '3abc-0010.xy'), ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy');
is-deeply mask-code('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'), ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f');

sub mask-code(+@list)
{
    map { .subst(/<alnum>/, 'x', :x(4)) }, @list
}
