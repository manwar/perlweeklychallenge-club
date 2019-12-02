#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Syntax::Construct qw{ /r };

use WWW::Mechanize;
use HTML::TableExtract;

my $url_template
    = 'https://www.timeanddate.com/sun/uk/london?month=%m%&year=2019';
my $mech = 'WWW::Mechanize'->new;

my %seconds;
for my $month (11, 12) {
    my $url = $url_template =~ s/%m%/$month/r;
    $mech->get($url);
    my $te = 'HTML::TableExtract'->new;
    $te->parse($mech->content);
    my $table = $te->first_table_found;
    for ($table->rows) {
        my $time = $_->[3] or next;

        my ($h, $m, $s) = $time =~ /^([0-9]+):([0-9]+):([0-9]+)$/
            or next;
        $s += $m * 60 + $h * 60 * 60;
        $seconds{$month} += $s;
    }
}

my $s       = $seconds{11} - $seconds{12};
my $seconds = $s % 60;
my $m       = ($s - $seconds) / 60;
my $minutes = $m % 60;
my $hours   = ($m - $minutes) / 60;

say sprintf "%d seconds or %d:%02d:%02d", $s, $hours, $minutes, $seconds;
