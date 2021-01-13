#!/usr/bin/env perl
#
# Write a script to demonstrate LRU Cache feature. It should support operations
# get and set. Accept the capacity of the LRU Cache as command line argument.

use v5.30;
use warnings;

# use Test::More;
use Data::Dumper;

use experimental 'signatures';

my $capacity = shift or die "Usage: $0 <capacity>";

my ($start, $end);
my %finder;

while (1) {
    print "Enter command: ";
    chomp(my $cmd = <STDIN>);
    if ($cmd =~ /^set\((\d+)\,\s*(\d+)\)\z/) {
        my ($key, $val) = ($1, $2);
        my $node = new_node($key, $val);
        insert_node($node);
    } elsif ($cmd =~ /^get\((\d+)\)\z/) {
        my $key = $1;
        if (my $node = $finder{$key}) {
            insert_node(new_node($node->{key}, $node->{val}));
            say "\t# returns $node->{val}";
        } else {
            say "\t# returns -1";
        }
    } else {
        say "Invalid command";
    }

    display_cache();
}

sub display_cache {
    say "\nCache at this point:";
    print "[Least recently used] ";
    my @list;
    for (my $node = $end; defined $node; $node = $node->{prev}) {
        push @list, $node->{key};
    }
    print join ",", @list;
    say " [Most recently used]\n";
}

sub new_node ($key, $val) {
    return {
        key  => $key,
        val  => $val,
        prev => undef,
        next => undef,
    };
}

sub insert_node ($node) {
    delete_key($node->{key});
    $node->{next} = $start;
    if ($node->{next}) {
        $node->{next}{prev} = $node;
    }
    $start = $node;
    $end //= $node;
    $finder{$node->{key}} = $node;

    if (keys %finder > $capacity) {
        delete_node($end);
    }
}

sub delete_key ($key) {
    if (my $node = $finder{$key}) {
        return delete_node($node);
    }

    return undef;
}

sub delete_node ($node) {
    my ($prev, $next) = @$node{qw/ prev next /};
    $start = $next if defined $start and $start == $node;
    $end = $prev if defined $end and $end == $node;
    $prev->{next} = $next if defined $prev;
    $next->{prev} = $prev if defined $next;
    delete $finder{$node->{key}};

    return $node;
}