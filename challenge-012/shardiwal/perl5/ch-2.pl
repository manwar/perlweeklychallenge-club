#!/usr/bin/perl

use warnings;
use strict;
use feature qw(say);
use Data::Dumper;

# Write a script that finds the common directory path, given a collection
# of paths and directory separator. For example, if the following paths
# are supplied.

my @path_list = qw(
	/a/b/c/d
	/a/b/cd
	/a/b/cc
	/a/b/c/d/e
);

say find_common_path( \@path_list, "/" );

sub find_common_path {
	my ( $path_list, $separator ) = @_;
	my $path_mapping = common_path_mapping( $path_list, $separator );
	my $common_path;
	my $uses = 0;
	while ( my ($path, $used) = each %$path_mapping ) {
		my $used_no_of_times = scalar @$used;
		if ( $used_no_of_times > $uses ){
			$uses = $used_no_of_times;
			$common_path = $path;
		}
	}
	return $separator . $common_path;
}

sub common_path_mapping {
	my ( $path_list, $separator ) = @_;
	my %paths;
	map {
		my $line = $_;
		my $dirs = _get_directories_in_path( $line, $separator );
		my $i = 1;
		foreach my $dir ( @$dirs ) {
			next unless $dirs->[$i];
			my $path_in_chunk = join( $separator, @$dirs[0..$i] );
			push( @{ $paths{$path_in_chunk} }, $line);
			$i++;
		}
	} @$path_list;
	return \%paths;
}

sub _get_directories_in_path {
	my ( $path, $separator ) = @_;
	my @dirs = split /$separator/, $path;
	shift @dirs;
	return \@dirs;
}