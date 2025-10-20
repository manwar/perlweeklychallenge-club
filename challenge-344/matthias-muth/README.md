# The Zero Champion

**Challenge 343 solutions in Perl by Matthias Muth**

## Task 1: Zero Friend

> You are given a list of numbers.<br/>
> Find the number that is closest to zero and return its distance to zero.
>
> **Example 1**
>
> ```text
> Input: @nums = (4, 2, -1, 3, -2)
> Output: 1
>
> Values closest to 0: -1 and 2 (distance = 1 and 2)
> ```
>
> **Example 2**
>
> ```text
> Input: @nums = (-5, 5, -3, 3, -1, 1)
> Output: 1
>
> Values closest to 0: -1 and 1 (distance = 1)
> ```
>
> **Example 3**
>
> ```text
> Input: @ums = (7, -3, 0, 2, -8)
> Output: 0
>
> Values closest to 0: 0 (distance = 0)
> Exact zero wins regardless of other close values.
> ```
>
> **Example 4**
>
> ```text
> Input: @nums = (-2, -5, -1, -8)
> Output: 1
>
> Values closest to 0: -1 and -2 (distance = 1 and 2)
> ```
>
> **Example 5**
>
> ```text
> Input: @nums = (-2, 2, -4, 4, -1, 1)
> Output: 1
>
> Values closest to 0: -1 and 1 (distance = 1)
> ```

I think this is one of the easiest tasks I have solved so far.

The number that is 'closest to zero' has the minimum absolute value.<br/>
This translates directly into Perl:
`map` the numbers to their `abs` values, and return their `min`.

With my preferred minimal boilerplate it looks like this: 

```perl
use v5.36;
use List::Util qw( min );

sub zero_friend( @nums ) {
    return min( map abs, @nums );
}
```

Note that I make use of the implicit `$_` parameter of the `abs` function if no explicit parameter is given.<br/>
The idea is that this can be read as follows:

>  'map the numbers to their absolute values'

as opposed to 

> 'map each number to the result of the abs function applied on it'

as it would be for `map abs( $_ ), @nums`.<br/>The difference is very subtle, but I prefer this slightly more functional style.

On the other hand, I use explicit parentheses for the `min` function.<br/>That's for easier reading, too, because here, we really care about the parameters as being recognized as parameters. 

TIMTOSTDI - There is more than one style to do it...

## Task 2: Champion Team

> You have n teams in a tournament. A matrix grid tells you which team is stronger between any two teams:
> ```text
> If grid[i][j] == 1, then team i is stronger than team j
> If grid[i][j] == 0, then team j is stronger than team i
> ```
> Find the champion team - the one with most wins, or if there is no single such team, the strongest of the teams with most wins. (You may assume that there is a definite answer.)
>
> **Example 1**
>
> ```text
> Input: @grid = (
>                  [0, 1, 1],
>                  [0, 0, 1],
>                  [0, 0, 0],
>                )
> Output: Team 0
>
> [0, 1, 1] => Team 0 beats Team 1 and Team 2
> [0, 0, 1] => Team 1 beats Team 2
> [0, 0, 0] => Team 2 loses to all
> ```
>
> **Example 2**
>
> ```text
> Input: @grid = (
>                  [0, 1, 0, 0],
>                  [0, 0, 0, 0],
>                  [1, 1, 0, 0],
>                  [1, 1, 1, 0],
>                )
> Output: Team 3
>
> [0, 1, 0, 0] => Team 0 beats only Team 1
> [0, 0, 0, 0] => Team 1 loses to all
> [1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
> [1, 1, 1, 0] => Team 3 beats everyone
> ```
>
> **Example 3**
>
> ```text
> Input: @grid = (
>                  [0, 1, 0, 1],
>                  [0, 0, 1, 1],
>                  [1, 0, 0, 0],
>                  [0, 0, 1, 0],
>                )
> Output: Team 0
>
> [0, 1, 0, 1] => Team 0 beats teams 1 and 3
> [0, 0, 1, 1] => Team 1 beats teams 2 and 3
> [1, 0, 0, 0] => Team 2 beats team 0
> [0, 0, 1, 0] => Team 3 beats team 2
>
> Of the teams with 2 wins, Team 0 beats team 1.
> ```
>
> **Example 4**
>
> ```text
> Input: @grid = (
>                  [0, 1, 1],
>                  [0, 0, 0],
>                  [0, 1, 0],
>                )
> Output: Team 0
>
> [0, 1, 1] => Team 0 beats Team 1 and Team 2
> [0, 0, 0] => Team 1 loses to Team 2
> [0, 1, 0] => Team 2 beats Team 1 but loses to Team 0
> ```
>
> **Example 5**
>
> ```text
> Input: @grid = (
>                  [0, 0, 0, 0, 0],
>                  [1, 0, 0, 0, 0],
>                  [1, 1, 0, 1, 1],
>                  [1, 1, 0, 0, 0],
>                  [1, 1, 0, 1, 0],
>                )
> Output: Team 2
>
> [0, 0, 0, 0, 0] => Team 0 loses to all
> [1, 0, 0, 0, 0] => Team 1 beats only Team 0
> [1, 1, 0, 1, 1] => Team 2 beats everyone except self
> [1, 1, 0, 0, 0] => Team 3 loses to Team 2
> [1, 1, 0, 1, 0] => Team 4 loses to Team 2
> ```

A bit more tricky, this one, but it can be translated into a short sequence of transformations.<br/>
Note that in my solution, the matrix is passed into the subroutine as an arrayref `$grid`, not as an array.

- First, calculate the 'score' for each team, by adding up the number of teams that this team beats (which is the number of '1' values in the team's `$grid` row):

  `     my @scores = map sum( $_->@* ), $grid->@*;`

  The 'team number' is the index of the team's `$grid` matrix row, and also of its entry in the `@scores` array.

- We are supposed to find 'the team with the most wins', so let's first find the highest score of all teams:

  `    my $best_score = max( @scores );`

- Next, extract the list of all teams that have this highest score.<br/>
  `    my @best_teams = grep { $scores[$_] == $best_score } keys @scores;`

  These are the 'best' teams.

- Now for the most complicated part:

  If we have more than one 'best' team, we need to find 'the strongest of the teams with most wins'. The strongest clearly is the one that would beat the others in a direct match. This means that we can run a virtual 'playoff' among the best teams to find the final winner.

  We declare the first team the preliminary winner. Then, all other 'best' teams challenge the current preliminary winner, in turn. The winner of each match is the new preliminary winner. The team that survives the last match is the overall winner. (Good that we were assured that there will be a definite solution, so we don't need to consider cyclic situations!)

  Now maybe you see how the 'playoff' corresponds to the `reduce` function:<br/>
  There, too, we take the first value, then apply all other values in turn, letting the code bock determine the value that will be carried over into the next iteration.

  So we run the best teams through `reduce`, looking up in the `$grid` matrix which is the stronger one of the two teams in each iteration.<br/>
  The last one to survive (which is the result of the `reduce` call) is our 'strongest' winning team, and we can return it to the caller:

  `     return "Team " . reduce { $grid->[$a][$b] ? $a : $b } @best_teams;` 

Putting this together results in a solution that makes good use of some `List::Util` functions (especially `reduce`!), and that I find surprisingly concise:

```perl
use v5.36;
use List::Util qw( sum max reduce );

sub champion_team( $grid ) {
    my @scores = map sum( $_->@* ), $grid->@*;
    my $best_score = max( @scores );
    my @best_teams = grep { $scores[$_] == $best_score } keys @scores;
    return "Team " . reduce { $grid->[$a][$b] ? $a : $b } @best_teams;
}
```

#### **Thank you for the challenge!**
