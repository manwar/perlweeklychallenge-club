#!/usr/bin/raku

sub MAIN(
    Str $str1,
    Str $str2
) {
    my @source = $str1.words;
    my @target = $str2.words;
    my $result = False;

    TOP: for 0 ..^ @source.elems -> $i {
        for $i ..^ @source.elems -> $j {
            my @temp = @source;
            @temp.splice($i, $j - $i + 1, @temp[$i..$j].reverse);

            if @temp.join eq @target.join {
                $result = True;
                last TOP;
            }
        }
    }

    say $result;
}