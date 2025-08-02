import groovy.json.JsonSlurper

final REPLACEMENTS = ['()', '[]']
def jsonSlurper = new JsonSlurper()
def x = jsonSlurper.parseText(System.console().readLine('@x = ').tr(*REPLACEMENTS))
def y = jsonSlurper.parseText(System.console().readLine('@y = ').tr(*REPLACEMENTS))

x.sort()
y.sort()

def expected_difference = y[0] - x[0]

def all_expected = [x, y].transpose().collect{ a, b -> b - a }.every{ it == expected_difference }

println all_expected ? expected_difference : 'N/A'
