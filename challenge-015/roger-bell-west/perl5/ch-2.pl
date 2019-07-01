#! /usr/bin/perl

use strict;
use warnings;

use Getopt::Std;

my %o;

getopts('dk:h',\%o);

# Ensure we have a key
unless ($o{k}) {
  $o{h}=1;
}
if ($o{h}) {
  print STDERR <<EOF;
Usage: $0 -k KEY (-d)
Use -d to decrypt.
Encryption/decryption is from stdin to stdout.
EOF
  exit 0;
}

my @alphabet=('A'..'Z');
my %tonumber=map {$alphabet[$_] => $_} (0..$#alphabet);

$o{k}=strip($o{k});
my %ak=map {$_=>1} @alphabet;
my @k;
foreach my $kl (split '',$o{k}) {
  if (exists $ak{$kl}) {
    push @k,($o{d}?-1:1)*$tonumber{$kl};
    delete $ak{$kl}
  }
}
my $keylen=scalar @k;

while (<>) {
  chomp;
  my @pt=map {$tonumber{$_}} split '',strip($_);
  my @ct;
  foreach my $n (0..$#pt) {
    push @ct,$alphabet[($pt[$n]+$k[$n%$keylen])%26];
  }
  print join('',@ct),"\n";
}

sub strip {
  my $r=shift @_;
  $r=uc($r);
  $r =~ s/[^A-Z]//g;
  return $r;
}
