# [Perl Weekly Challenge - 131]

Pretty straightforward challenges this week.  I haven't been coding in Perl for
all that long, and I still have a lot of woodshedding to do to be able to take
advantage of all the perlisms available to me.  Challenges like the array 
transformations in Task 1 and the substring matches in Task 2 are pleasant
opportunities to practice writing declarative, readable perl.

## Task 1 > Consecutive Arrays

You are given a sorted list of unique positive integers.

Write a script to return lists of arrays where the arrays are consecutive
integers.

**Example 1:**

```perl
my @input = (1, 2, 3, 6, 7, 8, 9);

my @output = ([1, 2, 3], [6, 7, 8, 9]);

```

**Example 2:**

```perl
my @input = (11, 12, 14, 17, 18, 19);

my @output = ([2], [4], [6], [8]);

```

**Example 3:**

```perl
my @input = (2, 4, 6, 8);

my @output = ([2], [4], [6], [8]);

```

**Example 4:**

```perl
my @input = (1, 2, 3, 4, 5);

my @output = ([1, 2, 3, 4, 5]);

```

### Solution

Our subroutine, `reduce_to_consecutive`, loops through our input array, checking
to see if each element equals the previous element plus one.  If our
element passes the test, it is pushed to the last list in our `@reduced` array.
Otherwise, we initialize a new anonymous list and push that list to our array
instead.

```perl
# Task 1 Solution
sub reduce_to_consecutive {
  my @input = @{ +shift };
  my @reduced;

  foreach my $element (@input) {

    # if `@reduced` is empty, push the first element as part of an anonymous
    # list to start our comparisons
    if ( not( scalar @reduced ) ) {
      push @reduced, [$element];
      next;
    }

    # grab a copy of the last element checked to test if consecutive
    my $last_element = $reduced[-1]->[-1];

    # increment $last_element and compare to current element
    if ( ++$last_element eq $element ) {

      # if matched, push the current element to the last set
      push @{ $reduced[-1] }, $element;
      next;
    }

    # Else, push it as part of a new set.
    push @reduced, [$element];
  }
  return \@reduced;
}

```

Hopefully, this solution is as easy to ready as it was fun to write.

### `ch-1.pl`

Running `./ch-1.pl` tests our solution against the sample test cases found at
`../test_cases/ch-1/`.  Optionally, `ch-1.pl` can be run with a path argument
pointing to a test file or directory of test files (i.e., `./ch-1.pl ./test`).
Our test files must be comprised of lines alternating between inputs and 
expected results formatted as shown in the examples above (i.e., `(1, 2, 4)` and
`([1, 2], 4)`).  Lines beginning with `#` and blank lines will be ignored.
Lines are parsed with a helper subroutine, `eval_input`.

```perl
sub eval_input {
  my $input = shift;

  # If no inner sets, return the split string as an array reference
  if ( not( $input =~ /\[/ ) ) {

    # Strip outer parenthesis
    $input =~ s/[(]|[)]//g;

    # split by comma and optional spaces
    return [ map { int } split /\s*,\s*/, $input ];
  }

  # Else, return a reference to an array of sets
  return [
    map {
      [ map { int } split /\s*,\s*/ ]
      } $input =~ m{
      \[       # opening bracket
      ([^\]]*) # inner set
      \]       # closing bracket
    }gx
  ];
}

```

Why write a subroutine to evaluate our input instead of just using `eval`?  Why
write tests assertions and deep comparisons instead of using a module that has 
those functions built in?  Because it's fun to write perl, and none of this is
production code anyway.  I've always found it frustrating that, when perusing 
[stackoverflow] or similar sites, looking for a cool way to solve a trivial
problem,  all the comments/answers are variations of "don't do it, there's
already a module for that."  I do think it's best practice to use a tested and
hardened library or module in production code, sure, but sometimes I just want
to have fun writing some code!  There is no better way to get into the guts of a
language than by making all the mistakes the old pros have already solved if you
have the time and inclination for it IMHO.

#### Output

Running `ch-1.pl` with no arguments (assuming the existence of our sample
test directory) outputs:

```
../test_cases/ch-1/case-1.txt
=============================

Input: (1, 2, 3, 6, 7, 8, 9)
Expected: ([1, 2, 3], [6, 7, 8, 9])
Result: ([1, 2, 3], [6, 7, 8, 9])
Passed ⚐


../test_cases/ch-1/case-2.txt
=============================

Input: (11, 12, 14, 17, 18, 19)
Expected: ([11, 12], [14], [17, 18, 19])
Result: ([11, 12], [14], [17, 18, 19])
Passed ⚐


../test_cases/ch-1/case-3.txt
=============================

Input: (2, 4, 6, 8)
Expected: ([2], [4], [6], [8])
Result: ([2], [4], [6], [8])
Passed ⚐


../test_cases/ch-1/case-4.txt
=============================

Input: (1, 2, 3, 4, 5)
Expected: ([1, 2, 3, 4, 5])
Result: ([1, 2, 3, 4, 5])
Passed ⚐


../test_cases/ch-1/case-5.txt
=============================

Input: (-1, 0, 1, 11, 101, 102, 103)
Expected: ([-1, 0, 1], [11], [101, 102, 103])
Result: ([-1, 0, 1], [11], [101, 102, 103])
Passed ⚐

Input: (1, 2, 3, 7, 9)
Expected: ([1, 2, 3], [7], [9])
Result: ([1, 2, 3], [7], [9])
Passed ⚐
 
```

Our output shows all our tests as passing, indicating that either our solution
solution is correct or our testing methods are flawed.

## Task 2 > Find Pairs

You are given a string of delimiter pairs and a string to search.

Write a script to return two strings, the first with any characters matching the
"opening character" set, the second with any matching the "closing character"
set.

**Example 1:**

```
Input:

Delimiter pairs: ""[]()
Search String: "I like (parens) and the Apple ][+" they said.

Output:

  "(["
  "])"

```

**Example 2:**

```
Input:

Delimiter pairs: **//<>
Search String: /* This is a comment (in some languages) * / <could be a tag>

Output:

/**/<
/**/>

```

### Solution

From the examples provided, it looks like we are testing for _any_ instance of
our opening or closing delimiter, regardless of whether or not they are
fulfilling the function of opening or closing.  Specifically, matching tags like
`*`, `'`, or `"` will show up in both lines of output.  This makes for a simpler
solution, as we will not have to differentiate based on the actual function our
delimiters are serving (opening or closing).  We will partition our opening and
closing delimiters assuming that they are listed in pairs as shown in the
example input (i.e.: `[]{}""`), and then test our search string
character-by-character looking for matches.

```perl
# Task 2 Solution
sub find_delims {
  my ($delim_string, $search_string) = @_;
  my @delims = split //, $delim_string;
  my @open_set;
  my @close_set;
  # Partition delimiters into openings and closings
  foreach my $idx (0 .. $#delims) {
    my $char = $delims[$idx];
    if ($idx % 2) {
      push @close_set, $char;
    } else {
      push @open_set, $char;
    }
  }

  my @search = split //, $search_string;
  my @found_open;
  my @found_close;

  foreach my $char (@search) {
    if (grep $_ eq $char, @open_set) {
      push @found_open, $char;
    }
    if (grep $_ eq $char, @close_set) {
      push @found_close, $char;
    }
  }

  return (\@found_open, \@found_close);
}

```

### `ch-2.pl`

Generally speaking, when approaching these challenges, I have been consistently
writing a solution, creating a directory of test cases, and writing my
submission framed as a series of tests run against the solution.  So, in the
solution for the first task, running the file `ch-1.pl` automatically looks for
that directory and test cases unless it is run with a path argument pointing to
another, local test.  That choice was mainly just an excuse to write more perl
each week.  It also allowed me to practice a couple different things outside of
the specific challenge (and waste more time I should spend doing work).  For
`ch-2.pl`, however, the prospect of coming up with a bunch of delimiter tests
cases seemed dangerously boring.  So, instead, `ch-2.pl` is written as an
interactive CLI.  Running `./ch-2.pl` starts our utility.  Sample output is 
shown below.

#### Output

```
$ ./ch-2.pl
Welcome to delimiter search (type 'exit' or Ctrl+c to quit).
Please provide delimiter string (ie: ''[]{}<>**): ""[]()
Please provide search string: "I like (parens) and the Apple ][+" they said.
Results:
"(["
")]"
Welcome to delimiter search (type 'exit' or Ctrl+c to quit).
Please provide delimiter string (ie: ''[]{}<>**): **//<>
Please provide search string: /* This is a comment (in some languages) * / <could be a tag>
Results:
/**/<
/**/>
Welcome to delimiter search (type 'exit' or Ctrl+c to quit).
Please provide delimiter string (ie: ''[]{}<>**): exit"
```

## Coming Soon

Participating in PWC helps me work towards two goals, sharpening my Perl (and
hopefully a couple other languages, too) and driving me to polish my writing.
I don't have any specific aspirations to write for a living, but I believe that
great documentation is a big part of writing great code.  Along with that, in my
time lurking around the Perl community, the call to write and blog about Perl in
order to keep interest in it active is hard to miss.  Unfortunately, I ran short
of time this week, but my hope is that by next week I can move my summary out of
the README and to my currently hypothetical blog.  I also found myself agreeing
with some of the points I found in [Bartosz Jarzyna's Blog].  Not so much in
that the puzzles should be reduced to one per week, or that they should be
necessarily related, but in that a bunch of "Perl Weekly Challenge - 12345"
blogs aren't exactly super helpful to newcomers, nor are they much fun for
anyone outside the PWC.  When I first started learning Perl, about a year ago, I
remember being frustrated because it was hard to find new content about Perl on
the web or on learning platforms like Pluralsight and Codecademy.  Mostly, when
I Googled Perl, the articles returned were all along the lines of "Is it still
worth it to learn Perl in the year foo?"  When I started lurking on the
subreddit r/perl, it seemed most of the buzz was about conflicts on the steering
committee, which was largely inside baseball to me.  Still, the more I hacked
away at Perl, the more I found myself to really enjoy it.  I don't really have
anyone in my immediate circle to evangelize Perl (or really any coding language)
to, but I feel pretty strongly about it.  So, my aim moving forward is to focus
on writing about one challenge per week, working through the solution in a way
that someone new to the language may someday appreciate.  Hopefully, blogging to
the void will give me a chance to sharpen my skills, Perl or otherwise, and also
help me to feel both a part of the community and a part of the future of Perl!

[Perl Weekly Challenge - 131]: https://theweeklychallenge.org/blog/perl-weekly-challenge-131/
[stackoverflow]: https://stackoverflow.com/
[Bartosz Jarzyna's Blog]: https://brtastic.xyz/blog/article/improving-pwc 
