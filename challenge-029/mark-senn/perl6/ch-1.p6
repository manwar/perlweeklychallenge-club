#
# Perl Weekly Challenge - 029
# Task #1
#
# Mark Senn, http://engineering.purdue.edu/~mark
# October 13, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-029#task-1
#     Write a script to demonstrate brace expansion.  For example,
#     script would take command line argument
#         Perl {Daily,Weekly,Monthly,Yearly} Challenge
#     and should expand it and print like below:
#         Perl Daily Challenge
#         Perl Weekly Challenge
#         Perl Monthly Challenge
#         Perl Yearly Challenge
#
# ASIDE: HELP WANTED WITH PERL 6 CUSTOM SYNTAX
#     This works:
#         my @x = (<a b>, <c d>);
#         @x.map({.join(':').say});
#     I'd like for this to work so I don't need to type as much:
#         @x.{.join(':').say};
#     If you know how to do it please send me the answer at the email
#     address in
#         https://engineering.purdue.edu/~mark/
#     Thank you.
#
# ASIDE: BASH SHELL HISTORY EXPANSION
#     If you use ! followed by a command number to rerun that command
#     or a string to rerun tha last command that started with that
#     string and would like to change that to ',' because that is easier
#     to type keep reading this ASIDE.
#       I use ',' instead of '!' for my Bash shell history expansion
#     character because I use shell history expansion often and ','
#     is easier to type than '!'.  Because of that I'd need to type
#         Perl {Daily\,Weekly\,Monthly\,Yearly} Challenge
#     on the command line to do the challenge.  (I have things set
#     up so that is the default input if no arguements are on the
#     command line for this program, too.)
#       From
#     http://web.mit.edu/gnu/doc/html/features_4.html
#         histchars
#             Up to three characters which control history expansion,
#             quick substitution, and tokenization (see section History
#             Interaction). The first character is the
#             history-expansion-char, that is, the character which
#             signifies the start of a history expansion, normally
#             `!'. The second character is the character which signifies
#             `quick substitution' when seen as the first character on a
#             line, normally `^'. The optional third character is the
#             character which signifies the remainder of the line is a
#             comment, when found as the first character of a word,
#             usually `#'. The history comment character causes history
#             substitution to be skipped for the remaining words on the
#             line. It does not necessarily cause the shell parser to
#             treat the rest of the line as a comment.
#     To change my Bash shell history characters from '!^#' to ',^#'
#     I put
#         histchars=',^#'
#     in my .bashrc file.  Other shells use histchars also---check
#     the documentation for your shell if you are interested.
#

# Run using Perl v6.d;
use v6.d;

sub MAIN(*@arg);
{
    # If no command line arguments are given use these defaults.
    # I couldn't figure out how to do this on the "sub MAIN" line
    # without getting a "Cannot put default on slurpy parameter @arg"
    # error.
    (@arg.elems)
        or  @arg = 'Perl', '{Daily,Weekly,Monthly,Yearly}', 'Challenge';

    # Convert the @arg array to a @term array.  The next paragraph
    # explains this in detail.
    my @term = ();
    for @arg  {
        # If $_ starts with '{' and ends with '}' 
        # set $0 to what's between the braces.
        if  /^^ \{ (.*?) \} $$/  {
            # Split $0 on commas and push the that array
            # on @term as a single element.
            push @term, $0.split(',');
        }  else  {
            # Push the scalar $_ on @term.
            push @term, $_;
        }
    }

    # At this point, if no command line arguments are set
    #     $term[0]  is  'Perl'
    #     $term[1]  is  ('Daily', 'Weekly', 'Monthly', 'Yearly')
    #     $term[2]  is  'Challenge'
    # $term[0] X $term[1] X @term[2] would give
    #     ('Perl', 'Daily',   'Challenge')
    #     ('Perl', 'Weekly',  'Challenge')
    #     ('Perl', 'Monthly', 'Challenge')
    #     ('Perl', 'Yearly',  'Challenge')
    # If the program is called with a different number of
    # arguments there will be a different number of @term
    # elements set.  The reduction operator '[X]' puts a 'X'
    # between each element of @term.  After the '([X] @term).'
    # any of the following can be used to do what we want:
    #     # Convert * to type Str and print it.
    #     map(*.Str.say);
    #     # Convert * to type Stringy and print it.
    #     map(*.Stringy.say);
    #     # Convert * to string and print it.
    #     map((~*).say);
    #     # Put a space between each element of $_ and print it.
    #     map({join(' ',$_).say});
    #     # Put a space between each element of $_ and print it.
    #     map({$_.join(' ').say});
    #     # Put a space between each element of $_ and print it.
    #     # If a method is going to operate on $_ you don't need to
    #     # specify '$_'.
    #     map({.join(' ').say});
    # I like the following line the best.
    ([X] @term).map({.join(' ').say});
}
