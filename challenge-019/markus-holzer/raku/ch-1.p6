.say for ( 1900..2020 X 1, 3, 5, 7, 8, 10, 12 ).grep({ 
	Date.new( |$_, 1 ).day-of-week == 5 
});