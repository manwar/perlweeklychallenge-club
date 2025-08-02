#!/usr/bin/env perl
use strict;
use warnings;

sub defrag_ip_address{
  $_[0] =~ s/\./\[\.\]/gr
}

printf "%s\n",defrag_ip_address('1.1.1.1');
printf "%s\n",defrag_ip_address('255.101.1.0');

