#!/usr/bin/perl
# The Weekly Challenge 113
# Task 2 Recreate Binary Tree
use strict;
use warnings;
use Data::Dumper; # use for print_pretty_tree

die <<FOO
Incorrect input format.
Usage: ch-2.pl [binary tree in array format, \'x\' for null nodes]
for example, \$ ch-2.pl 2 3 5 x 7

    2 
   / \\
  3   5
   \\
    7
FOO
    unless consistency(@ARGV);

my @tree = map { $_ eq 'x' ? undef : $_ } @ARGV;


sub recreate  {
    my $sum = 0;
    my @t = @_;
    for (@t) {
        $sum += $_ if defined($_);
    }

    for (@t) {
        $_ = $sum - $_ if defined($_);
    }
    return \@t;
}

print " ---- Output(s) ---- \n";
print_tree(recreate @tree);
print_pretty_tree(recreate @tree);


sub consistency {
    my @t = @_;
    return 0 if !defined($t[0]) || ($t[0] !~ /^\d+$/ && $t[0] ne 'x');
    for my $ind (1..$#t) { 
        if ($t[$ind] =~ /^\d+$/) {
            if ($t[($ind-1)/2] eq 'x') {
                return 0;
            }
        } 
        elsif ($t[$ind] ne 'x') {
            return 0;
        }
    }
    return 1;
}

sub print_tree {
    print "in Array Format:\n";
    for my $v (@{$_[0]}) {
        if (defined($v)) {
            print $v, " ";
        } 
        else {
            print 'x', " ";
        }
    }
    print "\n";
}


sub print_pretty_tree {
    my @tr = @{$_[0]};
    my $hash_tree = tree_build( \@tr, 0);

    $Data::Dumper::Terse = 1; 
    $Data::Dumper::Indent = 2;
    $Data::Dumper::Sortkeys = 1;
    print "\n"; 
    print "in Hash Format:\n";
    print Dumper $hash_tree; 
}

sub tree_build {        # use for print_pretty_tree
    my @t = @{$_[0]};
    my $ind = $_[1]; 
    my %leaf = ( "v" => $t[$ind] );
    $leaf{"l"} = tree_build(\@t, $ind*2+1) if defined($t[$ind*2+1]);
    $leaf{"r"} = tree_build(\@t, $ind*2+2) if defined($t[$ind*2+2]);
    return \%leaf;
}


# ================== examples of hash trees  =========================

my $testtree = {
    "v" => 1, 
    "l" => { 
        "v" => 2,
        "l" => {
                "v" => "4",
                "r" => { "v" => 7}
            },
        },
    "r" => {
        "v" => 3,
        "l" => {"v" => 5},
        "r" => {"v" => 6},
        }
  };

my $smalltree = { "v" => 1, "l" => {"v" =>2, "l"=> {"v"=> 17}}, "r" => {
        "v"=>3,
        "l"=>{"v"=>4},
        "r"=>{"v"=>5}
    } };

my $chain = {"v"=>1, "l"=>{"v"=>3, "l"=>{"v"=>5, "l"=>{"v"=>7}}}};

# =====================================================

sub hash_tree_to_flat_array {
    my $h_tree = $_[0];       # a hash
    my @t = ($$h_tree{"v"});

    my $tree_walker_id = 0;
    my $tree_walker;
    my $p;    
    my @vector_p = ($h_tree);

    # Breath-First Build of the array format from hash format
    while (scalar @vector_p != 0) {
        $tree_walker = shift @vector_p;

        if (defined($$tree_walker{"l"})) {
            push @vector_p, $$tree_walker{"l"} ;
            push @t, $$tree_walker{"l"}->{"v"};
        }
        else {
            push @t, undef;
        }

        if (defined($$tree_walker{"r"})) {
            push @vector_p, $$tree_walker{"r"};
            push @t, $$tree_walker{"r"}->{"v"};
        }
        else {
            push @t, undef;
        }
    }
    return \@t;
}

print "\n" x 5;
print "hash tree demo\n";
print "---- Input ----\n";
print_tree(hash_tree_to_flat_array $smalltree);
print_pretty_tree(hash_tree_to_flat_array $smalltree);
print "---- Output ----\n";
print_tree(recreate @{ hash_tree_to_flat_array $smalltree });
print_pretty_tree(recreate @{ hash_tree_to_flat_array $smalltree } );
