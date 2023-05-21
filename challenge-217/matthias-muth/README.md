**Challenge 217 solutions in Perl by Matthias Muth**

Apart from the two solutions that I have implemented this week
I have written a script that extracts the new task descriptions
from the
[Weekly Challenge web site](https://theweeklychallenge.org/blog/perl-weekly-challenge-217/)
and writes them into `challenge-<NN>/<USER>/perl/challenge-<NN>.txt`. <br/>
(I will publish that in one of the coming weeks.)

It also writes template files `perl/ch-1.pl` and `perl/ch-2-pl`, with
the challenge number and name, task number and name,
the subroutine name derived from the task name,
and even the input variable names and types, derived from the test data, already filled in.

I have a cron job that runs this every beginning of the week, so whenever there is a new
challenge, I can start coding right away!

The 'TestExtractor.pm' module extracts the test cases from that
task description file, and runs the tests for me,
without any editing of test data or test runs anymore.

I am sure that the effort of automating all of this will pay off very soon,
with every new challenge!

**Thank you for the challenge!**
