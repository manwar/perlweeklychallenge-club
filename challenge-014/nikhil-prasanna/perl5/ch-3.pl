#no error handling so please ensure net connectivity :P
use strict;
use warnings;
use utf8;
use LWP::UserAgent ();
use Data::Dumper;
use JSON;

my $ua = LWP::UserAgent->new();
my $host = "http://geodb-free-service.wirefreethought.com";
my $city = <STDIN>;
chomp $city;
print $host."/v1/geo/cities?limit=5&offset=0&namePrefix=$city\n";
my $response = $ua->get($host."/v1/geo/cities?limit=5&offset=0&namePrefix=$city");
my $content = decode_json($response->decoded_content); # content
my @cityArr = @{$content->{"data"}};
# print Dumper(\@cityArr);
print "List of cities \n";

for my $i (0 .. $#cityArr){
    my $index = $i+1;
 print "$index. $cityArr[$i]{'city'}\n";
}
print "Local time of which city you want to know (enter the corresponding number)\n";
my $number = <STDIN>;
chomp $number;

my $id = $cityArr[$number-1]{'id'};

$response = $ua->get($host."/v1/geo/cities/".$id. "/time");
my $time = decode_json($response->decoded_content);
print $time->{'data'};
