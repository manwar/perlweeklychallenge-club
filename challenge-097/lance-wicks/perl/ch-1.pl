use strict;
use warnings;

use lib './lib';
use Caesar;

use Getopt::Long;

my ($string,$n,$decode);
GetOptions(
    'string=s' => \$string,
    'n=i'      => \$n,
    'd'        => \$decode,
);

unless ($string && $n) {
    die <<"MESSAGE";

MISSING PARAMS

You need to provide:
 -s "the string to encode goes here"
 -n 3


eg perl ch-1.pl -s "foo bar" -n 3

Which rotates "foo bar" by three characters, returning:
CLL YXO

By default the script will encode, add the -d param to decode.


MESSAGE
}


my $caesar = Caesar->new;

my $text;
if ($decode) {
    $text = $caesar->decode(
        string => $string,
        n      => $n,
    );
} else {
    $text = $caesar->encode(
        string => $string,
        n      => $n,
    );

}
print $text;
print "\n";

