#!/usr/bin/perl

use strict;
use warnings;
use Text::VimColor;

if($ARGV[0] and $ARGV[0] eq "help") {
	print "\n$0 - PWC #45 Task #2: Source Dumper\n";
	print "\n";
	print "    This source code dumper dumps its own source code, but also the \n";
	print "    source code of other files with syntax highlighting using Text::VimColor.\n";
	print "\n";
	print "    ./ch-2.pl [<command|file>] [<full>]\n";
	print "       command - help|high\n";
	print "       file    - filename of file to dump.\n";
	print "       full    - dump full html page not only source code.\n";
	print "\n";
	print "  Examples:\n";
	print "    ./ch-2.pl           - Dumps own source code\n";
	print "    ./ch-2.pl help      - This Usage information\n";
	print "    ./ch-2.pl high      - Syntax high for ch-2.pl\n";
	print "    ./ch-2.pl ch-1.pl   - Syntax high for ch-1.pl\n";
	print "    ./ch-2.pl high 1    - Syntax high for ch-2.pl in full html page.\n";
	print "    ./ch-2.pl ch-1.pl 1 - Syntax high for ch-1.pl in full html page.\n";
	print "    ./ch-2.pl | diff - ch-2.pl - PWC 45 Task #2\n";
	print "\n";
}
elsif($ARGV[0] and $ARGV[0] eq "high") { 
	syntax_high($0,$ARGV[1]); 
}
elsif($ARGV[0]) { 
	syntax_high(@ARGV); 
}
else { 
	open(IN,$0) or die "Cant open $0\n";
	while(<IN>) { print; }
	close IN;
}

sub syntax_high {
	my ($file,$full) = @_;
	
	# Option $full is for Debug Reasons, a Full HTML Page is created.
	if(! $full) { $full = 0; }
	
	my $syntax = Text::VimColor->new(
		file => $file,
		filetype => 'perl',
		html_full_page => $full,
		# Extra vim options do not work: I want to have the line number
		# in the source code and also to try different colorschemes for vim.
		# extra_vim_options => [ "+set number", "+color darkblue" ],
	);
	
	my $html = $syntax->html;
	
	my ($html1,$html2); # Full Page needs to be splitted, to get line numbers on each line.
	if($full) {
		my $tmp;
		($html1,$tmp)  = split("<pre>",$html);
		($html,$html2) = split("</pre>",$tmp);
	}
	
	my @lnes = split("\n",$html); # Every line for Line Number
	
	if($full) { print $html1, "<pre>\n"; } # Print first part of full page
	my $cnt = 1;               # Count line number
	foreach my $line (@lnes) { # Every line for Line Number
		printf("%3d %s\n",$cnt,$line); # Print Line with Line Number
		$cnt++;
	}
	if($full) { print "</pre>\n", $html2; } # Print last part of full page
}

