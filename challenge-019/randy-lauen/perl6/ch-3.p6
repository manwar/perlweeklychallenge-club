#!/usr/bin/env perl6

=begin SYNOPSIS

Write a script to use NYT Books API. The API is documented here:
https://developer.nytimes.com/docs/books-product/1/overview

Usage:
    # Output the names of all NYT Best Seller Lists.
    $ perl6 ch-3.p6 --api-key=KEY --lists

    # Output the books on a random NYT Best Seller List for a random date.
    $ perl6 ch-3.p6 --api-key=KEY --random

    # Output the books for the given NYT Best Seller List on a random date.
    $ perl6 ch-3.p6 --api-key=KEY --random --list='Hardcover Graphic Books'

=end SYNOPSIS

use Cro::HTTP::Client;
use URI::Encode;

class NYTBooks {
    has $.api-key;
    has $!client = Cro::HTTP::Client.new(
        :http('1.1'),
        :base-uri('https://api.nytimes.com'),
        headers => [ Accept => 'application/json' ],
    );

    method lists() {
        my $body = self!get-json( "/svc/books/v3/lists/names.json?api-key=$!api-key" );
        return $body<results>;
    }

    method list-books-on-date( :$list!, :$date! ) {
        my $body = self!get-json( "/svc/books/v3/lists/$date/$list.json?api-key=$!api-key" );
        return $body<results><books>;
    }

    method !get-json( $uri ) {
        my $encoded = uri_encode( $uri );
        my $response = await $!client.get( $encoded );
        return await $response.body;
    }
}

# Output all the NYT Best Sellers lists.
multi MAIN( :$api-key!, Bool :$lists! ) {
    my $api = NYTBooks.new( :$api-key );
    say $api.lists().map( { .<list_name> } ).join("\n");
}

# Output the books for a random date. If no list-name is given, use a random list.
multi MAIN( :$api-key!, Bool :$random!, :$list-name is copy ) {
    my $api = NYTBooks.new( :$api-key );

    # Retrieve all lists.
    my $lists = $api.lists();

    # Pick a list at random, or find the given list name.
    my $list;
    if ( $list-name.defined ) {
        $list = $lists.first: { .<list_name> eq $list-name };
        die "Could not find list '$list-name'" unless $list;
    }
    else {
        $list = $lists.pick();
        $list-name = $list<list_name>;
    }

    # Find a random date between the newest and oldest publication of the list.
    my $date = pick 1, ( Date.new($list<oldest_published_date>) .. Date.new($list<newest_published_date>) );

    # Find the books for the date and list.
    my $books = $api.list-books-on-date( :list($list-name), :$date );
    say "On $date, the '$list-name' list contained the following books:";

    # Output info about each title.
    for $books.flat -> $book {
        say "  $book<rank>. $book<title> by $book<author>";
        say ' ' x (4 + $book<rank>.chars), $book<description>;
    }
}

