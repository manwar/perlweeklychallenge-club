#perl 5.22.1 
# Challenge 045 Task 2
# Write a script that dumps its own source code. For example, say,
# the script name is ch-2.pl then the following command should
# return nothing.
# $ perl ch-2.pl | diff - ch-2.pl

open (my $fh, '<:encoding(UTF-8)', $0 ) ;
print while(<$fh>);
