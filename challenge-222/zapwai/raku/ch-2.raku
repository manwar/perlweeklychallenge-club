use Getopt::Std;
my @ints = (2, 7, 4, 1, 8, 1);
my %opts = getopts('bsriph', @*ARGS);
CATCH { when X::Getopt::Std { .message.note; usage } };
if %opts.keys.elems > 1 or %opts.keys.elems == 0 {
    usage();
    die("Please choose one option.");
}
my $method = %opts.keys[0];
say "\tUsing method $method";
if $method eq 'h' {
    usage();
    exit;
}
say " Input: " ~ @ints;
if @ints > 2 {
    repeat {
	my $n1 = select($method, @ints);
	my $x = @ints.splice($n1,1);
	my $n2 = select($method, @ints);
	my $y = @ints.splice($n2,1);
	@ints.push($y[0] - $x[0]) unless $y[0] - $x[0] == 0;
	say "$x, $y -> " ~ @ints;
    } while (@ints > 2);
}
@ints.elems == 2 ?? (my $o = @ints[1] - @ints[0]) !! ($o = @ints[0]);
say "Output: $o";
sub select(Str $method, @ints) {
    given ($method) {
	when 'r' {return (0 .. @ints.elems-1).rand.round;}
	when 's' {
	    my $min_index = @ints.pairs.min(*.value).key;
	    return $min_index;
	}	    
	when 'b' {
	    my $max_index = @ints.pairs.max(*.value).key;
	    return $max_index;
	}
	when 'i' {return 0;}
	when 'p' {return @ints.elems - 1}
    }
}
sub usage() {
    say "Please choose a selection method: (b)iggest, (s)mallest, (r)andom, sh(i)ft, or (p)op.";
    say "Perl Weekly Challenge #222";
}
