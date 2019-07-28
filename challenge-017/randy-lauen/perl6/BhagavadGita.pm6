use Cro::HTTP::Client;

class BhagavadGita {
    constant $base-uri = 'https://bhagavadgita.io';
    has $.access-token;
    has $!client = Cro::HTTP::Client.new(
        http         => '1.1', # See https://github.com/croservices/cro-http/issues/74
        base-uri     => $base-uri,
        content-type => 'application/json',
        auth         => { bearer => $!access-token },
    );

    # Class method
    method get-access-token( :$client-id!, :$client-secret! ) returns Str {
        my $response = await Cro::HTTP::Client.post(
            "$base-uri/auth/oauth/token",
            content-type => 'application/x-www-form-urlencoded',
            body => %(
                client_id     => $client-id,
                client_secret => $client-secret,
                grant_type    => 'client_credentials',
                scope         => 'verse chapter',
            ),
        );
        my $json = await $response.body;
        return $json<access_token>;
    }

    method chapters() {
        return self!get-json( uri => '/api/v1/chapters' );
    }

    method chapter( :$chapter! ) {
        return self!get-json( uri => "/api/v1/chapters/$chapter" );
    }

    multi method verses() {
        return self!get-json( uri => '/api/v1/verses' );
    }

    multi method verses( :$chapter! ) {
        return self!get-json( uri => "/api/v1/chapters/$chapter/verses" );
    }

    method verse( :$chapter!, :$verse! ) {
        return self!get-json( uri => "/api/v1/chapters/$chapter/verses/$verse" );
    }

    method !get-json( :$uri ) {
        my $response = await $!client.get( $uri );
        return await $response.body;
    }
}


