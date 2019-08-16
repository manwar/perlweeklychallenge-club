use v6;
use Test;

sub normalize (Str $url is copy) {
    constant $unreserved = (0x41..0x5A, 0x61..0x7A, 0x2D, 0x2E, 0x5F, 0x7E).Set;
    given $url {
        s:g/(\w+)/{lc $0}/;      # Lowercase letters
        s:g/('%'\w\w)/{uc $0}/;  # Capitalizing letters in escape sequences
        s:g/'%'(<xdigit>**2)     # Decoding percent-encoded octets
           <?{ (+"0x$0") (elem) $unreserved }> # code assertion
           /{:16(~$0).chr}/;
        s/':' 80 '/'/\//;        # Removing default port
        s:g/'/../'/\//;          # Removing two-dots segments
        s:g/'/./'/\//;           # Removing dot segments
    }
    return $url;
}

plan 5;
for < 1 HTTP://www.Example.com/
        http://www.example.com/
      2 http://www.example.com/a%c2%b1b
        http://www.example.com/a%C2%B1b
      3 http://www.example.com/%7Eusername/
        http://www.example.com/~username/
      4 http://www.example.com:80/bar.html
        http://www.example.com/bar.html
      5 http://www.example.com/../a/../c/./d.html
        http://www.example.com/a/c/d.html
    > -> $num, $source, $target {
        cmp-ok normalize($source), 'eq', $target, "Test $num";
}
