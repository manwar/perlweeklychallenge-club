TESTS=[[15,240],[165,90]]

def swap_nibbles(_):
  return (_>>4)|((_&15)<<4)

for t in TESTS:
  print( 'OK' if swap_nibbles(t[0])==t[1] else 'Not OK' )

for t in TESTS:
  print( 'OK' if swap_nibbles(t[1])==t[0] else 'Not OK' )

