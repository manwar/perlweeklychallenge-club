#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-16
# Week: 012
# Challenge: #3
#
# Find out the synonyms of a given word using the Synonyms API. The API
# challenge is optional but would love to see your solution.
# https://www.synonyms.com/synonyms_api.php
# Usage: perl ch-3.pl help
# Output:
#  ===========================================
# | HELP                                      |
# |-------------------------------------------|
# | the activity of contributing to the       |
# | fulfillment of a need or furtherance of   |
# | an effort or purpose                      |
# |===========================================|
# | SYNONYMS                                  |
# |-------------------------------------------|
# | help, service, supporter, assistance,     |
# | attention, financial aid, care, assist,   |
# | helper, economic aid, avail, assistant,   |
# | tending, aid                              |
#  ===========================================


use strict;
use warnings;
use feature qw / say /;
use LWP::Simple;
use JSON::MaybeXS;
use YAML::XS 'LoadFile';
use Perl6::Form;

my $config  = LoadFile('stands4.yml');
my $word    = $ARGV[0];
my $uid     = $config->{uid};
my $tokenid = $config->{token};
my $api_url
    = "http://www.stands4.com/services/v2/syno.php?uid=$uid&tokenid=$tokenid&word=$word&format=json";

my $content = get($api_url);
die "Couldn't get it!" unless defined $content;

my %result = %{decode_json($content)};
my $definition = $result{"result"}[0]{definition};
my $synonyms = $result{"result"}[0]{synonyms};

my $text = form ' =========================================== ',
                '| {<<<<<<<<<}                               |',
                   uc $word,
                '|-------------------------------------------|',
                '| {[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[} |',
                   $definition,
                '|===========================================|',
                '| SYNONYMS                                  |',
                '|-------------------------------------------|',
                '| {[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[} |',
                   $synonyms,
                ' =========================================== ';

print $text;
