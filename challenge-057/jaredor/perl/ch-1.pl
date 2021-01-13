#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(max);
use Scalar::Util qw(looks_like_number);

# PWC 057, Task #1 : Invert Tree

# Run on the command line. The binary tree will be input as the argument array
# to the script. Any argument perl does not think is a number will be considered
# a null element, i.e., not a node in the tree.
#
# Examples
#
# ./ch-1.pl 1 2 3
# ./ch-1.pl $(seq 7)
# ./ch-1.pl $(seq 15)
# ./ch-1.pl $(seq 31)
#
# If you want to get wild and crazy. Use a non-full binary tree:
# (You might want to widen your terminal window.)
#
# ./ch-1.pl $(seq 22) X X $(seq 25 45) X X X X $(seq 50 56)

sub create_btree {

    my ( @N, @node ) = map { looks_like_number $_ ? 0 + $_ : undef } @_;

    my ( $i, $btlevel ) = ( 0, 1 );

    $node[$i] = [ undef, undef, $N[$i] ];    # Root node.

    die "The root node cannot be NULL." unless defined $N[$i];

    for $i ( 1 .. $#N ) {

        $btlevel = 2 * $btlevel - 1 if $i > 2 * ( $btlevel + 1 );
        my $parentidx = $btlevel - 1 + int( ( $i - $btlevel ) / 2 );

        if ( defined $N[$i] ) {
            die
              "Not a binary tree. The parent node to element $i does not exist."
              if not defined $N[$parentidx];
            $node[$i] = [ undef, undef, $N[$i] ];
            $node[$parentidx]->[ ( $i + 1 ) % 2 ] = $node[$i];
        }
    }
    return $node[0];
}

sub df_walk {    # Depth first binary tree walk.
    my ( $btree, $action, $level, ) = @_;
    $level += 1;
    $action->( $btree, $level );
    df_walk( $_, $action, $level ) for grep { defined $_ } @{$btree}[ 0, 1 ];
}

sub bf_walk {    # Breadth first binary tree walk.
    my ( $btree, $action ) = @_;
    my @roster = ($btree);
    while (@roster) {
        my $node = shift @roster;
        $action->($node);
        push @roster, $_ for grep { defined $_ } @{$node}[ 0, 1 ];
    }
}

sub get_levels {
    my ( $btree, ) = @_;
    my %levels;
    my $get_level = sub {
        my ( $btree, $level ) = @_;
        push @{ $levels{$level} },
          [ $btree->[2], defined( $btree->[0] ), defined( $btree->[1] ) ];
    };
    df_walk( $btree, $get_level, 0 );
    return %levels;
}

sub pretty_print {    # Ironically, ugly code.
    my ( $btree, ) = @_;
    my %levels = get_levels($btree);
    for my $level ( sort { $b <=> $a } keys %levels ) {
        my $prev = delete $levels{ $level + 1 };
        my $idx  = -1;
        for my $ninfo ( @{ $levels{$level} } ) {
            my ( $data, $Lidx, $Ridx ) = @$ninfo;
            my ( @Lstrs, @Rstrs, @Sstrs );
            my ( $Llen, $Rlen, $Slen ) = ( 0, 0, 0 );
            my $spacer = ' ' x ( length $data );
            if ($Lidx) {
                $data  = "/$data";
                $Lidx  = ++$idx;
                @Lstrs = map { "$_ " } split( "\n", $prev->[$Lidx][0] );
                $Llen  = max map { length $_ } @Lstrs;
            }
            if ($Ridx) {
                $data  = "$data\\";
                $Ridx  = ++$idx;
                @Rstrs = map { " $_" } split( "\n", $prev->[$Ridx][0] );
                $Rlen  = max map { length $_ } @Rstrs;
            }
            push @Lstrs, ' ' x $Llen while @Lstrs < @Rstrs;
            push @Rstrs, ' ' x $Rlen while @Rstrs < @Lstrs;
            @Sstrs = map { $Lstrs[$_] . $spacer . $Rstrs[$_] } 0 .. $#Lstrs;
            $Slen = @Sstrs ? max map { length $_ } @Sstrs : 0;
            my ( $Nval, $Nstr ) = ( $data, ' ' x $Slen );
            substr( $Nstr, ( $Slen - length $Nval ) / 2, length $Nval ) = $Nval;
            $ninfo->[0] = join( "\n", $Nstr, @Sstrs );
        }
    }
    my @pp_nodes = map { s([/\\])( )xmsg;  $_ } split( "\n", $levels{1}[0][0] );
    my @pp_lines = map { s([^/\\])( )xmsg; $_ } split( "\n", $levels{1}[0][0] );
    pop @pp_lines;
    my @pp =
      map { s([/\\])( )xmsg; s(\S)(@)xmsg; $_ } split( "\n", $levels{1}[0][0] );
    for my $i ( 1 .. $#pp ) {
        my ( $pos, $idx ) = ( 0, 0 );
        while ( $idx > -1 ) {
            $idx = index $pp[$i], '@', $pos;
            substr( $pp_lines[ $i - 1 ], $idx, 1 ) = substr( $pp[$i], $idx, 1 )
              if substr( $pp_lines[ $i - 1 ], $idx, 1 ) eq ' ';
            $pos = $idx + 1;
        }
        $pp_lines[ $i - 1 ] =~ s{@ (\s*) /}{'@'.('-' x length($1)).'/'}xmseg;
        $pp_lines[ $i - 1 ] =~ s{@-}{@.}xmsg;
        $pp_lines[ $i - 1 ] =~ s{\\ (\s*) @}{'\\'.('-' x length($1)).'@'}xmseg;
        $pp_lines[ $i - 1 ] =~ s{-@}{.@}xmsg;
        $pp_lines[ $i - 1 ] =~ tr/@/ /;
    }
    @pp = map { ( $pp_nodes[$_], $pp_lines[$_] ) } 0 .. $#pp_lines;
    push @pp, $pp_nodes[-1];
    print "\n", join( "\n", @pp ), "\n\n";
}

my $print_node = sub { print "$_[0]->[2]\n"; };
my $flip_branches = sub { @{ $_[0] }[ 0, 1 ] = @{ $_[0] }[ 1, 0 ]; };

die "The binary tree must be input as arguments to this script." unless @ARGV;

my $btree = create_btree @ARGV;

print "\n\nInput binary tree:\n";

#bf_walk( $btree, $print_node );
pretty_print $btree;

bf_walk( $btree, $flip_branches );

print "\n\nOutput flipped binary tree:\n";

#bf_walk( $btree, $print_node );
pretty_print $btree;
