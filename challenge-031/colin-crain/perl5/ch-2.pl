#! /opt/local/bin/perl
#
#       dynamic_variable.pl
#
#       PWC31 - 2
#
#       Task #2
#           Create a script to demonstrate creating dynamic variable name, assign a
#           value to the variable and finally print the variable. The variable name
#           would be passed as command line argument.
#
#       notes: first of all, much like a YouTube video for assembling a firearm
#           out of common items found around the home, just don't do this. Just
#           because you can, doesn't mean one actually should. I can't think of
#           any good reason not to use a hash for this. As a hash key, the
#           outside data is by definition kept in it's own secure namespace, and
#           if one is _that_ worried about the speed of an additional hash lookup
#           one should probably be looking for a different method or even a
#           different language. Perl hashes are very fast. In fact, perl variable
#           namespaces are implemented as a hash. Saying
#               my %namespace;
#               $namespace{$input} = "whatever";
#           keeps everything nicely sandboxed. So build a data structure out of
#           hashes. There is no need to use the perl variable namespace. Seriously.
#
#       method: that said, of course you can do this. But you can't use
#           'strict'. Which is another reason why you shouldn't do this and
#           use a hash instead.
#
#           One thing we can do is at least try make it bit safer to take user
#           input and make it a variable. We can install some sanity, like
#           restricting the input to only things that can serve as a valid per
#           variable, for starters. At least the regex was fun.
#
#
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



# use warnings;
# use strict;
use feature ":5.26";

## ## ## ## ## MAIN

## get our proposed new variable
my $varname = validate( shift @ARGV )  ;
if (not defined $varname) { die "input '$varname' is not a valid perl varible name."};

## go ahead and make it a variable and show it does what is asked
${"$varname"} = "Don't Do This";
say "after setting: \$" . "$varname is ${$varname} ";

# UNCOMMENT TO SEE HEY! THERE IT IS
#
# foreach $key (keys %main::) {
#   say $key;
# }



## ## ## ## ## SUBS

sub validate {
## makes sure input fits criteria for a valid perl variable name
## returns undef on failure
    my $name = shift;
    return undef unless ( ($name =~ /^[a-zA-Z_]+[\w\d]*$/) && (scalar( split //, $name ) < 252) );
    return $name;
}


