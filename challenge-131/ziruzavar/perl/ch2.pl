use strict;
use warnings;

sub find{
	my $delimeters = shift;
	my $search = shift;
	my %opening = ('('=>1, '{'=>1, '['=>1, '<'=>1);
	my %closing = (')'=>1, '}'=>1, ']'=>1, '>'=>1);
	my $open = "";
	my $close = "";
	my %delim = map {$_ => 1}
		    split '', $delimeters;
	my @search_arr = split('', $search);
	foreach my $el (@search_arr){
		if (exists($delim{$el})){
			if (exists($opening{$el})){
				$open .= $el;
			}elsif (exists($closing{$el})){	
				$close .= $el;
			}else{
				$open .= $el;
				$close .= $el;
			}
		}
	}
	return "$open \n $close \n";

}

my $input_delim = '""[]()';
my $input_search = '"I like (parens) and the Apple ][+" they said.';
print find($input_delim, $input_search);

my $input_delim2 = '**//<>';
my $input_search2 = '/* This is a comment (in some languages) */ <could be a tag>';
print find($input_delim2, $input_search2);
