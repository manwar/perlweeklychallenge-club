use v6;
# use Grammar::Tracer;

grammar URL {
    rule TOP {
        <scheme> '//' <authority>? <path> [ '?' <query> ]?
        <fragment>?
    }
    token scheme { \w+ [ ':' \w+]? ':'}
    token authority { [<userinfo> '@']? <host> [':' <port>]? }
    token userinfo { <user> [':' <password> ]?}
    token user { \w+ }
    token password { <-[ @ ]>+ }
    token host {
        || <hostname>
        || <ipv4>
        || <ipv6>
    }
    token hostname { \w+ [ '.' \w+ ]* }
    token ipv4 { <octet> ['.' <octet> ] ** 3 }
    token octet { (\d ** 1..3) <?{0 <= $0 <= 255 }>}
    token ipv6 { '[' <group> ** 8 ']' }
    token group { <xdigit> ** 4 }
    token port { \d+ }
    token path { '/' <segment>? [ '/' <segment> ]* }
    token segment { \w+ [ '::' \w+ ]? }
    token query {  \w+ '=' <[\w\s]>+ }
    token fragment { '#' <frag_id> }
    token frag_id { \w+ }
}
sub display (Str $label, Str $value) {
    printf "    %-15s:\t %-20s\n", $label, $value;
}

for ('jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1',
     'https://en.wikipedia.org/wiki/URL',
     'https://perlcon.eu/my',
     'https://www.perlmonks.org/?node=Seekers of Perl Wisdom',
     'https://metacpan.org/pod/Test::More'
    ) -> $url-string {
    my $match = URL.parse($url-string);
    if $match {
        say "Matched $url-string:";
        display "scheme", ~$match<scheme>;
        display "userinfo", ~$match<authority><userinfo>
            if defined $match<authority><userinfo>;
        display "host", ~$match<authority><host>
            if defined $match<authority><host>;
        display "port", ~$match<authority><port>
            if defined $match<authority><port>;
        display "path", ~$match<path>;
        display "query", ~$match<query>
            if defined $match<query>;
        display "fragment", ~$match<fragment>
            if defined $match<fragment>;
    } else {
        say "Not matched $url-string";
    }
}
