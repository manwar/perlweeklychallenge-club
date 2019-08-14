#!/usr/bin/perl
use strict;
use warnings;
use feature qw /say/;
use Test::More tests => 5;

sub normalize {
    my $url = shift;
    my %unreserved = map {$_ => 1} 0x41..0x5A, 0x61..0x7A, 0x2D, 0x2E, 0x5F, 0x7E;
    for ($url) {
        s/(\w+)/lc $1/ge;    # Lowercase letters
        s/(%\w\w)/uc $1/ge;  # Capitalizing letters in escape sequences
        # Decoding percent-encoded octets
        if (/%([[:xdigit:]]{2})/ and exists $unreserved{hex $1} ) {
            s/%([[:xdigit:]]{2})/chr hex "0x$1"/xge;
        }
        s{:80/}{/};          # Removing default port
        s{/\.\./}{/}g;       # Removing two-dots segments
        s{/\./}{/}g;         # Removing dot segments
    }
    return $url;
}

for ( [ 1, 'HTTP://www.Example.com/',              'http://www.example.com/' ],
      [ 2, 'http://www.example.com/a%c2%b1b',      'http://www.example.com/a%C2%B1b' ],
      [ 3, 'http://www.example.com/%7Eusername/',  'http://www.example.com/~username/' ],
      [ 4, 'http://www.example.com:80/bar.html',   'http://www.example.com/bar.html' ],
      [ 5, 'http://www.example.com/../a/../c/./d.html', 'http://www.example.com/a/c/d.html' ]
    ) {
        my ($num, $source, $target) = @$_;
        is normalize($source),  $target, "Test $num";
}
