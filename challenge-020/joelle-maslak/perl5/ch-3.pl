#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Gets the image for an MB car based on VIN
#
# This uses the sandbox URL, pass in different base-url to use the
# production service.
#
# Download the front view of MB based on VIN (roof closed, daytime).

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use Mojo::UserAgent;
use Mojo::Util qw(url_escape);
use Path::Tiny;
use Perl6::Slurp;

MAIN: {
    my $configfile = path( $ENV{HOME} // "", ".mb" )->stringify();
    my $baseurl    = 'https://api.mercedes-benz.com/tryout/vehicle_images/v1/';
    my $outfile    = 'image.png';
    GetOptions(
        "base-url=s"    => \$baseurl,
        "config-file=s" => \$configfile,
        "output-file=s" => \$outfile,
    );
    if ( @ARGV == 0 ) { die("Must provide VIN") }
    my $vin = shift(@ARGV);
    if ( @ARGV > 0 ) { die("Invalid parameter") }

    my $secret   = get_client_secret($configfile);
    my $imageids = get_image_ids( $secret, $vin, $baseurl );
    download_image($secret, $imageids->{EXT000}, $outfile, $baseurl);
}

sub get_client_secret($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

sub get_image_ids( $secret, $vin, $baseurl ) {
    my $ua = Mojo::UserAgent->new();

    my $tx = $ua->get(
        "${baseurl}vehicles/" . url_escape($vin) . "?apikey=" . url_escape($secret),
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        return $tx->result->json;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{errorMessage};
}


sub download_image( $secret, $imageid, $outfile,$baseurl ) {
    my $ua = Mojo::UserAgent->new();

    my $tx = $ua->get(
        "${baseurl}images/" . url_escape($imageid) . "?apikey=" . url_escape($secret),
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        return $tx->result->save_to($outfile);
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{errorMessage};
}

