#!/usr/bin/env raku

sub unicode-sparkline (+@n) {
   @n
   andthen 8 «*« $_ »/» max($_)
   andthen .map: { ( |('▁'..'█'), '█' )[$_] }\
   andthen .join
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unicode-sparkline(0...7...0), '▁▂▃▄▅▆▇█▇▆▅▄▃▂▁';
    is unicode-sparkline(1,14,3,8,5,9), '▁█▂▅▃▆';
    done-testing;
}

multi MAIN (*@n) {
    say unicode-sparkline @n
}
