#!/usr/bin/python

from string import ascii_letters

def mygen():
    chars = list(ascii_letters)
    chars.extend([' ', '.', ',', '!'])
    chars.sort()

    for i in range(0, len(chars)):
        char = chars[i]
        for j in chars[i:]:
            yield (char, j, chr(ord(char) ^ ord(j)))


for i in mygen():
    print(i)

