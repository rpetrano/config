#!/usr/bin/env python

from http.client import HTTPConnection
from abc import ABCMeta, abstractmethod
from urllib.parse import urlencode
from binascii import hexlify

class Server(metaclass=ABCMeta):
	""" Returns true if server responded with padding error, false otherwise """
	@abstractmethod
	def send(ct):
		pass

class Oracle:
	def __init__(self, server, blocksize):
		self.server = server
		self.blocksize = blocksize // 8

	def crack(self, ct):
		blocks = len(ct) // self.blocksize
		msg = [ 0 ] * len(ct)
		for block in range(blocks - 1, 0, -1):
			for pad in range(1, self.blocksize + 1):
				for j in range(0, 255):
					pos = block * self.blocksize - pad
					ct2 = list(ct)
					for i in range(0, pad):
						ct2[pos + i] ^= j ^ pad
					if self.server.send(bytes(ct2)):
						msg[pos] = j
						print(msg)
						break

		return bytes(msg)


class CourseraServer(Server):
	SERVER = 'crypto-class.appspot.com'
	PATH = '/po'

	def __init__(self):
		self.connection = HTTPConnection(self.SERVER) 

	def __del__(self):
		self.connection.close()
	
	def uri(self, ct):
		ct_hex = hexlify(ct)
		return self.PATH + '?' + urlencode({'er': ct_hex})

	def send(self, ct):
		uri = self.uri(ct)
		self.connection.request('GET', uri)
		response = self.connection.getresponse()
		response.close()
		print(response.status)
		return response.status == 403





ct = bytes.fromhex('f20bdba6ff29eed7b046d1df9fb7000058b1ffb4210a580f748b4ac714c001bd4a61044426fb515dad3f21f18aa577c0bdf302936266926ff37dbf7035d5eeb4')

server = CourseraServer()
server.send(ct)
oracle = Oracle(server, 128)
msg = oracle.crack(ct)

print(hexlify(msg))
