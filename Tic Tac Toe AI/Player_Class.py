from random import choice
from Board_Class import * #imports the Board Class

class Player:
    def __init__(self,_name):
        self.name = _name
    def getName(self): #returns the name
        return self.name

    def getMove(self,board):
        pass

class RandomPlayer(Player):
    def getMove(self, board): #chooses random move
        return choice(board.possibleMoves())

class Human(Player):
    def getMove(self, board):
        row = int(input("Enter row(1-3) = "))
        col = int(input("Enter col(1-3) = "))
        return row-1,col-1

class SmartPlayer(Player):
    def minimax(self,board, depth, isMax):
        
        if board.getResult() is not 0: #checks is any player won
            if isMax: #player turns so opponent win
                return depth - 10
            else: #same logic as above
                return 10 - depth
        elif board.isFull():
            return 0
        
        if isMax: #player moves
            best_max = -1000
            for (i,j) in board.possibleMoves():
                #do the move
                board.makeMove(i,j)
                val = self.minimax(board,depth+1, not isMax) #store how good was the move
                #undo the move
                board.undoMove(i,j)
                depth -= 1
                if best_max < val:
                    best_max = val
            return best_max
        
        else:
            best_min = 1000
            for (i,j) in board.possibleMoves():
                #do the move
                board.makeMove(i,j)
                val = self.minimax(board, depth +1, not isMax) #store how bad was the move
                #undo the move
                board.undoMove(i,j)
                depth -= 1 
                if best_min > val:
                    best_min = val
            return best_min
        
    def getMove(self, board):
        bestVal = -1000
        l = [] #for storing the best moves
        if len(board.possibleMoves()) is 9: #if it starts first do a random move
            return choice(board.possibleMoves())
        for (i,j) in board.possibleMoves():
            board.makeMove(i,j)
            val = self.minimax(board, 0, False)
            board.undoMove(i,j)
            if val is bestVal:
                l.append((i,j))
            elif val > bestVal:
                bestVal = val
                l = [(i,j)]
##        print(bestVal,l)#prints the possible moves and bestVal
        return choice(l) 
            
            

    
