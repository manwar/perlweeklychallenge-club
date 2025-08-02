use 5.010;
use warnings;
use strict;
use autodie;
no warnings 'uninitialized';

my ($O, $C) = (qr/^\s*\{\%\s*/, qr/\s*\%\}\s*$/); # Tokens gobble whitespace
my @text;   # Text lines for multi-line ids
my %id;     # Result hash of ids and their associated data structures
my $id;     # Current ID

for (<DATA>) {
    chomp;

    if ($id) {
        if (/${O}end$id${C}/) {
            $id{$id}{text} = @text > 1 ? [ @text ] : $text[0];
            @text = ();
            $id = undef;
        } else {
            push @text, $_
        }
    } 
    elsif (/${O}(?<id>\w+)\s+(?<fields>.+?)${C}/) {
        die "No end token found for <$id>" if $id and @text;
        $id = $+{id};
        die "Duplicate id <$id>" if exists $id{$id};
        $id{$id} = { name => $id, fields => parse_fields($+{fields}) };
    }
    else {
        die "Invalid line: <$_>";
    }
}

die "No end token found for <$id>" if $id and @text;

pretty(\%id); # Pretty print the result

exit;


# Parse name=value fields, and return a hash of kv pairs
# This is the harder part, due to escape sequences
sub parse_fields {
    # State machine, going char by char
    my %fields;         # Result hash of kv pairs
    my $state = 'out';  # Outside of kv pair
    my $backslash = 0;  # Substate for whether we're backslashed
    my $name;           # Field name
    my $value;          # Field value
    my $expected_closing_quote; # If defined, value must end with this

    for (split //, "$_[0] ") { # Extra space simplifies parsing

        # Backslash handling
        $backslash = 0 if $backslash == 2;
        if ($backslash) {
            $_ = eval "\$_"; # safe
            $backslash = 2;
        } elsif (/\\/) {
            $backslash = 1;
            next;
        }

        # Ready for next key/value pair
        if ($state eq 'out') {
            next if /\s/;
            $expected_closing_quote = undef;
            die "Invalid character `$_' in ID" unless /\w/;
            $state = 'field_name';
            $name = $_;
        }
        # Expecting a comma and optional whitespace
        elsif ($state eq 'comma') {
            next if /\s/;
            $state = 'out' if $_ eq ',';
        }

        # Field name states
        elsif ($state eq 'field_name') {
            if (/\s/) {
                $state = 'equal';
                next;
            }
            if (/=/) {
                $state = 'value_start';
                next;
            }
            die "Invalid character in ID" unless /\w/;
            $name .= $_;
        }

        # Expecting equal sign and optional whitespace
        elsif ($state eq 'equal') {
            next if /\s/;
            $state = 'value_start';
        }

        # Handle the value, with optional quotes and escape sequences
        elsif ($state eq 'value_start') {
            next if /\s/;
            if (/['"]/ and not $backslash) {
                $expected_closing_quote = $_;
                $state = 'value';
                $value = '';
                next;
            }
            $value = $_;
            $state = 'value';
        }


        elsif ($state eq 'value') {
            if (($_ eq $expected_closing_quote && !$backslash)
                    or (/[ ,]/ and not defined $expected_closing_quote))
            {
                $state = $_ eq ',' ? 'out' : 'comma';
                $fields{$name} = $value;
                next;
            }
            $value .= $_;
        }
    }

    \%fields;
}

sub val {
    local $_ = shift;
    defined ? "`$_'" : "(undef)";
}

# Pretty printer. Prefer Data::Printer, or fall back to Data::Dumper (core)
sub pretty {
    my ($ref) = @_;

    my $res;
    $res = eval {
        require Data::Printer;
        Data::Printer->import;
        1;
    };

    if ($res) {
        p($ref)
    }
    else {
        use Data::Dumper qw< Dumper >;
        print Dumper $ref
    }

}

__DATA__
{% id1 field1="value1", field2="value2" %}
    Line of text.
    {% id1.5 desc="This line should NOT be parsed!" %}
    Another line of text.
{% endid1 %}
{% id2 label=plain, in='middle', number=43 %}
    Single line text.
{% endid2 %}
{% id3 embedded="That's the \"plan\"", single='Single "quotes" are OK' %}
