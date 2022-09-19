#!/usr/bin/perl
use 5.030;
use warnings;

sub permute (&@) {
    my $code = shift;
    my @idx = 0..$#_;
    while ( $code->(@_[@idx]) ) {
        my $p = $#idx;
        --$p while $idx[$p-1] > $idx[$p];
        my $q = $p or return;
        push @idx, reverse splice @idx, $p;
        ++$q while $idx[$p-1] > $idx[$q];
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }
}

my $n = 1;

while(1) {
    my @perms;
    permute { push @perms, \@_; } split //, $n;
    my %perms =  map { $_ => 1 } map { join q{}, @{$_}; } @perms; 

    if  (exists $perms{6 * $n} &&
         exists $perms{5 * $n} &&
         exists $perms{4 * $n} &&
         exists $perms{3 * $n} &&
         exists $perms{2 * $n}) {
            last;
    }

    $n++;
}

say $n;
