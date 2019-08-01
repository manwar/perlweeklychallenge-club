# # Task #1
#
# Write a script to display months from the year 1900 to 2019 where you
# find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

for my $year (1900..2019) {
    for my $month (1, 3, 5, 7, 8, 10, 12) {
	my $cal = `cal -h -m $month $year`;
	# print months with 31 days that start on a Friday.
	print $cal if $cal =~ /^(\V+\v+){2}\h+1\h+2\h*\v/;
    }
}
