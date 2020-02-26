#!/usr/bin/env perl

=pod

There are 50 people standing in a circle in position 1 to 50. The person standing at position 1 has a sword. He kills the next person i.e. standing at position 2 and pass on the sword to the immediate next i.e. person standing at position 3. Now the person at position 3 does the same and it goes on until only one survives.

This is the script to find out the survivor.
Problem from :: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/

=cut

## ** publish_list sub starts here
sub publish_list {

	my $cnt = shift;
	my $prefix = shift;
	my $list_ref = shift;

	if (scalar(@$list_ref) != 0){
		die "List reference passed, doesn't point to empty list.\nPlease ensure the list reference passed, points to empty list.\n";
	}

	my $name;
	foreach  my $ind (0..$cnt-1){
		$name = $prefix . ++$ind;
		push (@$list_ref, $name); 
	} 

return @$list_ref;
}
## ** publish_list sub ends here

## ** purge_members sub starts here
## returns reference to the newly created list
sub purge_members {

	## purge_sequence : 0 means purge even entries, 1 means purge odd entries
	my $purge_sequence = shift;
	my $ref_people_list = shift;
	my @new_people_list=();
	my $people_cnt = scalar(@$ref_people_list);
	if ($people_cnt < 2){
		return $ref_people_list;
	}
	##
	## print "List arrived in purge_members has $people_cnt members which are @$ref_people_list\n";
	for (my $ind=0; $ind <= $people_cnt-1; $ind++) {
		#print "loop: $ind adding $$ref_people_list[$ind] to the list\n";
		push(@new_people_list, $$ref_people_list[$ind]);
		if ($ind == $people_cnt-1){
			#print "This is the last person with sword. removing the first entry\n";
			shift(@new_people_list);
		}
		else{
			$ind++;
		}
	}
	return \@new_people_list;
}
## ** purge_members sub ends here

## ** complete_purge_cycle sub starts here
sub complete_purge_cycle {
	my $ref_people_list = shift;
	for (my $ind=0;scalar(@$ref_people_list)>0; $ind++){
		$ref_people_list = purge_members(1,$ref_people_list);
		if(scalar(@$ref_people_list) == 1){
			print "Survivor is @$ref_people_list\n ";
			exit;
		}
	}
}


print "Enter the number of people in the line\n";
sub main {
	my $people_cnt = <STDIN>;
	my @people;
	my $ref_list;
	
	## Publish the list with names of people
	publish_list($people_cnt, "Man", \@people);
	print "Published list: @people\n";
	complete_purge_cycle(\@people);
}

main();
