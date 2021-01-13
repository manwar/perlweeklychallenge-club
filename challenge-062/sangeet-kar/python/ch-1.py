import sys

unique = len(sys.argv) > 1 and sys.argv[1] == '-u'
files = sys.argv[2:] if unique else sys.argv[1:]

mails = []
if files:
    for f in files:
        mails.extend(open(f).read().splitlines())
else:
    mails.extend(sys.stdin.read().splitlines())

mails = [mail.split("@") for mail in mails]

if unique:
    mails = {(name, domain.lower()) for name, domain in mails}

mails = sorted(mails,key=lambda pair: (pair[1].lower(), pair[0]))

print("\n".join(f"{name}@{domain}" for name, domain in mails))

