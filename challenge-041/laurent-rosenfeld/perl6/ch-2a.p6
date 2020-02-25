use v6;
my @leo = 1, 1;
sub leonardo (Int $in) {
    return @leo[$in] if defined @leo[$in];
    @leo[$in] = [+] 1, leonardo($in - 1), leonardo($in -2);
}
sub MAIN (Int $input = 19) {
    leonardo $input;
    say @leo;
}
