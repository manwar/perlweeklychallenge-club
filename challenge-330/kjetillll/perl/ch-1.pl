sub f {
    my $str=shift;
    1 while $str =~ s/ [^\d] \d //x;
    $str
}
print f( $$_[0] ) eq $$_[1] ? "ok\n" : "err\n" for map [split], split /\n/, <<""
cab12 c
xy99 
pa1erl perl
