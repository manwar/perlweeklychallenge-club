#!/usr/bin/env perl
#
# Find the details of a given word using the Words API
# (https://www.wordsapi.com/docs/)
#
# Dependencies: HTTP-Message, LWP, JSON
################################################################################

use strict;
use warnings;
use open ':std', ':encoding(UTF-8)'; # To correctly display pronunciations

use HTTP::Request;
use LWP::UserAgent;
use JSON qw<decode_json>;

# API key read from environment
my $WORDSAPI_KEY = $ENV{'WORDSAPI_KEY'} or die "WORDSAPI_KEY not defined";
my $WORD = shift or die "Usage: $0 <word>\n";

my $ua = LWP::UserAgent->new;
$ua->agent("gramos's script for perlweeklychallenge.org");
my $uri = "https://wordsapiv1.p.mashape.com/words/$WORD";
my @headers = ("X-Mashape-Key", $WORDSAPI_KEY);
my $response = $ua->request(HTTP::Request->new("GET", $uri, \@headers));

# Check for errors in API request
if ($response->is_error()) {
    if ($response->code == 404) {
        die "Word '$WORD' not found\n";
    } else {
        die "Unknown error: " . $response->message;
    }
}

my $json_resp = decode_json $response->content;

my $syllables = $json_resp->{'syllables'};
if ($syllables && $syllables->{'count'} > 1) {
    printf "Word: '$WORD' (%s)\n", join("-", @{$syllables->{'list'}});
} else {
    print "Word: '$WORD'\n";
}

my $pronunciation = $json_resp->{'pronunciation'};
if (ref($pronunciation) eq "HASH") {
    my %pronunciations = %{$pronunciation};
    if ($pronunciations{'all'}) {
        print "Pronunciation: /$pronunciations{'all'}/\n";
    } else {
        print "Pronunciation:\n";
        foreach my $k (keys %pronunciations) {
            print "  as $k: /$pronunciations{$k}/\n";
        }
    }
} elsif ($pronunciation) {
    # This case is not documented, thanks WordsAPI.
    print "Pronunciation: /$pronunciation/\n";
}

my $frequency = $json_resp->{'frequency'};
if ($frequency) {
    print "Frequency: ";
    print $frequency > 5 ? "frequently used"
        : $frequency > 3 ? "occasionally used"
        : $frequency > 1 ? "rarely used"
        : "never used";
    print "\n";
}

my $results = $json_resp->{'results'};
if ($results) {
    print "Definitions:\n";
    foreach my $res (@$results) {
        printf "  - (%s) %s\n", $res->{'partOfSpeech'}, $res->{'definition'};
        my $synonyms = $res->{'synonyms'};
        if ($synonyms) {
            printf "    synonyms: %s\n", join(", ", @$synonyms);
        }
        my $examples = $res->{'examples'};
        if ($examples) {
            foreach my $example (@$examples) {
                print qq'    "$example"\n';
            }
        }
        print "\n";
    }
}
