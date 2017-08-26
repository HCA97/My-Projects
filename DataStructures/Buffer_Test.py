from Buffer import *

""" Testing Functions """
print("Testing Functions")
b = Buffer(10)
it = b.iterator()
print("b = Buffer(10)\nit = b.iterator()")
print("--"*10)
for i in range(10):
    print("b.enqueue(",i,")")
    b.enqueue(i)
print("--"*10)
print("Printing Buffer via iterator")
while it.hasNext():
    print(it.Next(), end = " ")
print()
print("--"*10)
for i in range(3):
    print("b.dequeue(",i,")")
    b.dequeue()
print("--"*10)
print("Printing Buffer via iterator")
it.init()
while it.hasNext():
    print(it.Next(), end = " ")
print("\n")
""" Testing Exceptions """

print("Testing Exceptions")
try:
    for i in range(100):
        print("b.dequeue(",i,")")
        b.dequeue()
except Exception as e:
    print(e)
print("--"*10)
try:
    for i in range(100):
        print("b.enqueue(",i,")")
        b.enqueue(i)
except Exception as e:
    print(e)
