##
# Write a script to accept a string from command line and split it on change of character.
##
my $string = @*ARGS[0];
my @letters = split(/""/, $string);
my $letter;
@letters.shift();
my $letter_previous = @letters.shift();
repeat {
    $letter = @letters.shift();
    print $letter_previous if ($letter eq $letter_previous);
    print "$letter_previous\n" if ($letter ne $letter_previous);
    $letter_previous = $letter;
}while (@letters);
print $letter_previous if ($letter eq $letter_previous);
print "$letter_previous\n" if ($letter ne $letter_previous);
