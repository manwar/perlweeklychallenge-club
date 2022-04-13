num2words
=========

[![Build Status](https://travis-ci.org/divan/num2words.svg?branch=master)](https://travis-ci.org/divan/num2words)
[![GoDoc](https://godoc.org/github.com/divan/num2words?status.svg)](https://godoc.org/github.com/divan/num2words)

num2words - Numbers to words converter in Go (Golang)

## Usage

First, import package num2words

```import github.com/divan/num2words```

Convert number
```go
  str := num2words.Convert(17) // outputs "seventeen"
  ...
  str := num2words.Convert(1024) // outputs "one thousand twenty four"
  ...
  str := num2words.Convert(-123) // outputs "minus one hundred twenty three"
```

Convert number with " and " between number groups:
```go
  str := num2words.ConvertAnd(514) // outputs "five hundred and fourteen"
  ...
  str := num2words.ConvertAnd(123) // outputs "one hundred and twenty three"
```
