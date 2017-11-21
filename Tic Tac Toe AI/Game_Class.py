from Player_Class import *


class Game:
    def __init__(self, p1, p2): # takes two player objects
        self.players = {1 : p1, 2: p2}
        self.board = Board() #creates an empty board
    def run(self):
        print(self.board)
        while not self.board.isOver(): #loop until game is over
            player = self.players[self.board.curr_player]
            row, col = player.getMove(self.board)
            self.board.makeMove(row,col)
            print(player.getName(), " played")
            print(self.board)
            if self.board.isWin(self.board.curr_player):
                print(player.getName(), " win!")
                return
        print("Tie!")

    def resart(self):
        self.board.reset() #initilize the board


a = Human("Human")
b = SmartPlayer("Smart")
g = Game(a,b)
g.run()
