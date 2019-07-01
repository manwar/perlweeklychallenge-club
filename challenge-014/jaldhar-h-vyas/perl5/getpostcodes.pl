#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;
use LWP::Simple;
use HTML::TableParser;
use constant FEDERAL_STATE => 1;
use constant USPS => 5;

my @abbrevs;

sub row {
    my ($columns) = $_[2];
    if ($columns->[FEDERAL_STATE] =~ /State/) {
        push @abbrevs, lc $columns->[USPS];
    }
}

my $page =
    get('https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations') //
    die "Couldn't fetch page: $OS_ERROR\n";

my $tableParser = HTML::TableParser->new (
    [
        {
            id => 'DEFAULT',
            row => \&row
        }
    ],
);

$tableParser->parse($page);

say 'my @abbrevs = ( qr/', (join q{/, qr/}, @abbrevs), '/ );' 