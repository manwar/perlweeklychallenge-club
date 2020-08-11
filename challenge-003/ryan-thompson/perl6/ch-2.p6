#!/usr/bin/env perl6

# ch-2.p6 - Generate Pascal's Triangle
#
# Ryan Thompson <rjt@cpan.org>

use v6;

#| Instructive binomial coefficient implementation from Perl 6 Examples page
sub infix:<choose> { [*] ($^n … 0) Z/ 1 .. $^p }

sub MAIN( Int $height = 12 ) {
    pascal-triangle($height);
}

#| Print Pascal's Triangle, up to the specified height
sub pascal-triangle( Int $h ) {
    my $width = ($h choose ($h / 2).Int).chars; # Widest element

    for ^$h -> $n {
        my @row = (0..$n).map: { $n choose $_ };
        my $str = @row.fmt("%{$width}d").join;
        say ' ' x ($h * ($width + 1) / 2 - $str.chars / 2).Int ~ $str;
    }
}

