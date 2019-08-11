#!/usr/bin/env perl6
use v6;

# Gets the image for an MB car based on VIN
#
# This uses the sandbox URL, pass in a different base-url to use the
# production service.
#
# Download the front view of a MB based on VIN (roof closed, daytime).

use Cro::HTTP::Client;
use URI::Encode;

sub MAIN(
    Str:D $vin,
    Str:D :$config-file? = $*HOME.add(".mb").Str,
    Str:D :$base-url     = 'https://api.mercedes-benz.com/tryout/vehicle_images/v1/',
    Str:D :$output-file  = 'image.png',
) {
    my $image-ids = get-image-ids(:$config-file, :$base-url, :$vin);
    my $png       = get-image(:$config-file, :$base-url, :image-id($image-ids<EXT000>), :$output-file);

    my $fh = open $output-file, :w, :bin;
    $fh.write($png);
    $fh.close;
}

sub get-client-secret(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines[0];
}

sub get-image-ids(
    Str:D :$vin,
    Str:D :$base-url,
    Str:D :$config-file,
) {
    my $secret = get-client-secret($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri     => $base-url,
    );

    my $resp = await $client.get(
        "vehicles/{ uri_encode_component($vin) }" ~
            "?apikey={ uri_encode_component($secret) }",
    );
    my $json = await $resp.body;
    return $json;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<errorMessage>";
        }
    }
}

sub get-image(
    Str:D :$image-id,
    Str:D :$output-file,
    Str:D :$base-url,
    Str:D :$config-file,
) {
    my $secret = get-client-secret($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri     => $base-url,
    );

    my $resp = await $client.get(
        "images/{ uri_encode_component($image-id) }" ~
            "?apikey={ uri_encode_component($secret) }",
    );
    my $img = await $resp.body;
    return $img;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<errorMessage>";
        }
    }
}


