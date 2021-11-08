#!/usr/bin/env raku

multi MAIN () {
    run 'toilet', '-f', 'bigmono12', '♀'
    or samewith :u;
}

multi MAIN ( Bool :unicode(:u($))! ) {
    say '♀';
}
