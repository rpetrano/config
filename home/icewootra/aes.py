#!/usr/bin/env python

from Crypto.Cipher import AES
from abc import ABCMeta, abstractmethod
from math import ceil
from sys import stdin

class MyAes(metaclass=ABCMeta):
    blocksize = 16

    def __init__(self, key, iv):
        self.cipher = AES.new(key, AES.MODE_ECB)
        self.iv = iv

    @abstractmethod
    def encrypt(self, plaintext):
        pass

    @abstractmethod
    def decrypt(self, cyphertext):
        pass

class AesCBC(MyAes):
    def pkcs5pad(self, data):
        pad = ceil(len(data) / self.blocksize) * self.blocksize - len(data)
        if (pad == 0):
            pad = blocksize
        data += pad.to_bytes(1, 'big') * pad
        return data

    def pkcs5unpad(self, data):
        pad = data[-1]
        data = data[:-pad]
        return data

    def encrypt(self, plaintext):
        plaintext = self.pkcs5pad(plaintext)

        prev = self.iv
        c = bytes()
        while(len(plaintext) > 0):
            xor = bytes([ prev[i] ^ plaintext[i] for i in range(0, self.blocksize) ])
            prev = self.cipher.encrypt(xor)
            c += prev
            plaintext = plaintext[self.blocksize:]
        return c

    def decrypt(self, cyphertext):
        prev = self.iv
        m = bytes()
        while(len(cyphertext) > 0):
            ct = cyphertext[:self.blocksize]
            msg = self.cipher.decrypt(ct)
            m += bytes([ prev[i] ^ msg[i] for i in range(0, self.blocksize) ])
            prev = ct
            cyphertext = cyphertext[self.blocksize:]

        return self.pkcs5unpad(m)

class AesCTR(MyAes):
    class IV:
        blocksize = 16
        size = blocksize // 2

        def __init__(self, nonce, counter = 0):
            self.nonce = nonce
            self.counter = counter

        @classmethod
        def from_bytes(cls, b):
            nonce = b[:cls.size]
            counter = int.from_bytes(b[cls.size:], 'big')
            return cls(nonce, counter)

        def to_bytes(self):
            counter = self.counter.to_bytes(self.size, 'big')
            return self.nonce + counter

    def __init__(self, key, iv):
        super().__init__(key, iv)
        self.iv = self.IV.from_bytes(iv)

    def encrypt(self, plaintext):
        c = bytes()
        #self.iv.counter = 0
        while(len(plaintext) > 0):
            ct = self.cipher.encrypt(self.iv.to_bytes())
            c += bytes([ ct[i] ^ plaintext[i] for i in range(0, min(self.blocksize, len(plaintext))) ])

            self.iv.counter += 1
            plaintext = plaintext[self.blocksize:]

        return c

    def decrypt(self, cyphertext):
        return self.encrypt(cyphertext)

        
while True:
    cipher = stdin.readline().rstrip().lower()
    key = bytes.fromhex(stdin.readline().rstrip())
    ct = bytes.fromhex(stdin.readline().rstrip())

    iv = ct[:16]
    ct = ct[16:]

    if cipher.lower() == 'cbc':
        cipher = AesCBC(key, iv)
    elif cipher.lower() == 'ctr':
        cipher = AesCTR(key, iv)
    else:
        print('ASDKAJSD')
        continue

    print(cipher.decrypt(ct))


