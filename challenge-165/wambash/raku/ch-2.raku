#!/usr/bin/env raku




sub line-of-best-fit (+@point) {
    @point
    andthen .map: { .[0]²,.[0], .[0],1,  .[0] * .[1],.[1]}\
    andthen [Z,] $_
    andthen .map: *.sum
    andthen  (.[4]*.[3]-.[5]*.[2]),(.[0]*.[5]-.[1]*.[4]) X/ (.[0]*.[3]-.[1]*.[2])
}

multi MAIN (Bool :test($)!) {
    use Test;
    is line-of-best-fit((0,0),(1,1)),(1,0);
    is line-of-best-fit((0,0),(1,2)),(2,0);
    is line-of-best-fit((0,10),(1,20),(1,0)),(0,10);
    done-testing;
}

#| echo "333,129  39,189 140,156 292,134 393,52  160,166 362,122  363,89" | raku ch-2.raku -from=0 -to=400 | raku ch-1.raku -height=200 -width=400 > point-line.svg
multi MAIN (Numeric :$from=0,Numeric :$to=600) {
    my $points= slurp();
    say $points;
    $points.words()
    andthen .map: *.split: ','
    andthen line-of-best-fit($_)
    andthen $from,.[0]*$from+.[1], $to,.[0]*$to+.[1]
    andthen .join(',').say
}
