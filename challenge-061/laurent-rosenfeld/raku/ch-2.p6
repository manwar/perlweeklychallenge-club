use v6;

my $octet = rx {( || 0
                  || <[ 1..9 ]> \d ** 0..2
                ) <?{0 <= $0 <= 255}>
               };
sub MAIN (Int $in = 122202128) {
    for $in ~~ m:ex/^ (<$octet>) ** 4 $/ -> $match {
        say join ".", $match[0];
    }
}
