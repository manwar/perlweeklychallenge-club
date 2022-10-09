sub task2 ( @a ) {
    # Could have avoided $c and codeblock, and simply use the `:4x` below, but I have not upgrade my Rakudo.
    # return @a.map: *.subst( :4x, /<[a..z0..9]>/, 'x' );

    return @a.map: {
        my $c = 0;
        .subst( :g, /<[a..z0..9]>/, { $c++ < 4 ?? 'x' !! $/.Str } );
    }
}

use Test;
my @tests =
    ( <ab-cde-123 123.abc.420 3abc-0010.xy>,
      <xx-xxe-123 xxx.xbc.420 xxxx-0010.xy> ),
    ( <1234567.a a-1234-bc a.b.c.d.e.f>,
      <xxxx567.a x-xxx4-bc x.x.x.x.e.f> ),
    ( <xxxx567.a x-xxx4-bc x.x.x.x.e.f>,
      <xxxx567.a x-xxx4-bc x.x.x.x.e.f> ),
    ( <a aa aaa aaaa>,
      <x xx xxx xxxx> ),
;
plan +@tests;
for @tests -> ($in, $expected) {
    is-deeply task2($in), $expected;
}
