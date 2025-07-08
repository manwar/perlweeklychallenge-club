
sub f {
    my %seen;
    grep !$seen{$_}++, shift() =~ /\d+/g
}

print join(' ', f("the1weekly2challenge2")) eq '1 2'      ? "ok\n" : "err\n";
print join(' ', f("go21od1lu5c7k"))         eq '21 1 5 7' ? "ok\n" : "err\n";
print join(' ', f("4p3e2r1l"))              eq '4 3 2 1'  ? "ok\n" : "err\n";

