import groovy.json.JsonSlurper

final REPLACEMENTS = ['()', '[]']
def jsonSlurper = new JsonSlurper()
def ints = jsonSlurper.parseText(System.console().readLine('@ints = ').tr(*REPLACEMENTS))
println ints.groupBy{ Integer.signum(it) }.findAll{ it.key.abs() > 0 }.values()*.size().max()