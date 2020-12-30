#!/home/ben/software/install/bin/perl

use warnings;
use strict;

use JSON::Parse 'json_file_to_perl';
use Getopt::Long;

my $ok = GetOptions (
    debug => \my $debug,

);
for my $file (@ARGV) {
    if (! -f $file) {
	warn "$file not found";
	next;
    }
    my $tree = json_file_to_perl ($file);
    my $total = add ($tree, 0);
    print "$file: $total\n";
}
exit;

sub add
{
    my ($tree, $depth) = @_;
    my $total;
    my $n = $tree->{n};
    for (qw!l r!) {
	my $v = $tree->{$_};
	if (! defined $tree->{$_}) {
	    die "No $_ in tree at depth $depth";
	}
	if (ref $v) {
	    $total += add ($v, $depth + 1);
	}
	else {
	    $total += $v;
	}
	$total += $n;
	if ($debug) {
	    print "\t" x $depth;
	    print "$_: $total\n";
	}
    }
    return $total;
}
