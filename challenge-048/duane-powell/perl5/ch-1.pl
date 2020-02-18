#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/ Task #1

my $SWORDSMAN = shift || 50; 

# These constants are not needed but it could be fun to add more weapons and rules
use constant {
        NO_SWORD => 0,
        SWORD    => 1,
};

# Swordsman constructor
sub new_swordsman {
	my $name  = shift;
	my $armed = shift;
	return {name => $name, armed => $armed, next => undef};
}

# Create n swordsman and arrange them in a cirle 
my $first_swordsman = new_swordsman(1, SWORD);
my $swordsman = $first_swordsman;
foreach my $s (2 .. $SWORDSMAN) {
	my $next = new_swordsman($s, NO_SWORD);
	# expand the circle and continue
	$swordsman->{next} = $next; 
	$swordsman = $next;         
}
$swordsman->{next} = $first_swordsman; 

# Execute man to your right and pass the sword until there is 
# only one man standing, i.e. the next swordsman is yourself
$swordsman = $first_swordsman;
until ($swordsman->{next} == $swordsman) {
	my $condemned = $swordsman->{next}; # ID the condemned
	my $next = $condemned->{next};      # ID who gets the SWORD next
	$condemned = undef;                 # execute the condemned
	$swordsman->{armed} = NO_SWORD;     # pass the sword
	$next->{armed} = SWORD;
	# contract the circle and continue
	$swordsman->{next} = $next;       
	$swordsman = $next;	         
}

say "$SWORDSMAN Swordsman arranged in a circle, the last man standing is Swordsman " . $swordsman->{name};

__END__

./ch-1.pl
50 Swordsman arranged in a circle, the last man standing is Swordsman 37

./ch-1.pl 3
3 Swordsman arranged in a circle, the last man standing is Swordsman 3

