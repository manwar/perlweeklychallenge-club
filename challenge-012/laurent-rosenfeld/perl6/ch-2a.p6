use v6;
sub infix:<compare-paths> ($a, $b) {
    join $*sep, gather for $a.split($*sep) Z $b.split($*sep) -> ($p, $q) {
        last unless $p eq $q;
        take $p;
    }
}
my $*sep = '/';
my @paths = </a/b/c /a/b/c/e /a/b/c/d/e /a/b/c/f>;
say [compare-paths] @paths;
