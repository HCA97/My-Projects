from Player_Class import *


class Game:
    def __init__(self, p1, p2): # takes two player objects
        self.player1 = p1
        self.player2 = p2
        self.board = Board() #creates an empty board


    def run(self):
        play = True
        print(self.board)
        while not self.board.isOver(): #loop until game is over
    
            if play and not self.board.isFull():
                (row, col) = self.player1.getMove(self.board)
                self.board.makeMove(row,col)
                play = not play
                print(self.player1.getName(), " played")
                print(self.board)
                if self.board.getResult() is 1:
                    print(self.player1.getName() , "win!")
                    return 

            if not play and not self.board.isFull(): #do nothing if the boards is full
                (row, col) = self.player2.getMove(self.board)
                self.board.makeMove(row,col)
                play = not play
                print(self.player2.getName(), " played")
                print(self.board)
                if self.board.getResult() is 2:
                    print(self.player2.getName() , "win!")
                    return
            
        print("Tie!")

    def resart(self):
        self.board.reset() #initilize the board


a = Human("Human")
b = SmartPlayer("Smart")
g = Game(a,b)
g.run()
