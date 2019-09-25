# Write a script that allows you to capture/display historical data. It could
# be an object or a scalar. For example
#
#   my $x = 10; $x = 20; $x -= 5;
#
# After the above operations, it should list $x historical value in order.

# The idea behind this solution is to first extract all defined variables
# from the original script. After that we create a hash %var_hash_ that
# updates the current values of each of the defined variables after each
# semicolon. The new script is executed using the dangerous EVAL method.
#
# Usage:
#   perl6 ch-2.p6 filename-of-script.p6

# I hope I don't get banned from the Perl Weekly Challenge club for using EVAL
# in this problem. ;)
use MONKEY-SEE-NO-EVAL;

sub MAIN(Str $filename) {
    # Collect all variables in program.
    my @variables = ();
    for $filename.IO.slurp.split(";") -> $line {
        my @line_var = ($line ~~ /my\s*\$(\w+)/).values;
        if (@line_var.elems > 0) {
            @variables = (|(@line_var), |(@variables));
        }
    }

    my $exec_prog = "";
    for $filename.IO.slurp.split(";") -> $line {
        $exec_prog = "$exec_prog $line\;";
        # After every line update %var_hash_ with the current variable values.
        for @variables -> $x {
            $exec_prog = "$exec_prog
                if (not DYNAMIC::<\$$x> === Nil) \{
                    \%var_hash_\.push: ($x => DYNAMIC::<\$$x>)\; \}\;";
        }
    }

    my %var_hash_;
    EVAL $exec_prog;  # https://xkcd.com/292/

    say "Variables history:";
    for %var_hash_.kv -> $var, @hist {
        my @hist_ = @hist.grep({ not $_.^name === "Any" });
        if (@hist_.elems > 0) {
            print("$var = (");
            my $last = @hist_[0];
            print("$last");
            for @hist_[1..*] -> $next {
                if ($last != $next) {
                    print(", $next");
                    $last = $next;
                }
            }
            print(")\n");
        }
    }
}
