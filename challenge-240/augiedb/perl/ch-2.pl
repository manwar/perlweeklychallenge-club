#!/usr/bin/perl 
use strict;
use warnings;

##
##
## The real solution to this challenge is
## one line in the build_array() subroutine.
##
## Skip head to line 32 for that.
##

main( (0, 2, 1, 5, 3, 4) );
main( (5, 0, 1, 2, 3, 4) );

sub main {

	my @int = @_;

	print "Input: ";
	pretty_print_array( @int );
	print "Output: ";
	pretty_print_array( build_array( @int ) );
	print "\n";

}

sub build_array {

	my @int = @_;

	return map{ $int[$_] } @int;

}

sub pretty_print_array {

        my @array = @_;
        my $length = scalar @array;
        my $count = 1;

        print "(";

        foreach my $value(@array) {
                print $value;
                print ", " if $count < $length;
                $count++;
        }

        print ")\n";

        return;
}



