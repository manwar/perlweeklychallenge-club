#!/usr/bin/env perl6

my $teststring = 'All he could think about was how it would all end. There was still a bit of uncertainty in the equation, but the basics were there for anyone to see. No matter how much he tried to see the positive, it wasn\'t anywhere to be seen. The end was coming and it wasn\'t going to be pretty.';

my @teststring = &break_into_sentences($teststring);
	
for (@teststring) -> $teststring {
		print &sort_each_sentence($teststring),'. ';
}
print "\n";

	
sub break_into_sentences($teststring) {
		split(/<[\.\?\!]>\s+/, $teststring);
}

sub sort_each_sentence($teststring) {
		sort {$^a.uc cmp $^b.uc},(split /\s+/, $teststring);
}




