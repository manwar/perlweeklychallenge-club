#!/usr/bin/env perl6
#
sub MAIN(:$order=1,*@values){
	@values=(5, 9, 2, 8, 1, 6 ) if !@values;
	@values= map( { [-] @values[$_,$_-1]}, @values.keys[1..*-1]) for ^$order ;
	put @values;
}
