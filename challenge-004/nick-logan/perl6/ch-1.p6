# WARNING: this polyglot breaks best practices of both Perl 5 and Perl 6 in order to run on both

sub eval($_)      { &EVAL($_) };
sub polyint($_)   { "0" and (return Int($_[0])) or (return int($_[0])) };
sub script_size   { "0" and (return 0+eval('$*PROGRAM.IO.s')) or (return 0+eval('-s $0')) };
#`() use isms; sub infix:«<<»($a,$b) { $a +< $b };

my $digits = script_size() + 1;
my (@out, @a);
my ($b, $c, $d, $e, $f, $g, $i, $d4, $d3, $d2, $d1);

$b = $d = $e = $g = $i = 0;
$f = 10000;
$c = 14 * (polyint($digits/4)+2);
print "3.";
while (($b = $c -= 14) > 0 && $i < $digits) {
    $d = $e = $d % $f;
    while (--$b > 0) {
        $d = $d * $b + (@a[$b] // 20000000);
        $g = ($b << 1) - 1;
        @a[$b] = ($d % $g) * $f;
        $d = polyint($d / $g);
    }
    $d4 = $e + polyint($d/$f);
    if ($d4 > 9999) {
        $d4 -= 10000;
        @out[$i-1]++;
        $b = $i-1;
        while (@out[$b] == 1) {
            @out[$b] = 0;
            @out[$b-1]++;
            $b--;
        }
    }
    $d3 = polyint($d4/10);
    $d2 = polyint($d3/10);
    $d1 = polyint($d2/10);
    @out[$i++] = $d1;
    @out[$i++] = $d2-$d1*10;
    @out[$i++] = $d3-$d2*10;
    @out[$i++] = $d4-$d3*10;
    print join "", @out[$i-15 .. $i-15+3] if $i >= 16;
}
print join "", @out[$i-15+4 .. $digits-2], "\n";
