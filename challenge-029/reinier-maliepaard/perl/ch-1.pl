#!/usr/bin/perl
use strict;
use warnings;

The regex `(.*?)\{([^{}]*)\}(.*)` is used to split a string into three
logical parts: everything before a brace, the content inside braces,
and everything after the closing brace.
1. The first part `(.*?)` is a lazy match, meaning it captures as few
   characters as possible until it reaches the first `{`, ensuring we don’t
   accidentally consume too much of the string.
   The `\{` then matches a literal opening brace.
2. Inside the braces, `([^{}]*)` captures any sequence of characters except
   `{` or `}`, which safely extracts the inner content without allowing
   nested braces.
   The `\}` matches the closing brace literally.
3. Finally, `(.*)` captures the rest of the string after the brace block.

Together, this structure cleanly decomposes inputs like
`Perl{Weekly, Monthly, Yearly}Challenge` into prefix (`Perl`), inside
content (`Weekly, Monthly, Yearly`), and suffix (`Challenge`), making
it useful for simple brace expansion tasks.

Here is a complete minimal Perl implementation using this idea:

sub brace_expand_text {
    my ($str) = @_;

    # no validation on input...but should be done here...

    # Match: prefix {inside} suffix
    if ($str =~ /(.*?)\{([^{}]*)\}(.*)/) {
        my ($prefix, $inside, $suffix) = ($1, $2, $3);

        # Split comma-separated options inside braces
        my @parts = split /,/, $inside;

        my @results;
        for my $part (@parts) {
            $part =~ s/^\s+|\s+$//g; # optional: trim spaces
            push @results, $prefix . $part . $suffix . "\n";
        }

        return @results;
    }

}

# Alternative

sub brace_expand_text_alt {
    my ($str) = @_;

    # no validation on input...but should be done here...

    my ($prefix, $inside, $suffix) = split / /, $str;
    my @inside_parts = split /,/, $inside;

    my @results;
    for my $inside (@inside_parts) {
        $inside =~ s/^\s+|\s+$//g; # optional: trim spaces
        $inside =~ s/{|}//g; # remove braces
        push @results, $prefix . " " . $inside . " " . $suffix . "\n";
    }

    return @results;
}

my $str = "Perl {Daily,Weekly,Monthly,Yearly} Challenge";
print brace_expand_text($str);

# Output:
# Perl Daily Challenge
# Perl Weekly Challenge
# Perl Monthly Challenge
# Perl Yearly Challenge
