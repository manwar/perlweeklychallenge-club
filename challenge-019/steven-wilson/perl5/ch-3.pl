#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-30
# Week: 019
#
# Task #3
# Write a script to use NYT Books API. You can get API key here. For
# more information about API, please visit page. The API task is
# optional but we would love to see your solution.

use strict;
use warnings;
use feature qw/ say /;
use Data::Dumper;
use LWP::UserAgent;
use JSON::MaybeXS;
use YAML::XS 'LoadFile';

my $config   = LoadFile('nytimes_api_key.yml');
my $api_key  = $config->{api_key};
my $base_url = "https://api.nytimes.com/svc/books/v3";

my $ua = LWP::UserAgent->new();

# Best Sellers Lists Services
# List Names
# The lists/names service returns a list of all the NYT Best Sellers
# Lists. Some lists are published weekly and others monthly. The
# response includes when each list was first published and last
# published.
# /lists/names.json

my $response = $ua->get("$base_url/lists/names.json?api-key=$api_key");
my %rd       = %{ decode_json( $response->decoded_content ) };
my @results  = @{ $rd{results} };
my $query    = "E-Book";
say "NYT Best Sellers Lists containing the word \"$query\"";
for my $item (@results) {
    if ( $$item{list_name} =~ /$query/ ) {
        say $$item{list_name};
    }
}
print "\n\n";

# List Data
# The lists/{date}/{name} service returns the books on the best sellers
# list for the specified date and list name.
# /lists/2019-01-20/hardcover-fiction.json
$response = $ua->get(
    "$base_url/lists/2014-07-01/business-books.json?api-key=$api_key");
%rd      = %{ decode_json( $response->decoded_content ) };
@results = @{ $rd{results}{books} };

say
    "$rd{results}{display_name} $rd{results}{updated} list published $rd{results}{published_date}";

for my $item (@results) {
    say "$$item{title} by $$item{author}";
}
print "\n\n";

# Use "current" for {date} to get the latest list.
# /lists/current/hardcover-fiction.json
$response
    = $ua->get(
    "$base_url/lists/current/combined-print-and-e-book-nonfiction.json?api-key=$api_key"
    );
%rd      = %{ decode_json( $response->decoded_content ) };
@results = @{ $rd{results}{books} };

say
    "$rd{results}{display_name} $rd{results}{updated} list published $rd{results}{published_date}";

for my $item (@results) {
    say "$$item{title} by $$item{author}";
}
print "\n\n";

# Book Reviews Services
# The book reviews service lets you get NYT book review by author, ISBN,
# or title.

# /reviews.json?author=Michelle+Obama
my $forename = "Bruce";
my $surname  = "Sterling";
$response = $ua->get(
    "$base_url/reviews.json?author=$forename+$surname&api-key=$api_key");
%rd      = %{ decode_json( $response->decoded_content ) };
@results = @{ $rd{results} };

say "Book reviews for $forename $surname";
for my $item (@results) {
    say "$$item{book_title} reviewed by $$item{byline}\n$$item{url}";
}
print "\n\n";

# /reviews.json?isbn=9781524763138
my $isbn = "9781524763138";
$response = $ua->get(
    "$base_url/reviews.json?isbn=$isbn&api-key=$api_key");
%rd      = %{ decode_json( $response->decoded_content ) };
@results = @{ $rd{results} };

say "Book review for isbn $isbn";
for my $item (@results) {
    say "$$item{book_title} by $$item{book_author} reviewed by $$item{byline}\n$$item{url}";
}
print "\n\n";

# /reviews.json?title=Becoming
my $title = "Becoming"; # This is the only one I can get to work
$response = $ua->get(
    "$base_url/reviews.json?title=$title&api-key=$api_key");
%rd      = %{ decode_json( $response->decoded_content ) };
@results = @{ $rd{results} };

say "Book review for title $title";
for my $item (@results) {
    say "$$item{book_title} by $$item{book_author} reviewed by $$item{byline}\n$$item{url}";
}
