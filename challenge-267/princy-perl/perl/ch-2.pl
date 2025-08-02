# Given string and array of character widths

my $str = "abcdefghijklmnopqrstuvwxyz";
my @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
# Initialize variables
my $line_count = 1;
my $last_line_width = 0;

# Loop through each character in the string
for my $i (0 .. length($str) - 1) {
  # Get the width of the current character
  my $char_width = $widths[ord(substr($str, $i, 1)) - ord('a')];

  # If adding the width of the current character to the last line width exceeds 100,
  # increment the line count and reset the last line width
  if ($last_line_width + $char_width > 100) {
    $line_count++;
    $last_line_width = $char_width;
  } else {
    # Otherwise, add the width of the current character to the last line width
    $last_line_width += $char_width;
  }
}

# Print the number of lines and the width of the last line
print "Number of lines: $line_count\n";
print "Width of last line: $last_line_width\n";