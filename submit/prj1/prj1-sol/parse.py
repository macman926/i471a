import sys
import json
#import StringIO
from scan import *

class AST:
	tag = ""
	sym = ""
	xkids = []
	def __init__(self, t, s):
		self.tag = t
		self.sym = s
class txtAST:
	tag = ""
	text = ""
	def __init__(self, t1,t2):
		self.tag = t1
		self.text = t2

def getKids(ast, curr, tokens):
	if(curr == len(tokens)):
		return curr
	if(tokens[curr][0] == "ELIF"):
		ea = AST(tokens[curr][0], tokens[curr][1]) 
		ast.xkids.append(ea)
		curr = curr + 1
		return getKids(ast, curr, tokens)
	if(tokens[curr][0] == "ELSE"):
		ela = AST(tokens[curr][0], tokens[curr][1])
		ast.xkids.append(ela)
		curr = curr + 1
		return getKids(ast, curr, tokens)
	if(tokens[curr][0] == "IFDEF"):
		ifa = AST(tokens[curr][0], tokens[curr][l])
		ast.xkids.append(ifa)
		curr = curr + 1
		curr = getKids(ast, curr, tokens)
	everythingelse = AST(tokens[curr][0], tokens[curr][1])
	ast.xkids.append(everythingelse)
	curr = curr + 1
	return getKids(ast, curr, tokens)
def parse(tokens):
	ASTs = []
	i = 0
	while i < len(tokens):
		if(tokens[i][0] == "TEXT"):
			ta = ["TEXT", tokens[i][1]]
			ASTs.append(ta)
			i = i + 1
			continue
		if(tokens[i][0] == "IFDEF"):
			ast = AST(tokens[i][0], tokens[i][1])
			nextToken = getKids(ast, i+1, tokens)
			ASTs.append(ast)
			i = nextToken
	return  ASTs
def pjsonify(parsed):
	j = []
	for i in  parsed:
		if(type(i) is AST):
			j.append(AST.__dict__['__dict__'])
		if(type(i) is txtAST):
			j.append(txtAST.__dict__['__dict__'])
	ret = json.dumps(j)
	return j
def main():
	words = readFile()
	lexeme = lexer2(words)
	parsed = parse(lexeme)
	j = pjsonify(parsed)
	output(j)
if __name__ == "__main__":
	main() 
