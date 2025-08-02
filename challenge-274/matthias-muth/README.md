# These busses got class-maa!

**Challenge 274 solutions in Perl by Matthias Muth**

## Task 1: Goat Latin

> You are given a sentence, \$sentance [sic!].<br/>
> Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.<br/>
> Rules for Goat Latin:<br/>
>
> 1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append<br/>
>    "ma" to the end of the word.<br/>
> 2) If a word begins with consonant i.e. not a vowel, remove first<br/>
>    letter and append it to the end then add "ma".<br/>
> 3) Add letter "a" to the end of first word in the sentence, "aa" to<br/>
>    the second word, etc etc.
> 
> Example 1<br/>
> Input: \$sentence = "I love Perl"<br/>
> Output: "Imaa ovelmaaa erlPmaaaa"<br/>
> <br/>
> Example 2<br/>
> Input: \$sentence = "Perl and Raku are friends"<br/>
> Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"<br/>
> <br/>
> Example 3<br/>
> Input: \$sentence = "The Weekly Challenge"<br/>
> Output: "heTmaa eeklyWmaaa hallengeCmaaaa"<br/>

Again, Perl regular expressions come to help.<br/>
Let's construct the result 'on the fly':

* We `split` the sentence into words.
* For each word,
  we use a regular expression to separate the first letter from the rest,
  and to distinguish between a vowel as the first letter or a consonant
  (actually, anything else than a vowel).<br/>
  We use captures for anything we need later.<br/>
  I first tried using named captures,
  but for the simple case that we have here,
  I found the result more readable with just `$1`, `$2`, `$3`.
* For the suffix, we declare a lexical variable `$suffix`  beforehand, initializing it with "ma".<br/>We will add another `"a"` within every iteration.
* Constructing the resulting word is simple then:<br/>
  Depending on whether we found a vowel (which means that the `$1` capture is non-empty, we use the original word or a flipped version of it (using the `$2` and `$3` captures).<br/>
  Then we append the suffix, after having appended the additional `"a"` to it.

The whole Goat Latin translator looks like this:

```perl
use v5.36;

sub goat_latin( $sentence ) {
    my $suffix = "ma";
    return join " ",
        map {
            /^ (?: ([aeiou]) | (\w) ) (.*) /xi;
            $suffix .= "a";
            ( $1 ? $_ : "$3$2" ) . $suffix;
        } split " ", $sentence;
}
```

## Task 2: Bus Route

> Several bus routes start from a bus stop near my home, and go to the same stop in town. They each run to a set timetable, but they take different times to get into town.<br/>
> Write a script to find the times - if any - I should let one bus leave and catch a strictly later one in order to get into town strictly sooner.<br/>
> An input timetable consists of the service interval, the offset within the hour, and the duration of the trip.<br/>
> <br/>
> Example 1<br/>
> Input: [ [12, 11, 41], [15, 5, 35] ]<br/>
> Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]<br/>
> Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11, 23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5 minutes past (5, 20, ...) and takes 35 minutes.<br/>
> At 45 minutes past the hour I could take the route 1 bus at 47 past the hour, arriving at 28 minutes past the following hour, but if I wait for the route 2 bus at 50 past I will get to town sooner, at 25 minutes past the next hour.<br/>
> <br/>
> Example 2<br/>
> Input: [ [[12, 3, 41], [15, 9, 35], [30, 5, 25] ]<br/>
> Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]<br/>

#### Object-oriented approach, using Perl `class`

For every minute past the hour (`0..59`),
we will need know for any bus route when is its next departure time,
and what will be our arrival time if we take that bus.
We need this information to decide which bus is the 'next bus',
and then check 'later buses' for possibly to arrive earlier.

So what if we made every bus route an object,
with methods like `next_departure( $now )` and `next_arrival( $now )`,
where we can put in every minute we want to check as a parameter?

What a great way to demonstrate Perl's quite recent new `class` feature!<br/>
(... which has been out for over a year now, happy anniversary! Love to see it growing!)

The most difficult thing to compute is the next departure time.
But it is not too difficult if we first compute the *waiting time* until the bus's next departure.

When we miss a bus, the time since its previous departure is
```perl
        ( $now - $offset ) % $frequency
```
For the waiting time until the *next* departure, we simply turn things around:
```perl
    method waiting_time( $now ) {
        return ( $offset - $now ) % $frequency;
    }
```
The term `( $offset - $now )` can become negative
(it regularly is after the first departure),
but the `%` result is correct even for negative numbers.

Given the `waiting_time` method, the rest of the `BusRoute` class is simple.<br/>
The next departure will be `$now` plus the waiting time,
and the next arrival time is the next departure time plus the travel duration.

So here is the `BusRoute` class definition.<br/>
I added a `as_string` method to get a textual self-description for `BusRoute` objects,
to make it easy to produce tracing or debugging output.<br/>
I also used an override for the string conversion of the object.
This way, we can directly use object variables in a double-quoted string
to get their self-description on output. 

```perl
use v5.38;
use feature 'class';
no warnings 'experimental::class';

class BusRoute {
    field $frequency :param;
    field $offset    :param;
    field $duration  :param;

    method waiting_time( $now ) {
        return ( $offset - $now ) % $frequency;
    }

    method next_departure( $now ) {
        return $now + $self->waiting_time( $now );
    }

    method next_arrival( $now ) {
        return $self->next_departure( $now ) + $duration;
    }

    method as_string( @args ) {
        return ref( $self ) . "($frequency,$offset,$duration)";
    }
    use overload '""' => \&as_string;
}
```

#### Solving the task
##### Initializing the `BusRoute` objects

Our  input is a list of array references,
each one containing  *( frequency, offset, duration )* of one bus route.
To initialize our `BusRoute` objects, we need to send the parameters as a hash,
like `{ frequency => 12, offset => 11, duration => 41 }`.<br/>
I find it very convenient to use `mesh` from `List::Util` to create that parameter list:

```perl
    my @bus_routes =
        map BusRoute->new(
            mesh( [ qw( frequency offset duration ) ], $_ )
        ), $input->@*;
```

##### Loop over all minutes

Now we are ready to do the real job.

For every minute from 0 to 59, we do these four steps:

- Find the **next departure time**.

  No problem, it's the minimum of all `next_departure()` times of all buses.

- Find the '**best next bus arrival time**'.

  Actually there might be several buses leaving at the same time.
  We surely want to choose the one that also lets us *arrive* as early as possible.<br/>
  So it's the minimum *arrival* time of all buses
  whose departure is equal to our 'next departure time'. 

- Find the '**best later bus arrival time**'.

  Very similar, this is the minimum arrival time of all buses
  whose departure is ('strictly') *later* than our 'next departure time'.<br/>
  There might be no 'later' bus at all,
  if *all* buses happen to have their next departure
  at the 'next departure time'.

- Decide.

  If there is a 'best later bus arrival time' at all,
  and it is earlier than the 'best next bus arrival time',
  we include the current minute in the result set.

So here is the whole implementation.<br/>I have removed comments, because I described everything above.
I hope it's still understandable.<br/>
The files in GitHub contain comments, and tracing and debugging output. 

```perl
use v5.36;

use List::Util qw( mesh min );
use BusRoute;

sub bus_route( $input ) {
    my @bus_routes =
        map BusRoute->new(
            mesh( [ qw( frequency offset duration ) ], $_ )
        ), $input->@*;

    my @results = ();
    for my $now ( 0..59 ) {
        my $next_departure = min( map $_->next_departure( $now ), @bus_routes );
        my $best_next_bus_arrival = min(
            map $_->next_arrival( $now ),
                grep $_->next_departure( $now ) == $next_departure,
                    @bus_routes );
        my $best_later_bus_arrival = min(
            map $_->next_arrival( $now ),
                grep $_->next_departure( $now ) > $next_departure,
                    @bus_routes );
        push @results, $now
            if defined $best_later_bus_arrival
                && $best_later_bus_arrival < $best_next_bus_arrival;
    }
    return \@results;
}
```

#### **Thank you for Perl 'class'!**
#### **And thank you for the challenge!**
