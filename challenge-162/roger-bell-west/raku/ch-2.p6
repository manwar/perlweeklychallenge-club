#! /usr/bin/perl6

use Test;

plan 2;

is(encrypt("playfair example",
           "hide the gold in the tree stump"),
   "bmodzbxdnabekudmuixmmouvif",'example 1');

is(decrypt("perl and raku",
           "siderwrdulfipaarkcrw"),
   "thewexeklychallengex",'example 2');


sub encrypt($kw,$plaintext) {
  return playfair(1,$kw,$plaintext);
}

sub decrypt($kw,$ciphertext) {
  return playfair(-1,$kw,$ciphertext);
}

sub playfair ($dir,$kwi,$input) {
    my $kw='';
    {
        my %k;
        for ($kwi.lc ~ join('','a'..'z')).comb -> $char0 {
            my $char = $char0;
            if ($char eq 'j') {
                $char='i';
            }
            if ($char ~~ /<[a..z]>/) {
                unless (%k{$char}:exists) {
                    %k{$char}=1;
                    $kw ~= $char;
                }
            }
        }
    }
    my @grid;
    my %gc;
    {
        my $index=0;
        for (0..4) -> $row {
            my @r;
            for (0..4) -> $column {
                push @r,substr($kw,$index,1);
                %gc{substr($kw,$index,1)}=[$row,$column];
                $index++;
            }
            push @grid, @r;
        }
    }
    my $ii=lc($input);
    $ii ~~ s:g/<-[a..z]>//;
    $ii ~~ s:g/j/i/;
    my @ichars=$ii.comb;
    my $out = '';
    my $index=0;
    while ($index < @ichars.elems) {
        my $ca=@ichars[$index];
        my $cb=@ichars[$index+1] || 'x';
        $index+=2;
        if ($ca eq $cb) {
            $cb='x';
            $index--;
        }
        my ($car,$cac)=%gc{$ca};
        my ($cbr,$cbc)=%gc{$cb};
        my ($oar,$oac,$obr,$obc)=($car,$cac,$cbr,$cbc);
        if ($car == $cbr) {
            $oac=posmod($cac+$dir,5);
            $obc=posmod($cbc+$dir,5);
        } elsif ($cac == $cbc) {
            $oar=posmod($car+$dir,5);
            $obr=posmod($cbr+$dir,5);
        } else {
            $oac=$cbc;
            $obc=$cac;
        }
        $out ~= @grid[$oar][$oac] ~ @grid[$obr][$obc];
    }
    return $out;
}

sub posmod($a,$b) {
  my $m=$a % $b;
  while ($m < 0) {
    $m += $b;
  }
  return $m;
}
