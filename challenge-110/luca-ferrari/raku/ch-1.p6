#!raku


sub MAIN( Str $file-name = 'phone.txt' ) {
    my @regexps = rx / ^ \s* <[+]> \d ** 2 \s+ \d ** 10 $ /
                , rx / ^ \s* <[(]> \d ** 2 <[)]> \s+ \d ** 10 $ /
                , rx / ^ \s* \d ** 4 \s+ \d ** 10 $ /;

    say $_ if $_ ~~ any @regexps for $file-name.IO.lines;
}
