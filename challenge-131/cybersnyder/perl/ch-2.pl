#! /usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my $input = "{}()";
my $teststring = "(({hello world}))";
my $open;
my $close;
my $i = 0;

foreach my $char (split //, $input) {
    if ( ($i % 2) == 0 ) {
        $open .= $char;
    } else {
        $close .= $char;
    }
    $i++;
}    

my @opened = grep { $_ =~ /[$open]/ } split( //, $teststring );
print "Open characters : ", join ('', @opened), "\n";

my @closed = grep { $_ =~ /[$close]/ } split( //, $teststring );
print "Close characters : ", join ('', @closed), "\n";
