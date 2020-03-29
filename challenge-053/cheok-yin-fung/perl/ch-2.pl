#!/usr/bin/perl
# Perl Weekly Challenge #053 Task 2
use Tree; 
use Switch;
use strict;
use warnings;

my $N = $ARGV[0];  # Usage: perl ch-2 N

my $vowel = Tree->new( "" );

sub produce_child {
    my $t = $_[0];
    if ($t->size == 1) { switch($t->value) {
        case ("a") {$t->add_child(Tree->new("e")); $t->add_child(Tree->new("i"));}
        case ("e") {$t->add_child(Tree->new("i"));}
        case ("i") {$t->add_child(Tree->new("a")); $t->add_child(Tree->new("e"));
                    $t->add_child(Tree->new("o")); $t->add_child(Tree->new("u"));}
        case ("o") {$t->add_child(Tree->new("a")); $t->add_child(Tree->new("u"));}
        case ("u") {$t->add_child(Tree->new("e")); $t->add_child(Tree->new("o"));}
    }
    }
}

my $tree_a = Tree->new("a");
my $tree_e = Tree->new("e");
my $tree_i = Tree->new("i");
my $tree_o = Tree->new("o");
my $tree_u = Tree->new("u");

$vowel->add_child( $tree_a );
$vowel->add_child( $tree_e );
$vowel->add_child( $tree_i );
$vowel->add_child( $tree_o );
$vowel->add_child( $tree_u );

#######################################

# grow : traverse and force the tree nodes produce child(ren)
sub grow {
    my ($t, $d) = ($_[0], $_[1]);
    produce_child($t);
    my @t_baby = $t->children;
    foreach (@t_baby) {
        grow($_, $d) if $_->depth < $d;
    }
}

#print out the required strings
sub traverse_and_named {
    my ($t, $d, $str) = ($_[0], $_[1], $_[2]);
    print $str."\n" if length($str)==$d;
    my @t_baby = $t->children;
    foreach (@t_baby) {
        traverse_and_named($_, $d, $str.$_->value) if $_->depth<=$d;
    }
}

#######################################

grow($vowel, 5);

traverse_and_named($vowel, $N, "");

