#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use Syntax::Construct qw{ // };

use Storable qw{ store retrieve };


sub help {
    say STDERR "Usage: $0 help";
    say STDERR "       $0 create index doc1 doc2...";
    say STDERR "       $0 search index term";
}

sub create {
    my ($index_file, @documents) = @_;
    my %index;
    for my $document (@documents) {
        warn $document;
        open my $in, '<', $document or do {
            warn "$document: $!";
            next
        };
        while (<$in>) {
            push @{ $index{$1}{$document} }, $. while /(\w+)/g;
        }
    }
    store(\%index, $index_file);
}

sub search {
    my ($index_file, $term) = @_;
    my %index = %{ retrieve($index_file) };
    for my $document (keys %{ $index{$term} }) {
        say "$document: ", join ' ', @{ $index{$term}{$document} };
    }
}

sub unknown {
    help();
    die "Unknown action\n";
}

my $action = shift;

my %dispatch = (
    help   => \&help,
    create => \&create,
    search => \&search,
);

my $run = $dispatch{$action} // \&unknown;

$run->(@ARGV);

