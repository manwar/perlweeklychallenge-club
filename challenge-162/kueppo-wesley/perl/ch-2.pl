#!/usr/bin/env perl

use strict;
use feature 'say';
use Test;

BEGIN { plan test => 4 }

sub generate_square {
    my $key = $_[0];
    my @box;

    $key  =~ s/ +//g;
    $key  =~ s/j/i/i;
    do {;} while $key  =~ s/(.)(.*?)\g{-2}/$1$2/;
    $key  .=  join '', grep { $_ !~ /[$key]/ } split //, q(abcdefghiklmnopqrstuvwxyz);
    push @box, $1 while $key =~ /(.{5})/g;

    return @box;
}

sub generate_digrams {
    my $text = $_[0];

    $text =~ s/j/i/i;
    $text =~ s/ +//g;
    do {;} while $text =~ s/^((?:..)*?)(.)\g2/$1$2x$2/;
    $text .= q(x) unless int (length($text) % 2) == 0;

    return $text;
}

sub encrypt {
    my $key  = $_[0];
    my $text = $_[1];
    my @box  = ();
    my $cipher;

    @box = generate_square $key;
    $text = generate_digrams $text;

    # cycle through digrams to generate ciphertext
    while ($text =~ /(.)(.)/g) {
    	my $x  = $1;
    	my $y  = $2;
    	my ($xi, $xc) = (-1, -1);
    	my ($yi, $yc) = (-1, -1);

    	foreach (my $i = 0; $i < @box; $i++) {
    		my $s = $box[$i];

    		if    ($s =~ /$x(?|([^$y]).*$y(.)|($y)(.)).*$/) { $cipher .= "$1$2"; last; }
    		if    ($s =~ /$y(?|([^$x]).*$x(.)|($x)(.)).*$/) { $cipher .= "$2$1"; last; }
    		elsif ($s =~ /^(.).*$x(?|([^$y]).*$y|($y))$/)   { $cipher .= "$2$1"; last; }
    		elsif ($s =~ /^(.).*$y(?|([^$x]).*$x|($x))$/)   { $cipher .= "$1$2"; last; }
    		else {
    			if ($s =~ /$x/) { $xi = index($s, $x); $xc = $i + 1; }
    			if ($s =~ /$y/) { $yi = index($s, $y); $yc = $i + 1; }
    		}
    	}
    	if ($xi > -1 && $yi > -1) {
    		my ($c1, $c2);

    		if ($xi == $yi) {
    			$xc = 0 if $xc == @box;
    			$yc = 0 if $yc == @box;
    			($c1, $c2)     =  ( substr($box[$xc], $xi, 1), substr($box[$yc], $yi, 1) );
    			$cipher       .= $c1 . $c2;
    		}
    		else {
    			($c1, $c2)     =  ( substr($box[$xc - 1], $yi, 1), substr($box[$yc - 1], $xi, 1) );
    			$cipher       .= $c1 . $c2;
    		}
    		$xi = -1; $yi = -1;
    	}
    }

    return $cipher;
}

sub decrypt {
    my $key    = $_[0];
    my $cipher = $_[1];
    my $decrypt;
    my @box;


    @box = generate_square($key);

    while ($cipher =~ /(.)(.)/g) {
    	my $x  = $1;
    	my $y  = $2;
    	my ($xi, $xc) = (-1, -1);
    	my ($yi, $yc) = (-1, -1);

    	foreach (my $i = 0; $i < @box; $i++) {
    		my $s = $box[$i];

    		if    ($s =~ /(.)(?|($x)$y|$x.*(.)$y)/)      { $decrypt .= "$1$2"; last; }
    		if    ($s =~ /(.)(?|($y)$x|$y.*(.)$x)/)      { $decrypt .= "$2$1"; last; }
    		elsif ($s =~ /^$y.*(.)(?|($x)|$x.*(.))$/)    { $decrypt .= "$2$1"; last; }
    		elsif ($s =~ /^$x.*(.)(?|($y)|$y.*(.))$/)    { $decrypt .= "$2$1"; last; }
    		else {
    			if ($s =~ /$x/) { $xi = index($s, $x); $xc = $i - 1; }
    			if ($s =~ /$y/) { $yi = index($s, $y); $yc = $i - 1; }
    		}
    	}
    	if ($xi > -1 && $yi > -1) {
    		my ($c1, $c2);

    		if ($xi == $yi) {
    			$xc = 5 if $xc == @box;
    			$yc = 5 if $yc == @box;
    			($c1, $c2)     =  ( substr($box[$xc], $xi, 1), substr($box[$yc], $yi, 1) );
    			$decrypt       .= $c1 . $c2;
    		}
    		else {
    			($c1, $c2)     =  ( substr($box[$xc + 1], $yi, 1), substr($box[$yc + 1], $xi, 1) );
    			$decrypt       .= $c1 . $c2;
    		}
    		$xi = -1; $yi = -1;
    	}
    }

    return $decrypt;
}

ok encrypt("playfair example", "hide the gold in the tree stump"), "bmodzbxdnabekudmuixmmouvif";
ok decrypt("playfair example", "bmodzbxdnabekudmuixmmouvif"), "hidethegoldinthetrexestump";

ok encrypt("perl and raku", "thewexeklychallengex"), "siderwrdulfipaarkcrw";
ok decrypt("perl and raku", "siderwrdulfipaarkcrw"), "thewexeklychallengex";
