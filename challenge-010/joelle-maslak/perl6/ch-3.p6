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
    Str:D :$config-file? = $*HOME.add(".sendgrid").Str,
) {
    my $api-key   = get-api-key($config-file);

    send-email(:$api-key, :$from, :to($to.split(';')), :$subject, :$body-text);
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines[0];
}

# Usage:
#   $api-key   = Your Sendgrid API key
#   $from      = Source email address
#   @to        = Array of destination email addresses
#   $subject   = Subject of email
#   $body-text = Text of email
#
sub send-email(
    Str:D :$api-key,
    Str:D :$from,
          :@to,
    Str:D :$subject,
    Str:D :$body-text,
) {
    my $url = "https://api.sendgrid.com/v3/mail/";

    my $client = Cro::HTTP::Client.new(
        base-uri     => $url,
        content-type => 'application/json',
        headers      => [ Authorization => "Bearer $api-key" ],
    );

    my @recipients;
    for @to.unique -> $addr {
        @recipients.push: %( email => $addr );
    }

    my %json =
        personalizations => [
            %(
                to => @recipients,
            ),
        ],
        from    => %( email => $from ),
        subject => $subject,
        content => [
            %( type => 'text/plain', value => $body-text ),
        ],
    ;

    my $resp = await $client.post('send', body => %json);
    dd $resp;
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

