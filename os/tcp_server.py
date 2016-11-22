# Echo server program
from socket import *
from time import ctime
HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 50007              # Arbitrary non-privileged port
BUFSIZE = 1024
ADDR = (HOST, PORT)
tcpServerSocket = socket(AF_INET, SOCK_STREAM)
tcpServerSocket.bind(ADDR)
tcpServerSocket.listen(5)
while True:
    print('waiting for connection...')
    tcpClientSocket, address = tcpServerSocket.accept()
    print('...connected by', address)
    while True:
        data = tcpClientSocket.recv(BUFSIZE).decode()
        print(data)
        if not data:
            break
        tcpClientSocket.send(('[%s] %s' % (ctime(), data)).encode())
    tcpClientSocket.close()
tcpServerSocket.close()
