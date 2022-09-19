#!/usr/bin/perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-178/
#https://en.wikipedia.org/wiki/Quater-imaginary_base
use strict; use warnings; use v5.10;

sub c2q {                       #complex to quater-imaginary
    my($r,$i) = @_;             #real and imaginary part
    die if grep$_!=int,@_;      #...which must be ints, challenge didnt specify
    my $qr = _qu($r);
    my $qi = _qu(int $i/2 + $i%2/2);
    my $q = '';
    map { $q = ( s/.$// ? $& : 0 ) . $q } $qr, $qi while length $qr.$qi;
    $q = '0' if !length$q;
    $q =~ s,^0\B,,;
    $q .= '.2' if $i % 2;
    $q
}

sub q2c {                       #quater-imaginary to complex (real and imaginary part)
    my($q)=@_;
    my $i1 = $q=~s/\.2$//;
    die if $q !~ /^[0-3]+$/;    #die if not quater-imaginary string
    my $k = -1;
    my @c = (0,0);              #complex number returned, init to zero
    my @d = reverse split//,$q; #digits reversed
    $c[++$k%2] += $_ * 2**$k * ($k%4>1?-1:1) for @d;
    $c[1] -= $i1;               #decrease if .2
    @c
}

sub _ediv {                     #https://en.wikipedia.org/wiki/Euclidean_division
    use integer;
    my($n,$d)=@_;               #numerator and denominator
    $d==0 ? die : $n>=0 || $n%$d==0 ? ($n/$d,$n%$d) : ($n/$d+1-2*($d>0), $n%$d+abs$d)
}

sub _qu {
    my($n,$qu)=(@_,'');
    $n ? do{ my($q,$r)=_ediv($n,-4); _qu($q,$r.$qu) } : $qu
}

my @tests = ( #tests from wikipedia page
    [0,0      => 0],
    [4,0      => 10300],
    [7,0      => 10303],
    [5,0      => 10301],
    [35,23    => 121003.2],
    [-15,0    => 1030001],
    [0,15     => 102000.2],
    [0,-15    => 2010.2],
    [-1,0     => 103],
    [0,-2     => 1030],
    [-3,-2    => 1131],
    [293,-196 => 120231321],
  # real 1 to 16
    [ 1,0 => 1],      [ 2,0 => 2],     [ 3,0 => 3],     [ 4,0 => 10300],
    [ 1,0 => 1],      [ 2,0 => 2],     [ 3,0 => 3],     [ 4,0 => 10300],
    [ 5,0 => 10301],  [ 6,0 => 10302], [ 7,0 => 10303], [ 8,0 => 10200],
    [ 9,0 => 10201],  [10,0 => 10202], [11,0 => 10203], [12,0 => 10100],
    [13,0 => 10101],  [14,0 => 10102], [15,0 => 10103], [16,0 => 10000],
  # real -1 to -16
    [ -1,0 => 103],     [-2,0 => 102],      [-3,0 => 101],      [ -4,0 => 100],
    [ -5,0 => 203],     [-6,0 => 202],      [-7,0 => 201],      [ -8,0 => 200],
    [ -9,0 => 303],     [-10,0 => 302],     [-11,0 => 301],     [-12,0 => 300],
    [-13,0 => 1030003], [-14,0 => 1030002], [-15,0 => 1030001], [-16,0 => 1030000],
  # imag 1 to 16
    [0, 1 => 10.2],     [0, 2 => 10],       [0, 3 => 20.2],     [0, 4 => 20],
    [0, 5 => 30.2],     [0, 6 => 30],       [0, 7 => 103000.2], [0, 8 => 103000],
    [0, 9 => 103010.2], [0,10 => 103010],   [0,11 => 103020.2], [0,12 => 103020],
    [0,13 => 103030.2], [0,14 => 103030],   [0,15 => 102000.2], [0,16 => 102000],
  # imag -1 to -16
    [0, -1 => 0.2],     [0, -2 => 1030],    [0, -3 => 1030.2],  [0, -4 => 1020],
    [0, -5 => 1020.2],  [0, -6 => 1010],    [0, -7 => 1010.2],  [0, -8 => 1000],
    [0, -9 => 1000.2],  [0,-10 => 2030],    [0,-11 => 2030.2],  [0,-12 => 2020],
    [0,-13 => 2020.2],  [0,-14 => 2010],    [0,-15 => 2010.2],  [0,-16 => 2000],
);
my $err=0;
for(@tests){
    my($real, $imaginary, $expect) = @$_;
    my $got = c2q($real, $imaginary);
    my $result1 = $got eq $expect ? 'ok   ' : 'ERROR';
    say "$result1 c2q:   $real+${imaginary}i --> $got    (expected $expect)";
    my($got_real, $got_imaginary) = q2c($got);
    my $result2 = "$got_real+${got_imaginary}i" eq "$real+${imaginary}i" ? 'ok   ' : 'ERROR';
    say "$result2 q2c:   $got  --> $got_real+${got_imaginary}i";
    $err += $_ eq 'ERROR' for $result1, $result2;
}
say "Errors: $err, tests: ".2*@tests;
