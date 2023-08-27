sub count-seniors (@in) {
    return (grep { .substr(11, 2) >= 60 }, @in).elems;
}
for <7868190130M7522 5303914400F9211 9273338290F4010>,
    <1313579440F2036 2921522980M5644> -> @test {
    printf "...%-s  ", .substr(11, 4) for  @test;
    say " => ", count-seniors @test;
}
