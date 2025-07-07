use 5.036;
use JSON::XS 'encode_json';
use List::Util 'uniq';

my @inputs = @ARGV;

for my $string (@inputs) {
    #my $new_string = $string =~ y/a-z/ /r;
    #my @unique_integers = uniq split ' ', $new_string;
    my @unique_integers = map int, uniq $string =~ /0*(\d+)/g;
    printf "%-30s -> %s\n", $string, encode_json \@unique_integers;
}
