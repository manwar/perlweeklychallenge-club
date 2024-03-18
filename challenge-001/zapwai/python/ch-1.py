import re
str = "Perl Weekly Challenge"
print("Input:", str)
print("Output:", re.sub(r'e', 'E', str))
oc = re.findall(r'e', str)
print("e occurred", len(oc), "times.")
