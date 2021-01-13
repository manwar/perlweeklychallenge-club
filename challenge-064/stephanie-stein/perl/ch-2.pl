use strict;
use warnings;
use List::MoreUtils qw(uniq);



sub in_string{
	
	
	
#taking user input
#this is based on https://www.codesdope.com/perl-input/
	print "First, enter the sentence or string you'd like to search in:\n ";
	my $S=<>;  #if you'd rather enter the string in the code, put it here
	chomp($S);
	print "Next, type each word you want to look for. Hit Enter to type the next word. \nWhen you've finished entering all of the words, hit CTRL-Z for Windows or CTRL-D for Linux\n";
	my @w_list=<>; #if you'd rather enter the list in the code, put it here
	chomp(@w_list);


#this syntax is based on https://www.learn-perl.org/en/Subroutines
	my $W=\@w_list; 
	my @answer=();	
	my %place;
	
	my @W=@$W;
	my @UW= uniq@W;  
	
	foreach(@UW){
	$_=lc($_); #trying to make it so it's not case-sensiive
	
	#storing the order
	$place{$_}=index($S,$_) if(lc($S)=~/$_/); 
	#print "this is place",%place;
}

if ((keys %place)<1){
	return 0;
}else{
	 #soring substrings based on their place in the string
	 #based on https://perlmaven.com/how-to-sort-a-hash-in-perl
	# foreach my $subs(sort { $place{$a} <=> $place{$b} } keys %place){
	 
foreach my $name (sort {$place{$a} <=>  
       $place{$b}} keys %place)  {
       	push (@answer,$name);
       	
       	 
}
return @answer; 
}


}

my @show_ans=in_string();
print "this is the answer: ", @show_ans, "\n"
