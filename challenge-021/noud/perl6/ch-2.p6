# Write a script for URL normalization based on rfc3986. This task was shared
# by Anonymous Contributor.
#
# According to Wikipedia, URL normalization is the process by which URLs are
# modified and standardized in a consistent manner. The goal of the
# normalization process is to transform a URL into a normalized URL so it is
# possible to determine if two syntactically different URLs may be equivalent.

use Test;

sub normalize_url($url is copy) {
    given $url {
        s:g/(\w+)/{lc $0}/;     # Convert the scheme and host to lower case.
        s:g/\%(<xdigit>**2)/\%{uc $0}/;  # Capitalizing letters in escape squences.
        s:g/\%(<[4..7]><xdigit>)/{:16(~$0).chr}/;  # Decode ALPHA
        s:g/\%(3\d)/{:16(~$0).chr}/;  # Decode DIGIT
        s:g/\%2D/-/;            # Decode hyphen.
        s:g/\%2E/./;            # Decode period.
        s:g/\%5F/_/;            # Decode underscore.
        s:g/\%7E/~/;            # Decode tilde.
        s/\:80//;               # Removing the default port.
        s:g/\/\.\//\//;         # Removing dot-segment '.'.
        s:g/\/\.\.\//\//;       # Removing dot-segment '..'.
        s/^https/http/;         # Limiting protocols.
        s:g/<!after http\:>\/\//\//;    # Remove duplicated slashes.
    };
    return $url;
}


sub MAIN() {
    plan 7;

    my $exp1 = "HTTP://www.Example.com/";
    my $ret1 = "http://www.example.com/";
    ok normalize_url($exp1) === $ret1;

    my $exp2 = "http://www.example.com/a%c2%b1b";
    my $ret2 = "http://www.example.com/a%C2%B1b";
    ok normalize_url($exp2) === $ret2;

    my $exp3 = "http://www.example.com/%2D%2E%5F%7E%41%2D";
    my $ret3 = "http://www.example.com/-._~A-";
    ok normalize_url($exp3) === $ret3;

    my $exp4 = "http://www.example.com:80/";
    my $ret4 = "http://www.example.com/";
    ok normalize_url($exp4) === $ret4;

    my $exp5 = "http://www.example.com/../a/b/../c/./d.html";
    my $ret5 = "http://www.example.com/a/b/c/d.html";
    ok normalize_url($exp5) === $ret5;

    my $exp6 = "https://www.example.com/https";
    my $ret6 = "http://www.example.com/https";
    ok normalize_url($exp6) === $ret6;

    my $exp7 = "http://www.example.com//a";
    my $ret7 = "http://www.example.com/a";
    ok normalize_url($exp7) === $ret7;
}
