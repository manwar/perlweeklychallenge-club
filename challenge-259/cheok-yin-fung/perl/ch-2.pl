# The Weekly Challenge 259
# Task 2 Line Parser
use v5.30.0;
use warnings;

sub lp {
    my $structure;
    my $input = $_[0];

    die "wrong format\n" unless $input =~ /^\{\%\s*(.+)\s*%\}$/;
    my $prse = $1;
    $prse =~ /^\s*(\w+)/;
    my $id = $1;
    my @fields;
    while ($prse =~ m/(?<=\s{1,255})\w+\=(.+?)(?=\s{1,255}\w+\=(.+?)|$)/g ) {
        my $fv_pair = $&;
        push @fields, $fv_pair;
    }
    $structure->{name} = $id;
    for my $fv_pair (@fields) {
        die "wrong format\n" unless $fv_pair =~ /^(\w+)=(.+)$/;
        my $field = $1;
        my $value = $2;
        if ($value =~ /^\"(.+)\"\s*$/) {
            $value = parse_perlstr($1);
        }
        $structure->{fields}->{$field} = $value;
    }
    sub parse_perlstr {
        my $line = $_[0];
        # BEGIN: source from Text::ParseWords;
        $line =~ s/^
                        (?:
                            # double quoted string
                            (")                             # $quote
                           ((?>[^\\"]*(?:\\.[^\\"]*)*))"   # $quoted
                        |   # --OR--
                            # singe quoted string
                            (')                             # $quote
                            ((?>[^\\']*(?:\\.[^\\']*)*))'   # $quoted
                        |   # --OR--
                            # unquoted string
                            (                               # $unquoted
                                (?:\\.|[^\\"'])*?
                            )
                        )//xs;            # extended layout
        # END: source from Text::ParseWords
        return $line;
    }

    return $structure;
}

use Test2::V0;
ok (lp q/{%id    field1="value1"    field2="value2" field3=42 %}/, 
    {
        name   => "id",
        fields => {
            field1 => "value1",
            field2 => "value2",
            field3 => 42
        },
    }
    );
ok (lp q/{%  youtube title="Title \"quoted\" done" %}/,
    {
        name   => "youtube",
        fields => {
            title => "Title \"quoted\" done"
        },
    }
);
ok (lp q/{%  youtube title="Title with escaped backslash \\" %}/,
    {
        name   => "youtube",
        fields => {
            title => "Title with escaped backslash \""
        },
    }
);

done_testing();
