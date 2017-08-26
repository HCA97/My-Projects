from Immutable_List import *

""" Testing Functions """
print("Testing Functions")
print("--"*10)
c = Cons(2,Cons(3,Cons(4,Cons(0, Nil()))))
print("c = Cons(2,Cons(3,Cons(4,Cons(0, Nil()))))")
print("Adress of c", c)
print("--"*10)

n = Nil()
print("n = Nil()")
print("Address of n", n)
print("--"*10)

print("Calling iterator()")
iter_n = n.iterator()
print("Printing Nil() via iterator", end = " =")
while iter_n.hasNext():
    print(iter_n.Next(), end = " ")
print()
print("--"*10)

iter_c = c.iterator()
print("Printing c via iterator", end = " = ")
while iter_c.hasNext():
    print(iter_c.Next(), end = " ")
print()
print("--"*10)

print("Printing c via print()", end = " ")
c.print()
print("--"*10)

print("c.emptyList() = ", c.emptyList())
print("n.emptyList() = ", n.emptyList())
print("--"*10)


print("Printing c.reverse(Nil())", end = " ")
c.reverse(Nil()).print()
print("--"*10)

print("c.getEl(2) =",c.getEl(2))
print("--"*10)

print("n.getEl(1) =",n.getEl(1), "| n.getEl(10) =", n.getEl(10))
print("--"*10)


print("c.getHead() =", c.getHead())
print("c.getTail() =", c.getTail())
print("c.getTail().print() = ", c.getTail().print())
print("--"*10)


print("n.getHead() =", n.getHead())
print("n.getTail() = ", n.getTail())
print("--"*10)

print("c.deleteFirst()")
c.deletFirst()
print("Printing new c via iterator", end =" = ")
iter_c.init()
while iter_c.hasNext():
    print(iter_c.Next(), end = " ")
print()
print("--"*10)

print("Adding new element to c")
print("c = Cons(12,c)")
c = Cons(12,c)
print("Printing c via iterator",end =" = ")
iter_c = c.iterator()
while iter_c.hasNext():
    print(iter_c.Next(), end = " ")
print()
print("--"*10)


""" Testing Exceptions """

print("\nTesting Exceptions")
print("--"*10)
c = Cons(2,Cons(3,Cons(4,Cons(0, Nil()))))
n = Nil()
print("c = Cons(2,Cons(3,Cons(4,Cons(0, Nil()))))")
c.print()
print("n = Nil()")
try:
    print("n.deletFirst()")
    n.deletFirst()
except Exception as e:
    print(e)
print("--"*10)
try:
    print("c.getEl(-1)")
    c.getEl(-1)
except Exception as e:
    print(e)
print("--"*10)
try:
    print("c.deletFirst()", c.deletFirst())
    print("c.deletFirst()", c.deletFirst())
    print("c.deletFirst()", c.deletFirst())
    print("c.deletFirst()", c.deletFirst())
    print("c.deletFirst()", c.deletFirst())
    print("c.deletFirst()", c.deletFirst())
    print("c.deletFirst()", c.deletFirst())
except Exception as e:
    print(e)
print("--"*10)
try:
    print("c.getEl(100)")
    c.getEl(100)
except Exception as e:
    print(e)

