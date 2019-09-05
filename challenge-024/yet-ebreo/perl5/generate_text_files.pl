use strict;
use warnings;
use 5.010;

# hmmm... how about we use the random poems to generate some text files?
use LWP::Simple qw($ua get);
use JSON;
$ua->timeout(30);
my $api_content = get "https://www.poemist.com/api/v1/randompoems" || die "Request Timeout\n";
my @data = @{ decode_json($api_content) };

my $file_ctr = 1;
for (@data) {
    if ($_->{title}!~/\p{Arabic}/ && $_->{content}!~/[^\x00-\x7E]/m) {
        open(my $fh, '>', "file$file_ctr\.txt");
        print $fh  $_->{content};
        close $fh;
        $file_ctr++;
    }
}