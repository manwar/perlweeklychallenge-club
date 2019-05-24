#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

use Cro::HTTP::Client;

sub MAIN(
    Str:D :$from,
    Str:D :$to,
    Str:D :$subject,
    Str:D :$body-text,
    Bool  :$sandbox,
    Str:D :$config-file? = $*HOME.add(".sparkpost").Str,
) {
    my $api-key   = get-api-key($config-file);

    send-email(:$api-key, :$from, :to($to.split(';')), :$subject, :$body-text, :$sandbox);
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines[0];
}

# Usage:
#   $api-key   = Your Mailgun API key
#   $from      = Source email address
#   @to        = Array of destination email addresses
#   $subject   = Subject of email
#   $body-text = Text of email
#   $sandbox   = Boolean indicating if we're using the "sandbox"
#
sub send-email(
    Str:D :$api-key,
    Str:D :$from,
          :@to,
    Str:D :$subject,
    Str:D :$body-text,
    Bool  :$sandbox,
) {
    my $url = "https://api.sparkpost.com/api/v1/";

    my $client = Cro::HTTP::Client.new(
        base-uri     => $url,
        content-type => 'application/json',
        headers      => [ Authorization => $api-key ],
    );

    my @recipients;
    for @to.unique -> $addr {
        @recipients.push: %{ address => $addr }
    }

    my %json =
        content => %{
            from    => $from,
            subject => $subject,
            text    => $body-text
        },
        recipients => @recipients,
    ;
    %json<options> = %{ sandbox => True } if $sandbox;

    my $resp = await $client.post('transmissions', body => %json);
    return;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            if $body<errors>[0]<description>:exists {
                die "Error from API endpoint: $body<errors>[0]<description>";
            } else {
                die "Error from API endpoint: $body<errors>[0]<message>";
            }
        }
    }
}

