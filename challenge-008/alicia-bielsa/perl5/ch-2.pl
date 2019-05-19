#Write a function, ‘center’, whose argument is a list of strings, 
#which will be lines of text. 
#The function should insert spaces at the beginning of the lines of text 
#so that if they were printed, the text would be centered, and return the modified lines.
use strict;
use warnings;


#my @aLinesCentered = center("This", "is", "a test of the", "center function");

# we generate some strings with a character of our choice to draw a diamond
my @aStrings =();
my $character = '*';
my $count = 2;
while  ($count <= 20){
	push (@aStrings, $character x $count);
	$count += 2;
}
while  ($count >= 2){
	 push (@aStrings, $character x $count);
	 $count -= 2;
}



my @aLinesCentered = center(@aStrings);


foreach my $line (@aLinesCentered){
	print "$line\n";
}


sub center {
	my @aLinesToCenter = @_;

	my @aLinesCentered = ();
	
	my $maxLength =  length((sort {length($b) <=> length ($a)} @aLinesToCenter)[0]);	
	
	foreach my $lineToCenter (@aLinesToCenter){
		push (@aLinesCentered, (' ' x ( abs ( length($lineToCenter)/2 - $maxLength /2 ))).$lineToCenter);
	}
	
	return @aLinesCentered;
}