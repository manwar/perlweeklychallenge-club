use List::Util 'first';

sub f {
    my $price_1st = shift // return;
    $price_1st - ( first { $_ <= $price_1st } @_ ), f(@_)
}

print join(',', f(8, 4, 6, 2, 3) ) eq '4,2,4,2,3' ? "ok\n" : "err\n";
print join(',', f(1, 2, 3, 4, 5) ) eq '1,2,3,4,5' ? "ok\n" : "err\n";
print join(',', f(7, 1, 1, 5)    ) eq '6,0,1,5'   ? "ok\n" : "err\n";
