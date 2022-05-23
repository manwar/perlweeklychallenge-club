# :vim ft=raku sw=4 expandtab

my constant $stroke-width = 1;
my constant $min-radius = 1;

sub SVGize( @ary is copy --> Str) is export {

    my @dot = '<circle cx="', '" cy="',
                qq{" r="$min-radius" stroke="orange"/>\n};
    my @line  = '<line x1="', '" y1="', '" x2="', '" y2="',
                qq{" stroke="lightgreen" stroke-width="1"/>\n};

    return _prefix()
           ~ @ary.map( {  2 == $_.elems
                ?? roundrobin( @dot,  @$_).flat.join
                !! roundrobin( @line, @$_).flat.join;
             }).join()
           ~ _suffix();
}

sub _prefix( --> Str ) {
    qq{<?xml version="1.0" standalone="no"?>\n}
  ~ qq{<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" \n}
  ~ qq{"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n}
  ~ qq{<svg width="100%" height="100%" version="1.1"\n}
  ~ qq{xmlns="http://www.w3.org/2000/svg">\n}
}

sub _suffix( --> Str ) {
    q{</svg>}
}
