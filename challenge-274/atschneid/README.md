# Concerning Goats and Buses

**Challenge 274 solutions by Andrew Schneider**

Being a stream of consciousness write up of some details of my code for [PWC 274](https://theweeklychallenge.org/blog/perl-weekly-challenge-274/)

Great challenges this week! Challenge 1 seemed easy, but depending on how you want to manage the unspecified details, it can get as complicated as you want. Perl really crushes it on this one. Challenge 2 took some thought. I iterated through a bunch of solutions. I first worked out a solution in Python (not shown) to work out the details, then translated that solution into Perl, then C, then Haskell, then Julia, then back again, with improvements along the way. I went from using 3 loops to 2, to none-ish.

This is the first week that I used my random selection script to pick which lannguages to use, and abided by the results. This week the wheel landed on Haskell, Julia, and C. I figure I'll keep Perl as a perennial selection, since this is the *Perl* Weekly Challenge after all.

## Challenge 1: Goat Latin

> Task 1: Goat Latin</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a sentence, $sentance.</br>
> </br>
> Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.</br>
> </br>
> Rules for Goat Latin:</br>
> </br>
> 1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append</br>
>    "ma" to the end of the word.</br>
> 2) If a word begins with consonant i.e. not a vowel, remove first</br>
>    letter and append it to the end then add "ma".</br>
> 3) Add letter "a" to the end of first word in the sentence, "aa" to</br>
>    the second word, etc etc.</br>
> </br>
> Example 1</br>
> Input: $sentence = "I love Perl"</br>
> Output: "Imaa ovelmaaa erlPmaaaa"</br>
> </br>
> Example 2</br>
> Input: $sentence = "Perl and Raku are friends"</br>
> Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"</br>
> </br>
> Example 3</br>
> Input: $sentence = "The Weekly Challenge"</br>
> Output: "heTmaa eeklyWmaaa hallengeCmaaaa"</br>

What the instructions don't specify is what constitues a "word". A simple implementation might be to consider all non-whitespace characters to be words. I feel like this would lead to undesired behavior around punctuation, which typically does not have whitespace between its preceding character. Another thing to consider is whether we disturb the non-word portion of the string. For example, if we split on whitespace we may end up elliding consecutive spaces in our goatified string. I decided to treat any consecutive spans of alpha characters as words and everything else as non-words.

I tried to have my output be consistent across implementations. In my design a string like "hey, you!" will get goatified to "eyhmaa, ouymaaa!" (and not like "ey,hmaa ou!ymaaa"). One detail I'm not completely happy with is how apostrophes are handled. A string like "don't look!" gets goatified to "ondmaa'tmaaa ooklmaaaa!", but my heart tells me it should really come out like "on'tdmaa ooklmaaa!". I didn't feel little working too hard on this little detail, so I stuck with the former.

### Perl

Perl really handles this one quite nicely. At first I split on whitespace and performed multiple rounds of regex substitution, but doing global substitution is such a neater solution, and preserves non-word characters.

```perl
sub make_to_goat_latin( $string ) {
    # if non-vowel initial then move to end
    $string =~ s/\b([BCDFGHJKLMNPQRSTVWXYZ])(\w+)\b/$2$1/ig;

    # suffix each (proper) word with maa, maaa, maaaa, etc.
    my $count = 0;
    $string =~ s/\b(\w+)\b/$1 . 'ma' . 'a' x ++$count/eg;
    return $string;
}
```

I first handle moving a non-vowel initial to the end of each word. Then append the appropriate length suffix to each word. I probably could have handled this all in one monster regex, but I think this is a good readability tradeoff. I don't need to worry about splitting it out because the first substitution will not create a word from a non-word. Using the `e` flag in the second substitution to calculate the length of the "maa...a" suffix really makes things easy here. In my other solutions I don't rely on regex nearly as much if at all, because I didn't have anything as powerful as this.

### C

In C, and the others, the strategy I used is to first split the string into an alternating word, non-word list, next operate on the words in the list, and finally stitch the list back together (or ... not quite "together"). In C I really got into the weeds in character manipulations. I didn't easily find existing functions to interact between chars and strings (C style) the way I needed to, so this ended up looking like an "Intro to Programming in C" homework assignment.

As laid out above, first I split the string into an alternating word, non-word list. I make it a linked list of `word_ll` type.

```c
typedef struct word_ll {
  char *word;
  struct word_ll *next;
} word_ll ;

word_ll build_word_chaff_ll( char *str ) {
  word_ll head = { .word=malloc( sizeof(char) * 100), .next=NULL };
  word_ll *next = &head;

  int status = 0;
  size_t word_ctr = 0;
  for (char *c = str; *c != '\0'; c++) {
    
    if (
        (status != 1 && ( (*c >= 65 && *c <= 90) || (*c >= 97 && *c <= 122) ) ) ||
        (status != 0 && !( (*c >= 65 && *c <= 90) || (*c >= 97 && *c <= 122) ))
        ) {      
      next = next->next = malloc( sizeof(word_ll) );
      next->word = malloc( sizeof(char) * 100);
      word_ctr = 0;
      status = (status + 1) % 2;
    }
    next->word[word_ctr++] = *c;
  }
  
  return head;
}
```

I am doing a lot of `malloc`s in there, and returning an object containing a pointer, so it would be up to the calling function to handle `free`ing the memory. I don't explicitly do that since the program ends soon after this function returns.

The logic here is I start building a string for the first non-word. If the next char is a non-word char, I append it to the current word. Otherwise I finish that word, start building a word string, and append to that while we see word characters. I alternate back and forth between non-word and word until I get through all chars of the string.

Below is the function that takes a word and the index of the word in the sentence (to figure out how many 'a's are needed) and does the goat word level changes. This would blow up if our words and their buffers were longer than 100 chars long, so I'm playing pretty fast and loose here, but it works for the examples.

```c
void goatify_word( char *word, size_t alen ) {
  char temp[100] = "\0";
  int i=1;
  // starts with vowel?
  switch (*word) {
  case 'A':case 'E':case 'I':case 'O':case 'U':case 'a':case 'e':case 'i':case 'o':case 'u':
    break;
  default:
    for (i=1; word[i] != '\0'; i++) {
      temp[i-1] = word[i];
    }
    temp[i-1] = word[0];
    strcpy( word, temp );
    break;
  }
  
  i = strlen( word );
  word[i++] = 'm';
  for (int j=0; j <= alen; j++) {
    word[i++] = 'a';
  }
  word[i] = '\0';
}
```

Finally here's that function that ties it all together

```c
word_ll make_to_goat_latin( char *str ) {
  word_ll list_head = build_word_chaff_ll( str );
  int word_ctr = 0;

  for (word_ll *next = &list_head; next != NULL; next = next->next) {
    if (word_ctr++ % 2) {
      goatify_word(next->word, word_ctr/2);
    }
  }
  return list_head;
}
```

A better design would have not required `malloc`s inside the functions that are expected to get `free`d elsewhere. But this is a pretty small script, I opted for the mediocre solution.

### Haskell

I had a pretty clear vision of what I wanted to do in Haskell with this, which I stayed pretty true to. It is basically the same idea as with the C solution: split into a word, non-word alternating list, run the goat modifications on the words in order, and stitch everything back together. 

As I was first working on this I built a tremendous amount of supporting infrastructure, including a `mapAdjacent` operator which takes a binary function and applies to every consecutive pair of values in a list. I even further modified that into `mapAdjacentR` and `mapAdjacentL` differing in which value is the first argument. Some days after, I was continuing to read Learn You a Haskell and realized I didn't need half of what I had written. What a shame! It was a good exercise, but being a diligent student, I cut out half my code and used the existing module functions.

Here `groupBy` does the work of splitting our string into the alternating word, non-word list

```haskell
goatifyString string =
  let words_list = groupBy ((==) `on` isAlpha) string
      words_index = zip words_list [2 ..]
      goated_words = map (\x -> goatifyWord (fst x) (div (snd x) 2)) words_index
   in concat goated_words
```

And then `goatifyWord` is defined as 

```haskell
goatifyWord :: String -> Int -> String
goatifyWord word count
  | isVowel $ word !! 0 =
      word ++ "ma" ++ (concat $ take count $ repeat "a")
  | isAlpha $ word !! 0 =
      (tail word) ++ [word !! 0] ++ "ma" ++ (concat $ take count $ repeat "a")
  | otherwise = word
```

That's basically it.

### Julia

In Julia I made some small use of regex to handle the words that start with consonants, but I still had to do something to handle the increasing length 'a' suffix. Here I have kind of combined the logic of both C functions (or Haskell functions) that splits the list, operates on the words, then stitches them back together.

```julia
function make_to_goat_latin( str_in )
    word_chars = ['A':'Z';'a':'z']
    
    current_word = []
    out_vec = []
    suffix = "ma"

    for char in str_in
        if char in word_chars
            push!( current_word, char )
        else
            if size( current_word, 1 ) > 0
                suffix *= 'a'
                word = join( current_word, "" )
                current_word = []
                word = replace( word, r"([^AEIOU])(.*)"i => s"\2\1" )
                push!( out_vec, word * suffix )
            end
            push!( out_vec, char )
        end
    end
    join( out_vec, "" )
end
```

Kind of a hacky mess, but it works and I'm learning

## Challenge 2: Bus Route

> Task 2: Bus Route</br>
> Submitted by: Peter Campbell Smith</br>
> Several bus routes start from a bus stop near my home, and go to the same stop in town. They each run to a set timetable, but they take different times to get into town.</br>
> </br>
> Write a script to find the times - if any - I should let one bus leave and catch a strictly later one in order to get into town strictly sooner.</br>
> </br>
> An input timetable consists of the service interval, the offset within the hour, and the duration of the trip.</br>
> </br>
> Example 1</br>
> Input: [ [12, 11, 41], [15, 5, 35] ]</br>
> Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]</br>
> </br>
> Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11, 23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5 minutes past (5, 20, ...) and takes 35 minutes.</br>
> </br>
> At 45 minutes past the hour I could take the route 1 bus at 47 past the hour, arriving at 28 minutes past the following hour, but if I wait for the route 2 bus at 50 past I will get to town sooner, at 25 minutes past the next hour.</br>
> </br>
> Example 2</br>
> Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]</br>
> Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]</br>

This was a problem that took some thought at first. As mentioned above, basically every time I implemented a solution I cut out a loop. 

### Perl

This is the ugliest of all my solutions, and closest to what I originally came up with. By the time of writing I know enough to make a better algorithm design, but out of sheer laziness I did not do that. Let's say this one is an artifact.

The logic all happens in this monster subroutine

```perl
sub find_switch_minutes( @schedules ) {
    my $num_minutes = 60;
    
    my %next_depart;
    my %next_arrive;

    for my $s (@schedules) {
        my ($step, $start, $duration) = @$s;
        
        my @temp_vals = (-1) x ($num_minutes + $start + 1);
        for (my $i = $start; $i < $num_minutes + $start + 1; $i+=$step) {
            $temp_vals[$i] = [$i + $duration, $i];
        }
        
        # this is to backfill for the next arrival
        my $fill_val = -1;
        for (my $i = $#temp_vals; $i > -1; --$i) {
            if ($temp_vals[$i] != -1) {
                $fill_val = $temp_vals[$i];
            } else {
                $temp_vals[$i] = $fill_val;
            }
        }

        # now find the minimum for arrival time and minimum for departure time
        for my $i (0..$#temp_vals) {
            my $val = $temp_vals[$i];

            if ($val == -1) {
                last;
            }

            if (not exists $next_depart{$i} or $val->[1] < $next_depart{$i}->[1]) {
                $next_depart{$i} = $val;
            } elsif ($val->[1] == $next_depart{$i}->[1] and $val->[0] < $next_arrive{$i}->[0]) {
                $next_depart{$i} = $val;
            }
            
            if (not exists $next_arrive{$i} or $val->[0] < $next_arrive{$i}->[0]) {
                $next_arrive{$i} = $val;
            }
        }
    }

    # now check if any earliest leave time isn't an earliest arrive time
    my @indices;
    for my $i (0..$num_minutes-1) {
        if (not exists $next_arrive{$i} or not exists $next_depart{$i}) {
            next;
        }
        if ($next_arrive{$i}->[0] < $next_depart{$i}->[0]) {
            push @indices, $i;
        }
    }

    return @indices;
}
```

First for every bus, I build an array mapping every minute to the next departing bus and its arrival time. Next I check against all bus schedules I have calculated, I keep a list of the next departing bus and its minimum arrival time (in case two buses depart at the same time), and the minimum arrival time. Finally I check if the minimum arrival time is strictly less than the minimum arrival time of the next departing bus(es). When I put it like that is sounds pretty simple.

### C

In C I was able to tighten things up a little

```c
int find_switch_minutes( const input_tuple inputs[], const int num_inputs, int output[], const int num_minutes ) {
    
  time_tuple next_depart[num_minutes];
  time_tuple next_arrive[num_minutes];
  for (int i=0; i < num_minutes; i++) {
    next_depart[i].arrive = next_arrive[i].arrive = 10000;
    next_depart[i].depart = next_arrive[i].depart = 10000;
  }
  
  for (int i=0; i < num_inputs; i++) {
    const int step = inputs[i].step;
    const int start = inputs[i].start;
    const int duration = inputs[i].duration;
    
    time_tuple fill_val;
    // now find the minimum for arrival time and minimum for departure time
    for (int i = num_minutes + start; i > -1; --i) {
      if ( (i - start) % step == 0 ) {
        fill_val.arrive = i + duration;
        fill_val.depart = i;
      }

      if (i >= num_minutes) {
        continue;
      }

      if (
          (fill_val.depart < next_depart[i].depart) ||
          (fill_val.depart == next_depart[i].depart && fill_val.arrive < next_arrive[i].arrive)
          ) {
        next_depart[i].arrive = fill_val.arrive;
        next_depart[i].depart = fill_val.depart;
      } 
            
      if (fill_val.arrive < next_arrive[i].arrive) {
        next_arrive[i].arrive = fill_val.arrive;
        next_arrive[i].depart = fill_val.depart;          
      }
    }
  }
      
  // now check if any earliest leave time isn't an earliest arrive time
  int count_skips = 0;
  for (int i=0; i < num_minutes; i++) {
    if (next_arrive[i].arrive < next_depart[i].arrive) {
      output[count_skips++] = i;
    }
  }

  return count_skips;
}
```

Instead of filling in the depart arrival schedule in one loop, and then find the minimu depart time and arrival in a separate loop, here I do them both in one pass. I go backward from the end time. If the minute is a departure minute I can calculate the new valid depart and arrival times, otherwise I just use the previous values. Also this way I don't need to build schedule arrays for each bus schedule, since I can use the depart, arrive values right away. 

Also here I pre-allocate the buffer for the return value and pass it to the function so I don't have to worry about hidden `malloc`s like I mentioned above. See. I learn as I go. The value I return from this function is the number of skip bus minutes I found, so I know how far into the pre-allocated array to read to get the results.

### Haskell

Here is where I really hit my stride. Usually when I am writing something in Haskell I have the feeling like, this is good enough to get the job done, but a real Haskeller would be sickened by this. But on this one, I feel like maybe I've done ok. I make heavy use of lazy evaluation, and I flipped the order of how I was thinking about the problem previously.

To start I create some datatypes, to keep things neater

```haskell
data Schedule = Schedule
  { start :: Int,
    step :: Int,
    duration :: Int
  }
  deriving (Show)

data TimeInfo = TimeInfo
  { arrive :: Int,
    depart :: Int
  }
  deriving (Show)
```

Then for a given schedule I can find its arrive, depart values for every minute 

```haskell
timeToArriveDepart :: Schedule -> Int -> TimeInfo
timeToArriveDepart ti t =
  let factor = 1 + div (t - (start ti) - 1) (step ti)
      depart = (start ti) + factor * (step ti)
   in TimeInfo {depart = depart, arrive = depart + (duration ti)}

getArriveDepartMinutes :: Schedule -> [TimeInfo]
getArriveDepartMinutes t = map (timeToArriveDepart t) [0 ..]
```

The logic here is that at time `t` I can figure out directly when the next bus will leave and arrive. There are two potential gotchas in this formula which I dodged without realizing, although one of them caused great confusion when I reimplemented this logic in Julia. 

The formula: we can subtract the start time from the current time, then integer divide by the inter-bus-arrival time to find out when the next bus will leave. Multiply that plus one by the inter-arrival time and add back the start time. 

The first gotcha, that didn't come up in the test cases, is that this won't work if the start time is greater than the step time. I would have to put some different logic to handle that correctly. The second involves how integer division handles negatives. I have seen articles about this, but never thought it would affect me... See the Julia section for more.

```haskell
checkSkipOne :: [TimeInfo] -> Bool
checkSkipOne tis =
  let next_depart = minimum $ map (depart) tis
      min_by_depart = minimum $ map (arrive) $ filter (\t -> (depart t) == next_depart) tis
      min_by_arrive = minimum $ map (arrive) tis
   in min_by_arrive < min_by_depart

skipBuses :: [Schedule] -> [Int]
skipBuses tis =
  let minute_infos = map (getArriveDepartMinutes) tis
      skip_bools = take 60 $ map (checkSkipOne) $ transpose minute_infos
      indexed_bools = zip skip_bools [0 ..]
   in map (snd) $ filter (fst) indexed_bools
```

We find the minimum depart time, then filter on all buses leaving at that time, taking the minimum arrival time. Next we take the minimum overall arrival time for the minute. If the former is greater than the latter, we've got a skip bus. Zip that map together with an index, filter on the true skip vals, and we have our answer.

### Julia

I wrote my Julia solution last, after learning much from working out my Haskell solution. It has a similar breakdown

```julia
function find_next_bus_info( t::Int, sched::Schedule )
    factor = 1 + div( ( t - sched.start - 1 ), sched.step, RoundDown )
    depart = factor * sched.step + sched.start
    depart, depart + sched.duration
end
```

Here I basically copied over my function from Haskell, but I was getting odd results in the low index values. It took me a while to think about negative value integer division, and then I even got thrown off that track because of the way Haskell wants you to enter negative numbers (`(-1)` not just `-1`). But the bug came down to this. Haskell was doing integer division rounding down to minus infinity, while Julia by default was rounding to zero. So for example Haskell would take `div (-3) 4` and give `-1` while Julia would take `div(-3, 4)` and give `0`. 

Aiyahh! After much head scratching and doc reading I realized the issue, and Julia `div` takes an optional third arg telling it how to round negative values, and so I pass it the `RoundDown` arg above and get the desired result.

```julia
function find_switch_times( schedules )
    num_minutes = 60
    output = Vector{Int}()

    for t = 0:num_minutes - 1
        depart_arrive_vals = Vector{Tuple{Int, Int}}()

        for sched = schedules
            push!( depart_arrive_vals, find_next_bus_info( t, sched ) )
        end
        
        if sort( depart_arrive_vals )[1][2] != sort( map( (x) -> x[2], depart_arrive_vals ) )[1]
            push!( output, t )
        end
    end
    output
end
```

The rest of the code steps through the minutes and checks if it is a skip bus minute. Once I have the negative division bug worked out, the rest was no problem.

## Conclusion

Well, here we are again. Another great set of challenges, some lackluster coding work on my part, and some sampling of my inner monologue as I look some code samples. Also, another week where I have come close, but not actually submitted any ideas for future PWCs.

See you next week!
