#!/usr/bin/env perl
use strict;
use warnings;
use File::Basename;
my %ext;
while (<DATA>) {
	s/(:?\s+)|(:?,)/ /g;
	my @f=split(" ");
        my $type= shift(@f) =~ /^text\// ? "text": "binary";
        $ext{$_}=$type for @f;
}
for (@ARGV) { 
	my ($filename, $dir, $suffix)=fileparse($_, qr/\.[^.]*/);
	my $type=$ext{substr $suffix, 1};
	$type="binary" if ! $type;
	print "$_: The file content is $type\n";


}

__DATA__
text/html                                        html htm shtml
text/css                                         css
text/xml                                         xml
text/mathml                                      mml
text/plain                                       txt
text/vnd.sun.j2me.app-descriptor                 jad
text/vnd.wap.wml                                 wml
text/x-component                                 htc
