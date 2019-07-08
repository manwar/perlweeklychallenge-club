#!/usr/bin/perl

use strict;
use warnings;
use WebService::DetectLanguage;

my $key = "xxxxxxxxxxxx";
my $api = WebService::DetectLanguage->new(key => $key);

# Supported Languages
foreach my $lang ($api->languages) {
    printf "code=%s  name=%s\n",
           $lang->code,
           $lang->name;
}

# Account status
my $status = $api->account_status();

printf "plan=%s  status=%s\n",
    $status->plan,
    $status->status;

my $text = "It was a bright cold day in April, ...";
my @results = $api->detect($text);

foreach my $result (@results) {
    printf "language = %s (%s)  confidence = %f  reliable = %s\n",
        $result->language->name,
        $result->language->code,
        $result->confidence,
        $result->is_reliable ? 'Yes' : 'No';
}
