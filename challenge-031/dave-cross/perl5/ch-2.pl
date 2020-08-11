#!/usr/bin/perl

use strict;
use warnings;

# Because this is *literally* the point of this code
no strict 'refs';

use File::Basename;

my $varname = shift
  or die "Usage: ", basename($0), " variable-name\n";

# Set that variable
$$varname = int rand 256;

# Print the variable
print "The variable is called $varname and it has the value $$varname\n";
