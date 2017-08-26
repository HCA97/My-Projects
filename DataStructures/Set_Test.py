from Set import *

print("List Set Test")
print("s = ListSet()")
s = ListSet()
for i in range(10):
    print("s.insert(",i,")")
    s.insert(i)
    print("s.insert(",i,")")
    s.insert(i)
print("--"*10)
it = s.iterator()
print("Printing set via iterator")
while it.hasNext():
     print(it.Next(), end = " ")
print()
print("--"*10)
for i in range(3):
    print("s.delete(",i,") =",s.delete(i))
print("--"*10)
print("s.delete(",10,")")
s.delete(10)
print("Printing new set via Iterator")
print("Initializing the Iterator")
it.init()
while it.hasNext():
     print(it.Next(), end = " ")
print()
print("\nBit Vector Test")
print("v = BitVector(10)")
v = BitVector(10)
for i in range(10):
    print("v.insert(",i,")")
    v.insert(i)
print("v.insert(",1,")")
v.insert(1)
print("--"*10)
print("Printing BitVector via iterator")
it = v.iterator()
while it.hasNext():
    print(it.Next(), end = " ")
print()
print("--"*10)
for i in range(5):
    print("v.delete(",i,")")
    v.delete(i)
print("--"*10)
print("Printing new BitVector via iterator")
print("Inintalizing the iterator")
it.init()
while it.hasNext():
    print(it.Next(), end = " ")
print()
