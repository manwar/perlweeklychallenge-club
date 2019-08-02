#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use Carp;
use Config::Tiny;
use JSON::MaybeXS;
use REST::Client;
use Data::Dumper;
use Text::ANSITable;
binmode(STDOUT, ":utf8");

# Output
# $ perl ch-3.pl soliloquy
#     Word: soliloquy
#  1  Definition: speech you make to yourself
#
#     Part of Speech: noun
#
#     Type of: speech, voice communication, speech communication, spoken
#     communication, spoken language, language, oral communication
#
#     Synonyms: monologue
#
#  2  Definition: a (usually long) dramatic speech intended to give the illusion
#     of unspoken reflections
#
#     Part of Speech: noun
#
#     Type of: actor's line, speech, words
#
#     Synonyms: -

MAIN: {
    my $word = $ARGV[0] || croak q|Missing word!|;
    my $word_info = _fetch_word(_config(), $word);
    _display_word_info($word, $word_info);
}

sub _display_word_info {
    my ($word, $word_info) = @_;

    my $t = Text::ANSITable->new(use_utf8 => 1, pad => 0);
    $t->border_style('Default::none_ascii');
    $t->columns(['', qq|Word: $word|]);

    my $i = 1;
    foreach (@{$word_info->{results}}) {
        my $info = '';
        $info .= "Definition:\n" . $_->{definition} . "\n\n";
        $info .= "Part of Speech:\n" . $_->{partOfSpeech} . "\n\n";
        $info .= "Type of:\n" . (join ', ', @{$_->{typeOf}}) . "\n\n";
        $info .= "Synonyms:\n"
            . (($_->{synonyms} && join ', ', @{$_->{synonyms}}) || '-') . "\n";

        $t->add_row([$i++, $info]);
    }
    print $t->draw;
}

sub _fetch_word {
    my ($config, $word) = @_;

    my $sample_json = do { local $/; <DATA> };

    # The JSON string is already decoded, skip it otherwise you will expect
    # "Wide character in subroutine entry at ch-3.pl line 25, <DATA> line 1."
    # error.
    # See https://stackoverflow.com/a/10710462
    return JSON::MaybeXS->new->utf8(0)->decode($sample_json) if $config->{test};

    my $client = REST::Client->new;
    $client->addHeader('X-Mashape-Key', $config->{key});
    $client->setHost($config->{url});

    my $response = $client->GET("/words/$word");
    my $body = $response->responseContent();
    my $code = $response->responseCode();
    $code >= 400 && croak sprintf 'Error: HTTP (%s) %s', $code, $body;

    my $json = decode_json($body);
    return $json;
}

sub _config {
    my $rc_file = qq|$ENV{HOME}/.wordsapi.rc|;
    my $config = Config::Tiny->read($rc_file)->{_} || croak qq|Missing $rc_file!|;

    $config->{url} || croak q|Missing API URL!|;
    $config->{key} || croak q|Missing API key!|;
    $config->{test} || croak q|Missing test flag!|;

    return $config;
}


# Sample data from https://www.wordsapi.com/docs/
# Unfortunately, you have to sign up with your credit card details before you
# can obtain the API key. ;-(

1;
__DATA__
{
   "results":[
      {
         "definition":"speech you make to yourself",
         "partOfSpeech":"noun",
         "synonyms":[
            "monologue"
         ],
         "typeOf":[
            "speech",
            "voice communication",
            "speech communication",
            "spoken communication",
            "spoken language",
            "language",
            "oral communication"
         ],
         "derivation":[
            "soliloquize"
         ]
      },
      {
         "definition":"a (usually long) dramatic speech intended to give the illusion of unspoken reflections",
         "partOfSpeech":"noun",
         "typeOf":[
            "actor's line",
            "speech",
            "words"
         ],
         "derivation":[
            "soliloquize"
         ]
      }
   ],
   "syllables":{
      "count":4,
      "list":[
         "so",
         "lil",
         "o",
         "quy"
      ]
   },
   "pronunciation":{
      "all":"sə'lɪləkwi"
   }
}
