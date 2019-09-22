#!/usr/bin/perl
use Modern::Perl;

# Generate a longest sequence of the following English Pokemon names where each name starts with the last letter of previous name.

my @pokemon = qw(
audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk 
darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur 
jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp 
magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 
porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon
simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord 
wartortle whismur wingull yamask
);

my @test = qw(
bad good dog cat fish boy girl tree house lost 
);

# The plan is to build a tree of all possible name combinations. 
# While the tree is building note the longest 3 paths:
#
# Code below finds over 5 million unique combinations of names in @pokemon array
# It takes 2 min 30 secs to run on my Intel Next Unit of Computing with 16GB RAM,
# needs to be optimized.

my %args    = @ARGV;
my $verbose = $args{verbose} || 0;
my $test    = $args{test}    || 0;

@pokemon = @test if ($test);
@pokemon = (sort @pokemon);

my $tree = PokemonNameTree->new($verbose,@pokemon);
$tree->grow(); 
$tree->announce_top3();
exit;

package PokemonNameTree;
sub new {
        my ($class,$verbose,@name) = @_;
        my $self = {
		__root => {
			name => "__root_node_of_pokemon_name_tree__",
			kids => [],
		},
		verbose => $verbose,
		top3    => ['','',''],
		top3_n  => [0,0,0],
        };
        bless $self, $class;

	# Init root node of tree with all names nodes
	foreach (sort (@name)) {
		push( @{ $self->{__root}{kids} }, $self->new_node($_) );
	}
	return $self;
}

sub new_node {
	my ($self,$name) = @_;
	return {
		name => $name,
		kids => [],
	};
}
sub grow {
	my $self = shift;
	# Begin tree growth at ply 1, where we initialized our name nodes
	my @parents = qw();
	foreach my $node ( @{ $self->{__root}{kids} } ) {
		$self->_grow(1,$node,@parents,$node->{name});
	}
}
sub _grow {
	my ($self,$ply,$node,@parents) = @_;

	if ($self->{verbose}) {
		# say every sequence found
		print "/$_" foreach (@parents);
		say " $ply";
	} else {
		# otherwise build array 3 longest sequences
		if ($ply >= @{$self->{top3_n}}[0]) {
			unshift(@{$self->{top3}}, '/'.join('/',@parents));
			unshift(@{$self->{top3_n}}, $ply);
			pop(@{$self->{top3}});
			pop(@{$self->{top3_n}});
		}
	}
	# Get every name node we were initialized with (i.e. all the names in @pokemon)
	GROW: foreach ( @{ $self->{__root}{kids} } ) {
		my $n = $_->{name};
		foreach my $p (@parents) {
			# Don't grow tree by reusing any parent name, otherwise we get circular (infinite long) names
			# For example,  /exeggcute/exeggcute/exeggcute ... /exeggcute 
			next GROW if ($n eq $p);
		}
		my $last_char = substr($node->{name},-1,1);
		my $next_char = substr($n,            0,1);
		last if ($next_char gt $last_char); # No point in looking further since @pokemon is sorted alphabetically
		if ($last_char eq $next_char) {
			# Name match, create new node in tree, insert into kids of parent node
			my $new_node = $self->new_node($n);
			push( @{ $node->{kids} }, $new_node);
			# Recurse depth first, note how $n is natrually added to @parents in the param pass
			$self->_grow($ply+1,$new_node,@parents,$n); 
		}
	}
}
sub announce_top3 {
	my $self = shift;
	unless ($self->{verbose}) {
		foreach (0..2) {
			say @{$self->{top3}}[$_], " ", @{$self->{top3_n}}[$_];
		}
	}
}

1;

__END__

./time ch-1.pl verbose 1 > out.txt <==== verbose mode, lists all 5 million unique sequences
real    2m24.354s
user    2m22.564s
sys     0m1.052s

grep 23 out.txt | wc -l
1248 <================================== 1,248 name paths tied for first place with 23 names in the sequence

./ch-1.pl <============================= Quiet mode, just return top 3 longest sequences. Last 3 paths found get reported.
/machamp/pinsir/rufflet/trapinch/heatmor/remoraid/darmanitan/nosepass/starly/yamask/kricketune/exeggcute/emboar/relicanth/haxorus/simisear/registeel/landorus/seaking/girafarig/gabite/emolga/audino 23
/machamp/pinsir/rufflet/trapinch/heatmor/remoraid/darmanitan/nosepass/starly/yamask/kricketune/exeggcute/emboar/registeel/landorus/simisear/relicanth/haxorus/seaking/girafarig/gabite/emolga/audino 23
/machamp/pinsir/rufflet/trapinch/heatmor/remoraid/darmanitan/nosepass/starly/yamask/kricketune/emboar/relicanth/haxorus/simisear/registeel/landorus/seaking/girafarig/gabite/exeggcute/emolga/audino 23

./ch-1.pl test 1 verbose 1 <============ Lightweight test case
/bad 1
/bad/dog 2
/bad/dog/girl 3
/bad/dog/girl/lost 4
/bad/dog/girl/lost/tree 5
/bad/dog/good 3
/boy 1
/cat 1
/cat/tree 2
/dog 1
/dog/girl 2
/dog/girl/lost 3
/dog/girl/lost/tree 4
/dog/good 2
/fish 1
/fish/house 2
/girl 1
/girl/lost 2
/girl/lost/tree 3
/good 1
/good/dog 2
/good/dog/girl 3
/good/dog/girl/lost 4
/good/dog/girl/lost/tree 5
/house 1
/lost 1
/lost/tree 2
/tree 1

