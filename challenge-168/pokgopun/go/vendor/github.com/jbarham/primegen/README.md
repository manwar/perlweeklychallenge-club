# primegen

*primegen* is a Go package that generates prime numbers in order using the Sieve
of Atkin instead of the traditional Sieve of Eratosthenes.

It is a relatively straightforward port of D. J. Bernstein's
[original C implementation](http://cr.yp.to/primegen.html) but makes use of
Go's concurrency features which should make it faster on multi-core CPUs.

Do `go get github.com/jbarham/primegen` to install the package.

View the package documentation online at
https://pkg.go.dev/github.com/jbarham/primegen
or on the command line by running `go doc github.com/jbarham/primegen`.

The repository includes two additional programs that illustrate usage of the
primegen package:

1. primes, which writes prime numbers to standard out
2. primespeed, which prints the time taken to generate the first 50,847,534
   prime numbers

John Barham, [Wombat Software](https://www.wombatsoftware.com/)
