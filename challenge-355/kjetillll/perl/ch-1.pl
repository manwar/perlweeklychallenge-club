sub f { reverse join ',', reverse( pop ) =~ /.{1,3}/g }

sub f2 { my $n = shift; 1 while $n =~ s/(\d+)(\d{3})/$1,$2/; $n } #alternative

print f($$_[0]) eq $$_[1] ? "ok\n" : "ERROR $f\n" for
    [ 123 => "123" ],
    [ 1234 => "1,234" ],
    [ 1000000 => "1,000,000" ],
    [ -1000000 => "-1,000,000" ],
    [ 1 => "1" ],
    [ 12345 => "12,345" ],
   #[ -100000000 => "-100,000,000" ], #challenge says positive int
