#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;

sub MAIN(
    Str:D :$config-file? = $*HOME.add(".languageapi").Str,
    Str:D :$url          = 'https://ws.detectlanguage.com/0.2/detect',
) {
    my $info = get-language(:text($*IN.slurp), :$url, :$config-file);
    my $result = $info<detections>[0];
    say "Language: { $result<language> }";
    say "Is reliable: { $result<isReliable> }";
    say "Confidence: { $result<confidence>.fmt("%.2f") }";
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines.first;
}

# Usage:
#   :$text        = Text to look up
#   :$url         = base URL
#   :$config-file = Name of config file to use
#
sub get-language (
    Str:D :$text,
    Str:D :$url,
    Str:D :$config-file,
) {
    my $api-key = get-api-key($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri     => $url,
        headers      => [ Authorization => "Bearer $api-key" ],
        content-type => 'application/json',
    );

    my $resp = await $client.post('', body => %( q => $text ) );
    my $json = await $resp.body;

    if $json<data>:exists {
        return $json<data>;
    } else {
        return;
    }

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body";
        }
    }
}

