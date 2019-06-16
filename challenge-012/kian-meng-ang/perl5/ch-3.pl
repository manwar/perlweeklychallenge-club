#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

use Carp;
use Config::Tiny;
use Const::Fast;
use HTTP::Tiny;
use JSON::Tiny qw(decode_json);
use XML::Hash::XS;

const my $BASE_URL => 'https://www.abbreviations.com/services/v2/syno.php';
const my $SERVICE => 'synonyms';

MAIN: {
    my $word = $ARGV[0] || croak q|Missing word!|;
    my $word_info = _find_word_info(_config(), $word);

    say $word_info->{synonyms};
}

sub _config {
    my $rc_file = qq|$ENV{HOME}/.stands4rc|;
    my $config = Config::Tiny->read($rc_file) || croak qq|Missing $rc_file!|;

    $config->{$SERVICE}->{uid} || croak q|Missing API uid!|;
    $config->{$SERVICE}->{token} || croak q|Missing API token!|;

    return $config;
}

sub _find_word_info {
    my ($config, $word) = @_;

    my $params = {
        uid     => $config->{$SERVICE}->{uid},
        token   => $config->{$SERVICE}->{token},
        word    => $word,
        format  => 'json',
    };

    my $ua = HTTP::Tiny->new();
    my $response = $ua->get($BASE_URL, $params);

    if (!$response->{success}) {
        croak qq|ERROR: $response->{code}, $response->{status}, $response->{reason}!|;
        return;
    }

    # Error response is always a XML string regardless the `format` was
    # explicitly set to `json`. See (2).
    my $results = ($response->{content} =~ m/xml/)
        ? xml2hash($response->{content})
        : decode_json($response->{content})->{results};

    croak qq|ERROR: $results->{error}| if (exists $results->{error});

    return $results->{results}->{result};
}

1;

__END__

Note to self:
(1) `HTTP::Tiny` does not have built-in way to deserialize JSON or XML response
    data compare to `Mojo::UserAgent`.
(2) Is there a better way to resolve inconsistency in returned HTTP body
    content? How do we check for JSON or XML string?
(3) Not all `XX::Tiny` CPAN modules were created or maintained equally.

