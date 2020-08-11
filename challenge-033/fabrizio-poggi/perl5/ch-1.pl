use strict;
use warnings;

my ($tota, $totb, $totc, $totd, $tote, $totf, $totg, $toth, $toti, $totj, $totk, $totl, $totm, $totn, $toto, $totp, $totq, $totr, $tots, $tott, $totu, $totv, $totx, $toty, $totw, $totz) = 0;

my ($a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r, $s, $t, $u, $v, $x, $y, $w, $z) = 0;

my $file;
my $fh;
my @files;

if (@ARGV) {
(@files) = @ARGV;
} else {
die "Use: perl alphabet.pl file1 [file2] [..] $!\n";
}

for $file (@files){
  open ($fh, "<", $file) 
        or die "Cannot open < text1: $!";
  while (my $row = <$fh>) {
	    chomp $row;
        $tota += $a = ($row =~ tr/a|A//);
        $totb += $b = ($row =~ tr/b|B//);
        $totc += $c = ($row =~ tr/c|C//);
        $totd += $d = ($row =~ tr/d|D//);
        $tote += $e = ($row =~ tr/e|E//);
        $totf += $f = ($row =~ tr/f|F//);
        $totg += $g = ($row =~ tr/g|G//);
        $toth += $h = ($row =~ tr/h|H//);
        $toti += $i = ($row =~ tr/i|I//);
        $totj += $j = ($row =~ tr/j|J//);
        $totk += $k = ($row =~ tr/k|K//);
        $totl += $l = ($row =~ tr/l|L//);
        $totm += $m = ($row =~ tr/m|M//);
        $totn += $n = ($row =~ tr/n|N//);
        $toto += $o = ($row =~ tr/o|O//);
        $totp += $p = ($row =~ tr/p|P//);
        $totq += $q = ($row =~ tr/q|Q//);
        $totr += $r = ($row =~ tr/r|R//);
        $tots += $s = ($row =~ tr/s|S//);
        $tott += $t = ($row =~ tr/t|T//);
        $totu += $u = ($row =~ tr/u|U//);
        $totv += $v = ($row =~ tr/v|V//);
        $totw += $w = ($row =~ tr/w|W//);
        $totx += $x = ($row =~ tr/x|X//);
        $toty += $y = ($row =~ tr/y|Y//);
        $totz += $z = ($row =~ tr/z|Z//);
     }
}
print "a: $tota \n";
print "b: $totb \n";
print "c: $totc \n";
print "d: $totd \n";
print "e: $tote \n";
print "f: $totf \n";
print "g: $totg \n";
print "h: $toth \n";
print "i: $toti \n";
print "j: $totj \n";
print "k: $totk \n";
print "l: $totl \n";
print "m: $totm \n";
print "n: $totn \n";
print "o: $toto \n";
print "p: $totp \n";
print "q: $totq \n";
print "r: $totr \n";
print "s: $tots \n";
print "t: $tott \n";
print "u: $totu \n";
print "v: $totv \n";
print "w: $totw \n";
print "x: $totx \n";
print "y: $toty \n";
print "z: $totz \n";
close $fh;
