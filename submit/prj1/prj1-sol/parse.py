import sys
import json
#import StringIO
from scan import *

def parse(tokens):
	
	for t in tokens:
		tag = t[
def main():
	words = readFile()
	lexeme = lexer2(words)
	parse(lexeme)
	#j = jsonify(lexeme)
	#output(j)
if __name__ == "__main__":
	main() 
