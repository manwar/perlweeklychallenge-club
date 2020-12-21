#!/usr/bin/env perl6
use v6;

# run as <script> <VIN>

use HTTP::Tiny;
use JSON::Fast;

my $VIN=@*ARGS[0];
my $URL=qq{https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/$VIN?format=json};

my $resp = HTTP::Tiny.new.get($URL);
say from-json($resp<content>.decode).<Results>.[0].<ErrorText>;

