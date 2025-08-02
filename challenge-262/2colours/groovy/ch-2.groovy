import groovy.json.JsonSlurper

final REPLACEMENTS = ['()', '[]']
def jsonSlurper = new JsonSlurper()
def ints = jsonSlurper.parseText(System.console().readLine('@ints = ').tr(*REPLACEMENTS))
def k = System.console().readLine('$k = ').toInteger()
println ints.withIndex().collect { it, index ->
    Integer neededFactor = k / (k as BigInteger).gcd(index as BigInteger)
    Integer nextValid = Math.ceil((index + 1) / neededFactor) * neededFactor;
    def possible_values = ints.drop(nextValid).collate(neededFactor)*.get(0)
    possible_values.count(it)
}.sum()