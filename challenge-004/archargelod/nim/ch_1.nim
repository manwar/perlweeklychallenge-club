#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import streams, base64

const EncodedPi =
  "1kkyot8tmStpvZgcD2U0QFHnH/9jgdmGDp2GooG4nkTt/Jjhch8BHUDG8PDuw68XDorLik/bAiAEaBq2sQbNUPFh7x4gtZJwZFA5GFwMQXZtvC3GOvGFhMzPe7GO8AFpoUzfbnRJRHKrZzxPgVcrfluOBesQ53VDfORzohWQDzIUZ3vG+6l2UWGZNueRDCJxGK+Z4M0yzhd5o8o0k4qSAfjIheHVLK0dZygR4pvz6IK+N0WN76JEhJZp/YqpwF0QTbyf2oJTByFGp1swASl2aDTBHAcHL5UQAoKFXmjdHAnmO/16CzTZNrV5f0V6jZNUAoyi4unaVVcxhBwkdvTmQNHhv7NW76slhSILbRhvohIZoI9RSXbNGJGJgiqFMyZKFvYIAS6+/gpYcHtRyPvEAiGPc51nmN1YCygALiEZN0ITJxYAcX+SMJ/XH2qMD9xG3DihHTWpR3dG4h2ptAUAKk2rE98EmAJ2O286BNklCwCAal56+l3/SbK5/16gDvZfb0rOKmysgXnZ53X18oBzenj5MfDEuZlxewwPWjcaxltmkYWx0wAAAA=="

proc main() =
  let piData = newStringStream EncodedPi.decode()
  defer:
    piData.close()

  while not piData.atEnd:
    stdout.write piData.readUint64

when isMainModule:
  main()

# junk junk junk junk junk junk junkjunk junk junkjunk junk junk junk junk junk junk junk junk junk junk junk junk junk junk junk junk junk junk junk junk
