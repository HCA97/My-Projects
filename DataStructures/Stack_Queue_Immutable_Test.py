from Stack_Queue_Immutable import *

print("Stack Test")

s = IL_Stack()
print("s = IL_Stack()")
for i in range(10):
    print("s.push(",i,")")
    s.push(i)
print("--"*10)
print("s.push(10) = ", s.push(10))
print("--"*10)
print("Printing stack via iterator")
it = s.iterator()
while it.hasNext():
    print(it.Next(), end = " ")
print()
print("--"*10)
it.init()
print("Popping elements")
for i in range(5):
    x = s.pop()
    print("s.pop()= ", x,"\ns.pop().getEl() =", x.getEl())
print("--"*10)
for i in range(10,13):
    print("s.push(",i,")")
    s.push(i)
print("--"*10)   
print("Printing new stack via iterator")    
while it.hasNext():
    print(it.Next(), end = " ")
print()
print("\nStack Exceptions")
try: 
    for i in range(100):
        print("s.pop()")
        s.pop()
except Exception as e:
    print(e)

print("\nQueue Test")
q = IL_Queue()
print("q = IL_Queue()")
for i in range(10):
    print("q.enqueue(",i,")")
    q.enqueue(i)
print("--"*10) 
print("q.enqueue(10) =",q.enqueue(10))
print("--"*10) 
print("q.print()")
q.print()
print("--"*10) 
print("Deleting elements")
for i in range(5):
    x = q.dequeue()
    print("q.dequeue()= ", x,"\nq.dequeue().getEl() =", x.getEl())
print("--"*10) 
print("Printing the new queue")
q.print()
print("\nQueue Exception")
try: 
    for i in range(100):
        print("q.dequeue()")
        q.dequeue()
except Exception as e:
    print(e)
