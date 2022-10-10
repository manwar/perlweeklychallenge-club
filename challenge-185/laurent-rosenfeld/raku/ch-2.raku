constant MAX = 4;
my @tests = <ab-cde-123  123.abc.420  3abc-0010.xy  1234567.a
             a-1234-bc  a.b.c.d.e.f  12__34567.a>;
for @tests -> $test {
    my $count = 0;
    my $result = $test;
    my $pos = 0;
    while $count < MAX {
        $count++ if $result ~~ s:c($pos)/<[\w] - [_]>/x/;
        $pos = $/.to;
    }
    say "$test\t => $result";
}
