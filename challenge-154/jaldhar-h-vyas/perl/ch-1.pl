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

my @partial = qw/ PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP ELPR ELRP
RPEL RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE LREP /;

my @permutations;

permute { push @permutations, \@_; } split //, "PERL";
my %full = map { $_ => undef } map { join q{}, @{$_}; } @permutations;

for my $part (@partial) {
    $full{$part}++;
}

say join q{ }, grep { $_ if !defined $full{$_} } keys %full;