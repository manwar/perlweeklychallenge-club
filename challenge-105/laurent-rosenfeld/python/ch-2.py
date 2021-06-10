import sys
input = sys.argv[1] if len(sys.argv) > 1 else "Katie"
start = input[0]
suffix = input[1:]
vowels = { "A", "E", "I", "O", "U"}

bosuffix = f'bo-{suffix}' if (start == 'B' or start in vowels) else f'bo-b{suffix}'
fosuffix = f'fo-{suffix}' if (start == 'F' or start in vowels) else f'fo-f{suffix}'
mosuffix = f'mo-{suffix}' if (start == 'M' or start in vowels) else f'mo-m{suffix}'

print(f'{input}, {input}, {bosuffix}')
print(f'Bonana-fanna {fosuffix}')
print(f'Fee fi {mosuffix}')
print(f'{input}!')
