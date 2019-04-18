ch-1.pl generates 289 pi digits. Digits are preloaded compressed in an ad-hoc form: every 3 digits (000 to 999)
from pi decimals are compressed into a sort of base64 two-character token. The idea was to avoid the use of
external modules (like arbitrary precision math modules or even Base64 modules) in the challenge.