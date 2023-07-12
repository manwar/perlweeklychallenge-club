#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-10
use utf8;     # Week 225 task 1 - Max words
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

binmode(STDOUT, ':utf8');

max_words('Perl and Raku belong to the same family.',
          'I love Perl.',
          'The Perl and Raku Conference.');
		  
max_words('The Weekly Challenge.',
          'Python is the most popular guest language.',
          'Team PWC has over 300 members.');
		  
max_words('Our solo sponsor Pete Sergeant has been a great support to keep us motivated.',
		  'We are lucky that he agreed to continue the journey with us in the year 2023.',
		  'I would like to personally thank Pete and his entire team for their generosity.',
		  'It would be great if we could add few more to sponsor the prize money so that we could go back and 
		   declare weekly champions as we have done in the past.',
		  'I hope and wish this will become possible in 2023.', 
		  'The amount doesn’t have to be huge.', 
		  'However, it would be nice to show off bunch of supporters.',
		  'If an organisation comes forward and supports us then that would be the ultimate achievement.');
		  
sub max_words {
	
	my ($max, $sentence, $words, $rubric, $j);
	
	# loop over sentences
	$max = 0;
	while ($sentence = $_[$j++])  {
		$rubric .= qq['$sentence',\n                 ];
		
		# in scalar context s||| returns the number of substitutions made
		$words = ($sentence =~ s|[^\s]+||g);
		$max = $words if $words > $max;
	}
	
	# show the results
	$rubric =~ s|,\n +$||;
	say qq[\nInput:  \@list = ($rubric)];
	say qq[Output: $max];
}

