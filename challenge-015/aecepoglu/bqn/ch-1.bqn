# Challenge 1
#  Strong p(n): p(n) > [ p(n-1) + p(n+1) ] / 2
#  Weak   p(n): p(n) < [ p(n-1) + p(n+1) ] / 2
p←/ (1<n) {𝕩∧¬𝕨(≠∧(0=|))n}´⌽ 2↓ n←↕250# sieve based primes
(1⊏⎉1 {𝕊a‿b‿c:b>2÷˜a+c}˘/⊢)3↕p # strong primes
(1⊏⎉1 {𝕊a‿b‿c:b<2÷˜a+c}˘/⊢)3↕p # weak primes
