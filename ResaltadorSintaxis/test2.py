# Esta es la prueba que va a pasar por el expresiones regulares
import math

# Print "Hello World"
Greetings = "Hola mundo"
print(Greetings)

# print the numbers from 1 to 10
for i in range(10):
    print(i)

# Create a binary tree, with insert and search methods
class Tree:
    def __init__(self, value):
        self.left = None
        self.right = None
        self.value = value

    def insert(self, value):
        if value < self.value:
            if self.left is None:
                self.left = Tree(value)
            else:
                self.left.insert(value)
        else:
            if self.right is None:
                self.right = Tree(value)
            else:
                self.right.insert(value)

    def search(self, value):
        if value < self.value:
            if self.left is None:
                return str(value) + " Not Found"
            return self.left.search(value)
        elif value > self.value:
            if self.right is None:
                return str(value) + " Not Found"
            return self.right.search(value)
        else:
            return str(self.value) + ' is found'
        
    def print_tree(self):
        if self.left:
            self.left.print_tree()
        print( self.value),
        if self.right:
            self.right.print_tree()

# Create a basic calculator class
class Calculator:
    def __init__(self):
        pass

    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b
    
    def multiply(self, a, b):
        return a * b
    
    def divide(self, a, b):
        return a / b
    
    def power(self, a, b):
        return math.pow(a, b)
    
    def square_root(self, a):
        return math.sqrt(a)
    
    def toFloat(self, a):
        return a / 1.0