#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $unique = 0;
GetOptions('u' => \$unique);

my %seen;
my @emails;

while (my $email = <>) {
    chomp $email;
    next if $unique && $seen{$email}++;
    push @emails, $email;
}

sub email_sort {
    my ($mailbox_a, $domain_a) = split '@', $a;
    my ($mailbox_b, $domain_b) = split '@', $b;

    lc($domain_a) cmp lc($domain_b) || $mailbox_a cmp $mailbox_b;
}

my @sorted_emails = sort email_sort @emails;

for my $email (@sorted_emails) {
    print "$email\n";
}

