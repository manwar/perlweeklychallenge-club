#!/usr/bin/perl
# Test: ./ch-1.pl -u
use strict;
use warnings;
use feature qw /say/;
use Getopt::Long;

# Unique flag
my $unique;
GetOptions ("unique"  => \$unique);

# Hash to store unique emails
my %unique_emails;

# Data
my @data = qw /
    name@example.org
    rjt@cpan.org
    Name@example.org
    rjt@CPAN.org
    user@alpha.example.org
/;

my @sorted_data = sort by_domain @data;
@sorted_data = grep { make_unique($_) } @sorted_data
    if ($unique);
say join "\n", @sorted_data;

# Check if the email is unique
sub make_unique {
    my $email = shift;
    my ($user, $domain) = split_email($email);
    my $unique_email = $user . '@' . lc($domain);

    return 0
    	if ($unique_emails{$unique_email});

    $unique_emails{$unique_email} = 1;
    return 1;
}

# Sort by domain function
sub by_domain {
    my ($user_a, $domain_a) = split ('\@', $::a);
    my ($user_b, $domain_b) = split ('\@', $::b);
    lc($domain_a) cmp lc($domain_b) or
    $user_a       cmp $user_b;
}

# Split email into username and domain
sub split_email {
    return split ('\@', shift);
}
