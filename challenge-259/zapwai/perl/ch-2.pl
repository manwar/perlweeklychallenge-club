use v5.38;
my $line1 = '{%  id   field1="value1"    field2="value2"  field3=42 %}';
my $line2 = '{%  youtube title="Title \"quoted\" done" foo="bar" baz=31 %}';
my $line3 = '{%  youtube title="Title with escaped backslash \\" %}';
my $line4 = '{% id field="val1" field2="val2" %}';
my $line5 = '{% test filed1="value1" df=42 %}';
my $line6 = 'LINES';
my $line7 = 'More Lines';
my $line8 = '{% endtest %}';

my %fv;
my %text;
my $current_id;

my @lines = ($line1, $line2, $line3, $line4, $line5, $line6, $line7, $line8);
proc($_) foreach (@lines);
say $fv{$current_id} unless ($text{$current_id});

sub proc ($line) {
    if ($line =~ /^{%/) {
	$line =~ /(\w+)/;
	if ($1 =~ /^end/) {
	    say $fv{$current_id};
	    say $text{$current_id};
	} else {
	    say $fv{$current_id} if ($current_id);
	    $current_id = $1;
	    process_line($line);
	}
    } else {
	$text{$current_id} = "Text => " unless ($text{$current_id});
	$text{$current_id} .= "$line\n";
    }
}

sub process_line ($line) {
    $line =~ /(\w+)/;
    my $name = $1;

    $line = substr $line, (index $line, $name) + length $name;
    $line = substr $line, 0, -3;
    $line =~ s/\s+/ /g;

    my ($r, $s) = get_fv($line);
    my @fields = @$r;
    my @values = @$s;
    my $output = "Name => $name\n";
    $output .= "Fields => {\n";
    $output .=  "\t".$fields[$_]." => ".$values[$_]."\n" for (0 .. $#fields);
    $output .=  "}\n";
    $fv{$current_id} = $output;
}

sub get_fv ($l) {
    my @piece = split "=", $l;
    my @field = ($piece[0]);
    my @value;
    for my $i (1 .. $#piece - 1) {
	$piece[$i] =~ /(\w+)$/;
	push @field, $1;
	my $strip = substr $piece[$i], 0, -length($1);
	push @value, $strip;
    }
    push @value, $piece[$#piece];
    s/\s+//g for (@field);
    return (\@field, \@value);
}
