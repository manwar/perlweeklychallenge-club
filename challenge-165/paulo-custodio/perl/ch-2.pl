#!/usr/bin/env perl

# Perl Weekly Challenge 165 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-165/

use Modern::Perl;

sub svg_header {
    my($width,$height)=@_;
    return <<END;
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="$height" width="$width" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
END
}

sub svg_footer {
    return <<'END';
</svg>
END
}

sub svg_circle {
    my($cx, $cy, $r)=@_;
    for($cx, $cy, $r) {$_=int($_);}
    return <<END;
<circle cx="$cx" cy="$cy" r="$r" stroke="black" />
END
}

sub svg_point {
    my($cx, $cy)=@_;
    return svg_circle($cx,$cy,1);
}

sub svg_line {
    my($x1,$y1,$x2,$y2)=@_;
    for($x1,$y1,$x2,$y2) {$_=int($_);}
    return <<END;
<line x1="$x1" y1="$y1" x2="$x2" y2="$y2" stroke="black" />
END
}


sub least_squares {
    my(@p)=@_;
    my($N,$sum_x,$sum_y,$sum_x2,$sum_xy);
    $N=scalar(@p);
    for (@p) {
        my($x,$y)=@$_;
        $sum_x+=$x;
        $sum_y+=$y;
        $sum_x2+=$x*$x;
        $sum_xy+=$x*$y;
    }
    my $m=($N*$sum_xy-$sum_x*$sum_y)/($N*$sum_x2-$sum_x*$sum_x);
    my $b=($sum_y-$m*$sum_x)/$N;
    return ($m,$b);
}

my $file=shift or die "usage: ch-1.pl file.svg\n";
open(my $f, ">", $file) or die "open $file: $!";
print $f svg_header(500,500);
my @p;
while (<>) {
    for (split ' ', $_) {
        my($x,$y)=split /,/, $_;
        push @p,[$x,$y];
        print $f svg_point($x,$y);
    }
}
my($m,$b)=least_squares(@p);
print $f svg_line(0,$b,500,$m*500+$b);
print $f svg_footer();
