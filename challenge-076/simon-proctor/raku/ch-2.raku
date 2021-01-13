#!/usr/bin/env raku

use v6;

subset ValidFile of Str where *.IO.f;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a word search grid file and a dictionary file print all the words you can find in the grid
sub MAIN (
    ValidFile $grid = "main-grid.txt", #= Word search grid (default "main-grid.txt")
    ValidFile $dict = "/etc/dictionaries-common/words", #= Dictionary file (default "/etc/dictionaries-common/words")
    Int :$min = 5, # Minimum length of word to look for
) {
    my @horiz-lines;

    for $grid.IO.lines -> $line {
        say $line;
        @horiz-lines.push( $line.split(" ").Array );
    }
    my @vert-lines = vert-lines( @horiz-lines );
    my @diag-lines = diag-lines( @horiz-lines );
    my @rev-diag-lines = diag-lines( @horiz-lines.map( *.reverse ) );

    my @all-matches = (|@horiz-lines, |@horiz-lines.map( *.reverse ),
                       |@vert-lines, |@vert-lines.map( *.reverse ),
                       |@diag-lines, |@diag-lines.map( *.reverse ),
                       |@rev-diag-lines, |@rev-diag-lines.map( *.reverse ),
                      ).map( *.join ).unique;
    my $max = @all-matches.map(*.codes).max;
    my $any-match = any(@all-matches);
    
    my @finds = lazy $dict.IO.lines.race
    ==> grep( { $min <= $_.codes <= $max } )
    ==> map( { [ $_, rx/"{$_.uc}"/ ] } )
    ==> grep(
        -> @ ($word, $match) {
            $any-match ~~ $match
        } )
    ==> map( -> @ ($word, $match) { $word } );

    .say for @finds;
}

sub vert-lines( @lines ) {
    my @vert-lines;

    my $height = @lines.elems;
    my $width = @lines[0].elems;
    
    for 0..^$height -> $i {
        for 0..^$width -> $j {
            @vert-lines[$j][$i] = @lines[$i][$j];
        }
    }
    return @vert-lines;
}

sub diag-lines( @lines ) {
    return [ |diag-lines-across(@lines), |diag-lines-down(@lines) ];
    
}

sub diag-lines-across( @lines ) {
    my @diag-lines;

    my $width = @lines[0].elems;
    my $height = @lines.elems;

    for 0..^$width -> $start {
        my @out;
        my $vert = 0;
        my $idx = $start;
        while $vert < $height && $idx < $width {
            @out.push( @lines[$vert][$idx] );
            $vert++;
            $idx++;
        }
        @diag-lines.push(@out);
    }
    return @diag-lines;
}

sub diag-lines-down( @lines ) {
    my @diag-lines;

    my $width = @lines[0].elems;
    my $height = @lines.elems;

    for 1..^$height -> $start {
        my @out;
        my $horiz = 0;
        my $idx = $start;
        while $horiz < $width && $idx < $height {
            @out.push( @lines[$idx][$horiz] );
            $horiz++;
            $idx++;
        }
        @diag-lines.push(@out);
    }
    return @diag-lines;

}
