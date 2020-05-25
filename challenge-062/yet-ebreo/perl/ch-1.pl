#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Getopt::Long 'GetOptions';

my $unique;
my @files;

GetOptions(
    'unique'       => \$unique,
    "file=s{1,}"   => \@files,
);

my %seen = ();
sub sort_email {
    chomp(my @data = @_);
    for my $email ( sort { lc $a=~s/.*@//r cmp lc $b=~s/.*@//r or  $a=~s/@.*//r cmp $b=~s/@.*//r } @data ) {
        $email=~/@/;
        $unique ? !$seen{$`.(lc $')} && say $email : say $email;
        $seen{$`.lc $'}++;
    }
}
my @emails;
if (@files) {
    for my $file (@files) {
        if (-e $file) {
            open my $handle, '<', $file;
            push @emails, <$handle>;
            close $handle;
        }
    } 
} else {
    push @emails, <DATA>;
}

sort_email(@emails);
__DATA__
name@example.org
rjt@cpan.org
Name@example.org
rjt@CPAN.org
user@alpha.example.org