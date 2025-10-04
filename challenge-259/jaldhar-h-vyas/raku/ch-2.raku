#!/usr/bin/raku

grammar LineParser {
    rule TOP {
        | <single-line>
        | <multi-line>
    }

    token single-line {
        ^ '{%' \s+ <identifier> <field>* \s* '%}' $
    }

    token multi-line {
        '{%' \s+ <identifier> <field>* \s* '%}' \n
        <text>
        '{%' \s+ 'end' <end-id=.identifier> \s* '%}' \n?
    }

    token identifier { \w+ }

    token ws { \h* }

    token field {
        \s+ <name=.identifier> \s* '=' \s* <value>
    }

    proto token value {*}

    token value:sym<number> { \d+ }

    token value:sym<string> {
        '"' <content> '"'
    }

    token content {
        [
            | <-[\"\\]>+
            | '\\"'
            | '\\\\'
        ]*
    }

    token text {
        <-[{]>*
    }
}

class LineActions {
    method TOP($/) {
        make $<single-line> ?? $<single-line>.made !! $<multi-line>.made;
    }

    method single-line($/) {
        make {
            name => ~$<identifier>,
            fields => $<field>.map({
                ~$_<name> => $_<value>.made
            }).Hash
        }
    }

    method multi-line($/) {
        die "Closing tag 'end{$<identifier>}' does not match opening tag '{$<end-id>}'"
            unless $<identifier> eq $<end-id>;

        make {
            name => ~$<identifier>,
            fields => $<field>.map({
                ~$_<name> => $_<value>.made
            }).Hash,
            text => ~$<text>
        }
    }

    method value:sym<number>($/) { make +$/ }
    method value:sym<string>($/) {
        make ~$<content>
            .subst(/'\\"'/, '"', :g)
            .subst(/'\\\\'/, '\\', :g)
    }
}

sub prettyprint(%data) {
    my $output = "\{\n    name => %data<name>,\n    fields => \{\n        ";

    $output ~= %data<fields>
                .keys
                .map({ "$_ => %data<fields>{$_}" })
                .join(",\n        ");


    $output ~= "\n    \},\n";
    if %data<text> {
        $output ~= "    text => %data<text>";
    }
    $output ~= "}\n";

    return $output;
}

sub MAIN($input) {
    my $actions = LineActions.new;
    my $match = LineParser.parse($input, :$actions);
    say $match ?? prettyprint($match.made) !! 'Failed to parse line';
}