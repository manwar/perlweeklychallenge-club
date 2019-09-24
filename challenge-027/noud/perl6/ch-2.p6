# Write a script that allows you to capture/display historical data. It could
# be an object or a scalar. For example
#
#   my $x = 10; $x = 20; $x -= 5;
#
# After the above operations, it should list $x historical value in order.

# I hope I don't get banned from the Perl Weekly Challenge club for using EVAL
# in this problem. ;)
use MONKEY-SEE-NO-EVAL;

my @variables = ();
my $pattern = /my\s*\$(\w+)/;

my $exec_prog = "";
for 'exm.p6'.IO.lines -> $line {
    my @line_var = ($line ~~ $pattern).values;
    if (@line_var.elems > 0) {
        @variables = (|(@line_var), |(@variables));
    }
    $exec_prog = "$exec_prog $line";
    # After every line update %var_hash_ with the current variable values.
    for @variables -> $x {
        $exec_prog = "$exec_prog \%var_hash_\.push: ($x => \$$x)\;";
    }
}

my %var_hash_;
EVAL $exec_prog;  # https://xkcd.com/292/
for %var_hash_.kv -> $var, @hist {
    print("$var = (");
    my $last = @hist[0];
    print("$last");
    for @hist[1..*] -> $next {
        if ($last != $next) {
            print(", $next");
            $last = $next;
        }
    }
    print(")\n");
}
