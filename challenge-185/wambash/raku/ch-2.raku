#!/usr/bin/env raku

multi mask-code (+@list) {
    @list.map: *.subst: /\w/, 'x', :nth(1..4)
}

multi MAIN (Bool :test($)!) {
    use Test;
    plan 2;
    is mask-code('ab-cde-123', '123.abc.420', '3abc-0010.xy'),('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy');
    is mask-code('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'),('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f');
}

multi MAIN (*@list) {
    put mask-code @list
}
