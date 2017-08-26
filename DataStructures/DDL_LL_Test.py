from DDL_LL import *


List = LinkedList()
print("List = LinkedList()")
for i in range(10):
    List.insert(i)
    print("List.insert(",i,")")
    List.insert(i)
    print("List.insert(",i,")")
    
print("--"*10)
print("List.print()")
List.print()
print("--"*10)

print("Printing Linked List reversed")
print("List.reverse()")
print("List.print()")
List.reverse()
List.print()
print("--"*10)
print("N = Node(100, List.getHead())")
print("List.setHead(N)")
N = Node(100, List.getHead())
List.setHead(N)
print("--"*10)
print("List.getHead() =",List.getHead())
print("--"*10)
print("List.getData() =", List.getData())
print("--"*10)
for i in range(21):
    print("List.delete(",i,") =",List.delete(i))
print("--"*10)
print("List.delete(123) =",List.delete(123))
print()
print("Double Linked List Test")
print("d_List = DoubleLinkedList()")
dList = DoubleLinkedList()
for i in range(10):
    print("dList.insert(",i,")")
    dList.insert(i)
print("--"*10)
print("dList.print()")
dList.print()

print("--"*10)
itdl = dList.iterator()
print("Printing Double Linked List with Iterator")

print("printing first 5 elements of the DLL with iterator")
for i in range(5):
    print(itdl.Next(), end = " ")
print()
print("--"*10)
print("Printing Double Linked List backwards with Iterator")
while itdl.hasPrev():
    print(itdl.Prev(), end = " ")
print()
print("--"*10)
itdl.init()
print("Printing Double Linked List forward with Iterator")
while itdl.hasNext():
    print(itdl.Next(), end = " ")
print()       
