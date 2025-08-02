#!/usr/bin/perl

=begin comment

## Task 2: B After A

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str`.

Write a script to return `true` if there is at least one `b`, and no `a` appears
after the first `b`.

**Example 1**

```
Input: $str = "aabb"
Output: true
```

**Example 2**

```
Input: $str = "abab"
Output: false
```

**Example 3**

```
Input: $str = "aaa"
Output: false
```

**Example 4**

```
Input: $str = "bbb"
Output: true
```

[2]: https://manwar.org/

=end comment
=cut

use strict;
use warnings;
use autodie;
use Exporter;

our $VERSION = '1.0.0';

our @EXPORT_OK = qw(b_after_a);

sub b_after_a {
    my $str = shift // q{};

    # Regular expression to match the string
    ## no critic (RegularExpressions::RequireDotMatchAnything)
    my $re = qr{
        ^      # Start of the string
        [^b]*  # Match any character except 'b' zero or more times
        b+     # Match 'b' one or more times
        [^a]*  # Match any character except 'a' zero or more times
        $      # End of the string
    }mx;
    ## use critic
    # Test the string against the regular expression and return the result
    if ( $str =~ $re ) {
        return 1;
    }
    return 0;
}

1;

__END__

=head1 NAME

Task2: B After A

=head1 VERSION

This documentation refers to Task2 version 1.0.0

=head1 EXPORTS

The function L</b_after_a> is exported by default.

=head1 USAGE

    use strict;
    use warnings;
    use feature qw(say);
    use Task2 qw(b_after_a);

    my $str1 = 'aabb';
    my $str2 = 'abab';

    say b_after_a($str1); # Output: 1
    say b_after_a($str2); # Output: 0

=head1 DESCRIPTION

Given a string, C<$str>, the function C<b_after_a> returns true if there is at
least one 'b', and no 'a' appears after the first 'b'.

=head1 REQUIRED ARGUMENTS

=over 4

=item C<$str>

A string.

=back

=head1 OPTIONS

None.

=head1 DIAGNOSTICS

None.

=head1 EXIT STATUS

None.

=head1 CONFIGURATION

None.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

None reported.

=head1 AUTHOR

Ian Goodnight

=head1 LICENSE AND COPYRIGHT

This software is released under the terms of theGNU General Public License
Version 3.

=cut
