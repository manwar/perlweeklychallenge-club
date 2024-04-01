use Math::BigInt;
Math::BigInt->div_scale(2500);
my $A = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()';
sub f {
    my $str = shift;
    my @digits = split "", $str;
    $_ = index $A, $_ for (@digits);
    my $sum = Math::BigInt->new(0);
    foreach (0 .. $#digits) {
	my $b = Math::BigInt->new( length $A );
	$b -> bpow( $#digits - $_ );
	$sum -> badd( $digits[$_] * $b );
    }
    $sum
}
open fh, "<", "ch-1.pl";
my @strings = <fh>;
my $str = substr $strings[$#strings], 1;
chomp $str;
print "3.".f($str)."\n"
#SrMB89DPWO4lpkmDab5Mqw6Npy62PGjFeH2ygGQowjas2jU0xHXPj1l6zUZhWIxeCXzRuiA4vH(EVtp9byYGRpLfWJZthiXK8spgpuWBpI4tmv9Uo)aOFY4(L6s5K9YcV)IZaOF3kcIJs9q7m9Ffkaxs(W4hQl0QSavrgXw)w6YIQ)tltOz1qekb(xugL3x9yPJ4ZMgbTFUPkRmGAKURXIwD1W2R90pTCrYalIL)GEehgcw6RjigU)0HsVB6lh)7(aQCEzKXtqk3fx24mlLO61MQSwV0qKS(WLQyoygm5W(OW7XhapDcElcwHAht(KVp4VMXhwS)4jhyP12yXk38Lv13hsTs1yXtsj)rLxERAbJKkdbROhEXxlUWtO7(sfojQNFy1MBw6O(VX2eTHMlxD(bBWb4VO6NKBT9AjwoG)(exVd0((aewvz2982nX0O0GuvuxhvPx(ZazyUbo4Q6PzQnAP6sMJAH7qTVpfeZp7QuM3T8Kc2aW20fdNIWwHZaRGOp)0DzclP7qskmEwhZZ5x0cv78K4Zrh00yj02ffMUFCMMJipOgTZJPIjADDmcNw4pbjREvIMpDjGkjNNVojuABXVACjkA8tUjPpOEmd7Dj8iaxcEZ1p3)k2XAmcicZzzqpqYNWswEGTYwWvs3rMVkm
