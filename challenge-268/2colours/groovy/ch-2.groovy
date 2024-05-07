import groovy.json.JsonSlurper
import groovy.json.JsonOutput

final REPLACEMENTS = ['()', '[]']
def jsonSlurper = new JsonSlurper()
def ints = jsonSlurper.parseText(System.console().readLine('@ints = ').tr(*REPLACEMENTS))

ints.sort()

println JsonOutput.toJson(ints.collate(2).collectMany{ it.reverse() }).tr(*REPLACEMENTS.reverse())
