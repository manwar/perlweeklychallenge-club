# Write a script to use Random Poems API. This is the easiset API, 
# I have come across so far. You don’t need API key for this. 
# They have only route to work with (GET). 
# The API task is optional but we would love to see your solution.

use strict;
use warnings;
use 5.010;

use LWP::Simple qw(get);
use JSON;
binmode STDOUT, ":encoding(UTF-8)";

my $api_content = get "https://www.poemist.com/api/v1/randompoems";
my @data;
push @data, @{$_} for JSON->new->utf8->decode($api_content);

#Printing the info of the first poem
say "$data[0]{title} - $data[0]{poet}{name} - $data[0]{url}\n";

#Accessing all(5) poems
# for (@data) {
#     say "$_->{title} - $_->{poet}{name} - $_->{url}";
# }

#Printing the content of the first poem
say "$data[0]{content}";

