#!/usr/bin/env perl

# Perl Weekly Challenge 165 - Task 1 - solution by Paulo Custodio
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
    return <<END;
<line x1="$x1" y1="$y1" x2="$x2" y2="$y2" stroke="black" />
END
}

my $file=shift or die "usage: ch-1.pl file.svg\n";
open(my $f, ">", $file) or die "open $file: $!";
print $f svg_header(100,100);
while (<>) {
    chomp;
    my @p=split /\s*,\s*/,$_;
    if (@p==2) {
        print $f svg_point(@p);
    }
    elsif (@p==4) {
        print $f svg_line(@p);
    }
    else {
        die "cannot parse: $_";
    }
}
print $f svg_footer();
