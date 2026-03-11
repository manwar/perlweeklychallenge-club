#!/usr/bin/env perl

use Modern::Perl;

chomp(my $text = <>);
my $data = parse($text);
dump_data($data);

sub parse {
    my(@text) = @_;
    my $data = {};

    my @tokens = scan($text);

    # start marker
    expect(\@tokens, "{", "start marker");
    expect(\@tokens, "%", "start marker");

    # name
    $data->{name} = expect(\@tokens, "NAME", "name");

    # fields
    for (;;) {
        # possibly end marker
        last if @tokens && $tokens[0][0] eq "%";

        # field name
        my $field_name = expect(\@tokens, "NAME", "field name");

        # =
        expect(\@tokens, "=", "'='");

        # value
        @tokens && ($tokens[0][0] =~ /STR|NUM/) or die "field value expected, got ", $tokens[0][1], "\n";
        my $field_value = $tokens[0][1];
        shift @tokens;

        $data->{fields}{$field_name} = $field_value;
    }

    expect(\@tokens, "%", "start marker");
    expect(\@tokens, "}", "start marker");

    @tokens == 0 or die "extra input, got ", $tokens[0], "\n";

    return $data;
}

sub scan {
    my($text) = @_;

    my @tokens;
    for ($text) {
        while ($_ ne '') {
            s/^\s+// and next;
            s/^(\d+)// and do { push @tokens, [NUM => $1]; next; };
            s/^(\w+)// and do { push @tokens, [NAME => $1]; next; };
            s/^("((\\.|[^"])*)")// and do { push @tokens, [STR => unescape($2)]; next; };
            s/^(.)// and do { push @tokens, [$1, $1]; next; };
            die; # not reached
        }
    }

    return @tokens;
}

sub expect {
    my($tokens, $id, $text) = @_;

    @$tokens or die "$text expected, got eof\n";
    $tokens->[0][0] eq $id or die "$text expected, got ".$tokens->[0][1]."\n";
    my $value = $tokens->[0][1];
    shift @$tokens;
    return $value;
}

sub dump_data {
    my($data) = @_;
    say "{";
    say "  name => \"", $data->{name}, "\",";
    say "  fields => {";
    for my $key (sort keys %{$data->{fields}}) {
        say "    ", $key, " => ", escape($data->{fields}{$key}), ",";
    }
    say "  },";
    say "}";
}

sub unescape {
    my($str) = @_;
    $str =~ s/\\(.)/$1/g;
    return $str;
}

sub escape {
    my($str) = @_;
    return $str if $str =~ /^\d+$/;
    $str =~ s/([\\"])/\\$1/g;
    return '"'.$str.'"';
}
