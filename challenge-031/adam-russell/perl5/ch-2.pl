##
# Create a script to demonstrate creating dynamic variable 
# name, assign a value to the variable and finally print 
# the variable. The variable name would be passed as command 
# line argument.
##
$variable_name =$ARGV[0];
$variable = $variable_name;
$$variable = $ARGV[1];  
print "The value of \$$variable_name is $$variable.\n";  
