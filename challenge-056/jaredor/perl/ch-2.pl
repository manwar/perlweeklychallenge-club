#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use List::Util qw(all sum);
use Scalar::Util qw(looks_like_number);

# PWC 056, Task #2

# The binary tree will be input as the argument array to the script.
# Any argument perl does not think is a number will be considered a null
# element, i.e., not a node in the tree.

my @N = map { looks_like_number $_ ? 0 + $_ : undef } @ARGV;

my @node;

my ( $i, $prevtree ) = ( 0, 1 );

$node[$i] = [ undef, undef, $N[$i] ];

for $i ( 1 .. $#N ) {

    $prevtree = 2 * $prevtree - 1 if $i > 2 * ( $prevtree + 1 );
    my $parentidx = $prevtree - 1 + int( ( $i - $prevtree ) / 2 );

    if ( defined $N[$i] ) {
        die "Not a binary tree. The parent node to element $i does not exist."
          if not defined $N[$parentidx];
        $node[$i] = [ undef, undef, $N[$i] ];
        $node[$parentidx]->[ ( $i + 1 ) % 2 ] = $node[$i];
    }
}
my $btree = $node[0];
undef @node;

# Okay we have a binary tree. Find the sums.
# We could have done that earlier, when importing the tree,
# but that would have been cheating ;-)

my %sums;

sub walk_btree {
    my ( $btree, $path ) = @_;
    my $path_next = [ @$path, $btree->[2] ];
    walk_btree( $btree->[0], $path_next ) if defined $btree->[0];
    walk_btree( $btree->[1], $path_next ) if defined $btree->[1];
    push @{ $sums{ sum @$path_next } }, $path_next
      if not( defined $btree->[0] or defined $btree->[1] );
}

walk_btree( $btree, [] );

# Now entertain the user with pre-computed answers.

my ( $sep, $user_input ) = ( ' → ', '' );

my @seek;
while ( $user_input !~ /\A \s* [Qq] /xms ) {
    print "\nEnter sum to seek. (<ENTER> returns all sums, [Qq]uit): ";
    $user_input = <STDIN>;
    chomp $user_input;
    if ( $user_input =~ /\A \s* \Z/xms ) {
        @seek = sort { $b <=> $a } keys %sums;
    }
    elsif ( looks_like_number $user_input ) {
        @seek = ( 0 + $user_input );
    }
    while (@seek) {
        my $sum = pop @seek;
        if ( exists $sums{$sum} ) {
            my ( $noun, $verb ) =
              @{ $sums{$sum} } > 1 ? ( 's', '' ) : ( '', 's' );
            my $leader = "Path$noun that sum$verb to $sum:";
            my $llen   = length $leader;
            print "\n";
            printf( "%${llen}s %s\n", $leader, join( $sep, @$_ ) ), $leader = ''
              for @{ $sums{$sum} };
        }
        else {
            print "\nNo path sums to $sum.\n";
        }
    }
}
