#!/usr/bin/env perl

#
# PERL WEEKLY CHALLENGE - 062
# TASK #1 Sort Email Addresses:
# Write a script that takes a list of email addresses (one per line)
# and sorts them first by the domain part of the email address,
# and then by the part to the left of the @ (known as the mailbox).
# Note that the domain is case-insensitive, while the mailbox part is case sensitive
#

use strict;

sub sort_mail (;+) {
   my @addrs = @{shift()};
   my @sort = map { $_->[0] } 
              sort { lc($a->[1][1]) cmp lc($b->[1][1]) or $a->[1][0] cmp $b->[1][0] } 
              map { [ $_ , [ split '@' ] ] } 
              @addrs;
}

sub uniq_mail (;+) {
   my @addrs = @{shift()};
   my %uniq = map { $_ => $_ } 
              map { $_->[0] . '@' . lc ($_->[1]) } 
              map { [ split '@' ] } 
              @addrs;
   my @uniq = sort keys %uniq;
}


my @addrs = <DATA>;
chomp(@addrs);

my @sort = sort_mail @addrs;
my @uniq = uniq_mail @addrs;

my %idx = map { 'k' . $_ => $sort[$_] } 0 .. $#sort;
my %u2m = ();

for my $email (@uniq) {
   while (my ($k, $v) = each %idx) {
      if ($v eq $email ) {
         $u2m{ $k } = $email;
      } 
   }
}

my @uniq_sort = map { $u2m{$_} } sort keys %u2m;

{
   local $"="\n";
   print "--- Sort:\n@sort\n\n";
   print "--- Uniq:\n@uniq\n\n";
   print "--- Uniq & Sort:\n@uniq_sort\n\n";
}


__DATA__
name@example.org
rjt@cpan.org
Name@example.org
rjt@CPAN.org
user@alpha.example.org
