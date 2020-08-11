#!/usr/bin/env perl6

=begin SYNOPSIS

Task:
Write a script to use Random Poems API.

Usage:
    $ perl6 ch-3.p6

Notes:
This script prints the shortest poem returned by the randompoems endpoint.
The Poemist API docs are located here: https://poemist.github.io/poemist-apidoc/

=end SYNOPSIS

use Cro::HTTP::Client;

my $response = await Cro::HTTP::Client.get( "https://www.poemist.com/api/v1/randompoems" );
my $json = await $response.body;
my $poem = $json.sort({ .<content>.chars }).first;

say qq["$poem<title>" by $poem<poet><name>];
say '';
say $poem<content>;
say '';
say $poem<url>;

exit;


