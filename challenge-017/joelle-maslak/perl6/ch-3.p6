#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;

sub MAIN(
    UInt:D $chapter,
    UInt:D $verse,
    Str:D :$config-file? = $*HOME.add(".bhagavad-gita").Str,
    Str:D :$base-url     = 'https://bhagavadgita.io/',
) {
    say get-verse(:$config-file, :$base-url, :$chapter, :$verse);
}

sub get-client-id(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of two lines" if @lines.elems ≠ 2;

    return @lines.first;
}

sub get-client-secret(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of two lines" if @lines.elems ≠ 2;

    return @lines[1];
}


sub get-verse (
    UInt:D :$chapter,
    UInt:D :$verse,
    Str:D  :$base-url,
    Str:D  :$config-file,
) {
    my $id = get-client-id($config-file);
    my $secret = get-client-secret($config-file);
    
    my $token-client = Cro::HTTP::Client.new(
        base-uri     => $base-url,
        content-type => 'application/x-www-form-urlencoded',
    );

    my $resp = await $token-client.post(
        'auth/oauth/token',
        body => %(
            client_id => $id,
            client_secret => $secret,
            grant_type => "client_credentials",
            scope => "verse chapter"
        )
    );
    my $response = await $resp.body;
   
    my $client = Cro::HTTP::Client.new(
        http         => 1.1,
        base-uri     => $base-url,
        headers      => [ Authorization => "Bearer $response<access_token>" ],
        content-type => 'application/json',
    );
    $resp = await $client.get("api/v1/chapters/$chapter/verses/$verse");
    my $json = await $resp.body;

    return $json<text>;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

