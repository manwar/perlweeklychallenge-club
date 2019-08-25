perl6 -e '(1..∞).grep({.is-prime}).map({($_,$_+6) if ($_+6).is-prime})[^10].map({.join(q{, }).say});'
