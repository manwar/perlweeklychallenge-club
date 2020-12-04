Christmas time, and it’s time to talk to each and every one! It’s a great idea to approach people by speaking their languages. In today’s post, let me demonstrate a number of working solutions of [the first problem of Week 89](https://perlweeklychallenge.org/blog/perl-weekly-challenge-089/#TASK1) of The Weekly Challenge in 22 different programming languages. It is a kind of continuation of my last year’s Advent series ‘[A Language a Day](https://andrewshitov.com/2019/11/25/a-language-a-day-advent-calendar-2019/)’.

# Problem

The problem is to add up all the [GCD](https://en.wikipedia.org/wiki/Greatest_common_divisor)s of the series of unique pairs of numbers between `1` and `$N` including `$N`.

For example, for the input number `100`, the summation chain is this one: 

    GCD(1, 2) + GCD(1, 3) + GCD(1, 4) + ... + GCD(1, 99) + GCD(1, 100) +
    GCD(2, 3) + GCD(2, 4) + GCD(2, 5) + ... + GCD(2, 99) + GCD(2, 100) +
    ...
    ... + GCD(98, 100) + GCD(99, 100)

The answer for this case is `13015`; it will be our password that confirms that the person we speak to understood us clearly even if we spoke a foreign language.

# Solutions

The solutions are grouped into two parts. In the first group, either a built-in or a library function is used to compute the greatest common divisor. In the second group, the algorithm is implemented directly in the program. In each section, the solutions are listed in the order in which I solved them.

All the programs can be run from the command line and accept the value of `$N` as the first parameter. If the number is missing, the default value `3` is used. The result of the program is always a single number printed in the console. You can see instructions of how to run the program exactly in the comment at the beginning of each program.

## Using built-in or library functions for GCD

1. [Raku](#1-raku)
1. [Python](#2-python)
1. [C++ (C++17)](#3-c)
1. [Perl](#4-perl)
1. [Ruby](#5-ruby)
1. [Scala](#6-scala)
1. [C#](#7-c)
1. [Dart](#8-dart)
1. [Julia](#9-julia)
1. [D](#10-d)
1. [Lisp (SBCL)](#11-lisp)

## With a custom implementation of GCD

1. [C](#12-c)
1. [JavaScript (node.js)](#13-JavaScript)
1. [Java](#14-java)
1. [Rust](#15-rust)
1. [Pascal (FreePascal)](#16-pascal)
1. [Go](#17-go)
1. [Lua](#18-lua)
1. [Fortran (Fortran 95)](#19-fortran)
1. [PHP](#20-php)
1. [Kotlin](#21-kotlin)
1. [Bash](#22-bash)

## Part 1

### 1. Raku

In Raku, we’ve got all the things required for a compact solution. Actually, the most compact among all the solutions below. So, we’ve got the [`combinations` method](https://docs.raku.org/routine/combinations) to convert a range into unique pairs of numbers and the built-in [`gcd` routine](https://docs.raku.org/routine/gcd). We also have the pleasure to use [reduction operators](https://docs.raku.org/language/operators#index-entry-[]_(reduction_metaoperators)) `[ ... ]` even if they can be easily replaced. For example, the first usage of it `[+]` can be replaced with the call of `sum`, and the second `[gcd] $_` with something like `$_[0] gcd $_[1]`. By the way, notice that in Raku, `gcd` is an infix operator, so you use it in the form of `$a gcd $b` and not as a function <s>`gcd($a, $b)`</s>.

    # Test run:
    # $ raku ch-1.raku 100
    # 13015

    my $n = @*ARGS[0] // 3;

    say [+] (1..$n).combinations(2).map: {[gcd] $_};

### 2. Python

In Python, there’s no built-in `gcd` or `combinations`, but both are available in the standard library. For diversity, I used `math.gcd` but implemented the combination creation with two nested `for` loops. The first loop iterates over the whole range between `1` and `$N`, while the inner loop starts with the current value of the outer loop.

    # Test run:
    # $ python3 ch-1.py 100
    # 13015

    import sys, math

    n = 3 if len(sys.argv) == 1 else int(sys.argv[1])

    s = 0
    for x in range(1, n + 1):
        for y in range(x + 1, n + 1):
            s += math.gcd(x, y)

    print(s)


### 3. C++

Here is a solution in C++. As the author of the language says, ‘C++ feels like a new language’, and even in this simple task, we can use the [library function `gcd`](https://en.cppreference.com/w/cpp/numeric/gcd) that is available since the standard C++17.

In the rest, the program also includes two nested loops and accumulates the sum for each combination.

    // Compile as:
    // $ g++ -std=c++17 ch-1.cpp

    // Test run:
    // $ ./a.out 100
    // 13015

    #include <iostream>
    #include <numeric>
    #include <sstream>

    using namespace std;

    int main(int argc, char** argv) {
        int n = 3;
        if (argc != 1) {
            stringstream input(argv[1]);
            input >> n;
        }

        int s = 0;
        for (int x = 1; x <= n; x++) {
            for (int y = x + 1; y <= n; y++) {
                s += gcd(x, y);
            }
        }

        cout << s << endl;
    }

### 4. Perl

Good old modern and future Perl is here! As, among the rest, it is famous for CPAN, let us use a [module `Math::Utils`](https://metacpan.org/pod/Math::Utils) from there. Actually, this is the only solution where I use a module that is not available in the default installation.

    # To run, install Math::Utils first:
    # $ cpanm Math::Utils
    # $ perl ch-1.pl 100
    # 13015

    use v5.20;

    use Math::Utils qw(gcd);

    my $n = $ARGV[0] // 3;

    my $s = 0;
    for my $x (1 .. $n) {
        for my $y ($x + 1 .. $n) {
            $s += gcd($x, $y);
        }
    }

    say $s;

### 5. Ruby

The program in Ruby is also quite compact, I would say. Notice how the `gcd` method is used here: `x.gcd(y)`. It is indeed is _a method,_ and it is called on one of the numbers. We’ll see more examples of such approach later.

    # Usage:
    # $ ruby ch-1.rb 100
    # 13015

    n = ARGV.length == 1 ? ARGV[0].to_i : 3

    s = 0
    for x in 1 .. n
        for y in x + 1 .. n
            s += x.gcd(y)
        end
    end

    puts s

### 6. Scala

In Scala, we have to deal with Java’s legacy and create a class to start the day. But nevertheless, the program is not that big. What you may want to enjoy is possibly the syntax of loop headers: `for (x <- 1 to n)` with the left arrow. Also notice that the `gcd` routine is again a method, and it’s a method defined for `BigInt`s: `BigInt(x).gcd(y)`.

    /*
        To run:
        $ scala  ch-1.scala 100
        13015
    */

    import math.BigInt

    object Main {
        def main(args: Array[String]): Unit = {
            var n: Int = if (args.size == 1) args(0).toInt else 3
            
            var s: BigInt = 0
            for (x <- 1 to n) {
                for (y <- x + 1 to n) {
                    s = s + BigInt(x).gcd(y)
                }
            }

            println(s)
        }
    }

### 7. C#

Here is the solution in C#. Welcome to the world of .NET, where many things are clearly spelt out: `BigInteger.GreatestCommonDivisor(x, y)`. In the rest, here we have the same two nested loops that build the pair of combinations.

    // Compile and run on a Mac:
    // $ csc -r:System.Numerics.dll ch-1.cs
    // $ mono ch-1.exe 100
    // 13015

    using System;
    using System.Numerics;

    class Program {
        static int Main(string[] args)
        {
            int n = 3;
            if (args.Length == 1) n = int.Parse(args[0]);
            
            var s = new BigInteger(0);
            for (int x = 1; x <= n; x++) {
                for (int y = x + 1; y <= n; y++) {
                    s += BigInteger.GreatestCommonDivisor(x, y);
                }
            }
            
            System.Console.WriteLine(s);

            return 0;
        }
    }

### 8. Dart

To me, languages built on C++ have their specific charm. On one side, it is the same known language, but on the other, it embeds the things that you were missing earlier (see, for example, how easy it is to deal with command-line arguments). The `gcd` here is again a method called on a number: `x.gcd(y)`.

    // To run:
    // $ dart ch-1.dart 100
    // 13015

    void main(List<String> args) {
        var n = 3;
        if (args.length == 1)
            n = int.parse(args[0]);

        var s = 0;
        for (var x = 1; x <= n; x++) {
            for (var y = x + 1; y <= n; y++) {
                s += x.gcd(y);
            }
        }

        print(s);
    }

### 9. Julia

Julia is another interesting language that actually has many similarities with Raku. For our today’s need, there’s a built-in `gcd` function that I am happily using. The only unexpected obstacle is, maybe, the need to explicitly refer to the accumulator `s` as to a `global` variable.

    # To run:
    # $ julia ch-1.julia 100
    # 13015

    n = length(ARGS) == 1 ? parse(Int, ARGS[1]) : 3

    s = 0
    for x in range(1, stop = n)
        for y in range(x + 1, stop = n)
            global s
            s += gcd(x, y)
        end
    end

    println(s)


### 10. D

Acter C comes D. And here we are. In the program, you can see extensive use of the `auto` declarator. I believe, the situation here resembles how some elements of Raku entered back in Perl, even if Raku was a continuation of Perl historically. Similarly, `auto` is now available in C++ too (while you need to practice not to forget to use `auto` automatically).

    // How to run:
    // $ rdmd ch1.d 100
    // 13015

    import std.stdio;
    import std.numeric;
    import std.conv;

    void main(string[] args) {
        auto n = args.length == 2 ? to!int(args[1]) : 3;
        
        auto s = 0;
        for (auto x = 1; x <= n; x++) {
            for (auto y = x + 1; y <= n; y++) {
                s += gcd(x, y);
            }
        }

        writeln(s);
    }

### 11. Lisp

Move on to a different world (for a bit). Here is the solution in a functional programming language. Well, Common Lisp adds some syntax sugar to help us build loops without manually manipulating loop counters and recursive calls. In any case, it also has the built-in `gcd` function, which, of course, you call as `(gcd x y)`. The below program works with the SBCL implementation (mostly because of how it reads the command-line arguments).

    ;;; How to run:
    ;;; $ sbcl --script ch-1.lisp 100
    ;;; 
    ;;; 13015 

    (defvar n (parse-integer (nth 1 *posix-argv*)))

    (defvar s 0)

    (loop for x from 1 to n
        do (
            loop for y from (+ 1 x) to n
                do (setq s (+ s (gcd x y)))        
        )
    )

    (print s)
    (terpri)

## Part 2

### 12. C

OK, and now we start the second part of the solutions list. Now, the GCD algorithm is implemented directly in the program itself. Refer to this implementation in C; this algorithm is used in all other solutions below.

    int gcd(int a, int b) {
        while (b) {
            int t = b;
            b = a % b;
            a = t;
        }

        return a;
    }

It is important to say that due to the loop organisation, we always call this function with such arguments that `b` is always bigger than `a`, so you don’t have to care about other cases.

So, here is the complete program in C:

    /*
        Compile:
        $ gcc ch-1.c

        Test run:
        $ ./a.out 100
        13015
    */

    #include <stdio.h>
    #include <stdlib.h>

    int gcd(int a, int b) {
        while (b) {
            int t = b;
            b = a % b;
            a = t;
        }

        return a;
    }

    int main(int argc, char** argv) {
        int n = 3;
        if (argc != 1) {
            n = atoi(argv[1]);
        }

        int s = 0;
        for (int x = 1; x <= n; x++) {
            for (int y = x + 1; y <= n; y++) {
                s += gcd(x, y);
            }
        }

        printf("%i\n", s);
    }

### 13. JavaScript

A Node.js slash JavaScript program is here for your further entertainment. It resembles a lot the previously shown C program. A similar pair of nested loops, and a similar implementation of `gcd`. Could you imagine 10-15 years ago that you would be able to run a JS program from command line?

    // Test run:
    // $ node ch-1.js 100
    // 13015

    let n = process.argv.length == 3 ? process.argv[2] : 3;

    let s = 0;
    for (let x = 1; x <= n; x++) {
        for (let y = x + 1; y <= n; y++) {
            s += gcd(x, y);
        }
    }

    console.log(s);

    function gcd(a, b) {
        while (b) {
            let t = b;
            b = a % b;
            a = t;
        }

        return a;
    }

### 14. Java

Now, look at the solution in Java. Yes, we have to use classes again, but in the rest, a nice and clean program that doesn’t require many more comments, I think.

    // To run:
    // $ java ch-1.java 100
    // 13015

    class Main {
        static int gcd(int a, int b) {
            while (b != 0) {
                int t = b;
                b = a % b;
                a = t;
            }

            return a;
        }

        public static void main(String[] args) {
            int n = args.length == 1 ? Integer.parseInt(args[0]) : 3;

            int s = 0;
            for (int x = 1; x <= n; x++) {
                for (int y = x + 1; y <= n; y++) {
                    s += gcd(x, y);
                }
            }

            System.out.println(s);
        }
    }

### 15. Rust

The program in Rust is an interesting combination of elements that we are familiar with from both C, JavaScript, and even Perl and Raku (for example, ranges `..`). Also, a nice addition of built-in type system, and maybe an unusual concept of macros — those ‘functions’ with an exclamation mark in their name such as `println!`.

    // To compile and run:
    // $ rustc ch-1.rs
    // $ ./ch-1 100
    // 13015

    use std::env;

    fn gcd(a: u32, b: u32) -> u32 {
        let mut x = a;
        let mut y = b;

        while y != 0 {
            let t = y;
            y = x % y;
            x = t;
        }

        return x;
    }

    fn main() {
        let args: Vec<String> = env::args().collect();

        let n;
        if args.len() == 2 {
            n = args[1].parse().unwrap();
        }
        else {
            n = 3;
        }

        let mut s = 0;
        for x in 1 .. (n + 1) {
            for y in (x + 1) .. (n + 1) {
                s += gcd(x, y);
            }
        }

        println!("{}", s);
    }

### 16. Pascal

I have a question for you. When did you program in Pascal last time? My answer is ‘Something like 30 years ago’. But honestly, that nostalgic mood is a great thing for the evenings around Christmas time. And while there’s no `gcd` built in, you can implement it yourself if you remember to use `<>` instead of `!=` and a single `=` in comparisons: `if paramCount() = 0 then`. I also struggled a bit with semicolons, for example, no semicolon allowed before `else`.

    (*
        To compile and run:
        $ fpc ch-1.pas
        $ ./ch-1 100
        13015
    *)

    program Hello(input, output);

    uses sysutils;

    var
        n, x, y, s: integer;

    function gcd(a, b: integer): integer;
    var
        t: integer;
    begin
        while b <> 0 do begin
            t := b;
            b := a mod b;
            a := t;
        end;

        gcd := a
    end;

    begin
        if paramCount() = 0 then
            n := 3
        else
            n := StrToInt(paramStr(1));
        
        s := 0;
        for x := 1 to n do
            for y := x + 1 to n do
                s += gcd(x, y);

        writeln(s);
    end.

### 17. Go

And now fast forward to the present days. Here is Go with its strict requirements not to leave garbage in the code and use all variables and imported modules. Notice that I used multiple assignments and avoided a temporary variable in the implementation of `gcd`: `b, a = a%b, b`. Heh, and the Go standard formatter removed my spaces around the `%` operator.

    // To compile and run:
    // $ go run ch-1.go 100
    // 13015

    package main

    import (
        "fmt"
        "os"
        "strconv"
    )

    func gcd(a, b int) int {
        for b != 0 {
            b, a = a%b, b
        }

        return a
    }

    func main() {
        n := 3
        if len(os.Args) == 2 {
            n, _ = strconv.Atoi(os.Args[1])
        }

        s := 0
        for x := 1; x <= n; x++ {
            for y := x + 1; y <= n; y++ {
                s += gcd(x, y)
            }
        }

        fmt.Println(s)
    }

### 18. Lua

Lua is the language that is loved by many people, and I believe there are many cases when its design with tables can be beneficial in many applications. For our practice, I used the standard approach: a few loops, and it’s done. I would still point your attention to the following line: `n = arg[1] and arg[1] or 3`, which is actually a ternary construction to assign the default value if the argument is missing.

    -- How to run:
    -- $ lua ch-1.lua 100
    -- 13015

    function gcd(a, b)
        while b > 0 do 
            t = b
            b = a % b
            a = t
        end

        return a
    end

    n = arg[1] and arg[1] or 3

    s = 0
    for x = 1, n do
        for y = x + 1, n do
            s = s + gcd(x, y)
        end
    end

    print(s)

### 19. Fortran

Going further to some science-related language. For a long time, Fortran was the language in which tons of algorithms were encoded for physics and mathematics. I believe it would be very beneficial to use this as the language to teach students (OK, consider that a joke with some elements of truth) :-) What would be really interesting is to browse into some sophisticated algorithms written decades ago — many of them may be unexpectedly efficient.

    ! To compile and run:
    !
    ! $ gfortran ch-1.f95
    ! $ ./a.out 100
    !       13015

    function mygcd(a, b) result(x)
        integer, intent(in) :: a, b
        integer :: x, y, t

        x = a
        y = b

        do while (y /= 0)
            t = y
            y = mod(x, y)
            x = t
        end do
    end function

    program hello
        integer :: n, x, y, s

        character(len=20) :: arg
        character(len=20) :: nstr

        if (iargc() == 1) then
            call getarg(1, nstr)
            read(nstr,*) n
        else
            n = 3
        end if
        
        s = 0
        do x = 1, n
            do y = x + 1, n
                s = s + mygcd(x, y)
            end do
        end do

        write(*,*) s
    end program

### 20. PHP

Let me introduce another solution with sigils, which, as you may see, is not too frequent part among the languages. Perl, Raku, PHP, and Bash in this list do use them though. I believe, if you are familiar with either Perl or Raku, you can understand every bit of this program in PHP (yeah, and no `my` declarators).

    <?php
        // Run as:
        // $ php ch-1.php 100
        // 13015

        function gcd($a, $b) {
            while ($b) {
                $t = $b;
                $b = $a % $b;
                $a = $t;
            }

            return $a;
        }

        $n = $argc == 2 ? $argv[1] : 3;

        $s = 0;
        for ($x = 1; $x <= $n; $x++) {
            for ($y = $x + 1; $y <= $n; $y++) {
                $s += gcd($x, $y);
            }
        }

        echo "$s\n";

    ?>

### 21. Kotlin

In the program in Kotlin, we see the use of typed variables, C-like functions and...double-dot ranges! What a surprise for the Perl and Raku lovers again.

    // How to run:
    // $ kotlinc ch-1.kt -include-runtime -d ch1.jar
    // $ java -jar ch1.jar 100
    // 13015

    fun gcd(a: Int, b: Int): Int {
        var x = a
        var y = b

        while (y != 0) {
            val t = y
            y = x % y
            x = t
        }

        return x
    }

    fun main(args: Array<String>) {
        var n: Int
        if (args.size == 1)
            n = args[0].toInt()
        else
            n = 3

        var s = 0
        for (x in 1..n) {
            for (y in x + 1 .. n) {
                s += gcd(x, y)
            }
        }

        println(s)
    }

### 22. Bash

And the last program on this page. At this point, I could add a poll to ask if you consider Bash a programming language or not. Honestly, I did not think it would be possible to solve today’s problem in Bash, but as you see, the result is not that much more complicated than the solutions in other languages. Enjoy it too!

    #!/usr/bin/bash

    # Usage:
    # $ bash ch-1.bash 100
    # 13015
    #
    # N. B. Try with smaller arguments, as the computations
    # for 100 as the input can take a while (~ a minute).

    gcd() {
        a=$1;
        b=$2;
        while [ $b -ne 0 ]; do
            t=$b
            b=`expr $a % $b`
            a=$t
        done

        gcd=$a
    }

    n=${1:-3} # default is 3

    s=0
    x=1
    while [ $x -le $n ]; do
        next=`expr $x + 1`;
        y=$next;
        while [ $y -le $n ]; do
            y=`expr $y + 1`;
            gcd $x $y;
            s=`expr $s + $gcd`;      
        done 
        x=$next;
    done

    echo $s

And that’s it for today. Tomorrow, there’s another post in this Advent Calendar, but don’t forget that there are more calendars this year, and there are more Weekly Challenges coming soon!
