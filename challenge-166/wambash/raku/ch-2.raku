#!/usr/bin/env raku

sub map-diff ( %map ) {
    my $k = %map.elems;

    %map
    andthen .invert
    andthen .classify: *.key, as => *.value
    andthen .nodemap: *.sort
    andthen .grep: { .value.elems < $k }\
    andthen .Map
}

multi MAIN (Bool :test($)!) {
    use Test;
    is map-diff(%(a => <A B>, b => <A C>) ), (B => <a>, C => <b>).Map;

    my %dir := %(
        a => <Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  Impact.otf  Verdana.ttf  Old_Fonts/>,
        b => <Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Tahoma.ttf  Verdana.ttf>,
        c => <Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Monaco.ttf  Verdana.ttf>,
    );
    my %diff := %(
        'Comic_Sans.ttf'  => <a b>,
        'Courier_New.ttf' => <b c>,
        'Georgia.ttf'     => <a>,
        'Monaco.ttf'      => <c>,
        'Old_Fonts/'      => <a>,
        'Tahoma.ttf'      => <b>,
    );
    is map-diff(%dir), (%diff).Map;
    done-testing;
}

multi MAIN (+@dirs) {
    @dirs
    andthen .map: { $_ => .IO.dir».basename } \
    andthen map-diff .Map
    andthen .put
}
