import fileinput
import csv
import json

def readFile():
	words = []
	for line in fileinput.input():
		words.append(line.rstrip())
	return words
def printFile(words):
	c = 0
	for w in words:
		print(str(c) + " " + w)
		c+= 1
class pair:
	first = ""
	second = ""
	def __init__(self,first,second):
		self.first = first
		self.second = second
def lexer(language):
	pairs = []
	last = "none"
	for l in language:
		#Is directive line
		if(l.find("#ifndef") != -1):
			result = ["IFNDEF", l[(l.find("#ifndef")):]]
			pairs.append(result)
			last = "directive"
			continue
		if(l.find("#else") != -1):
			result = ["ELSE", l[(l.find("#else")):]]
			pairs.append(result)
			last = "directive"
			continue

		if(l.find("#ifdef") != -1):
			result = ["IFDEF", l[(l.find("#ifdef")):]]
			pairs.append(result)
			last = "directive"
			continue

		if(l.find("#elif") != -1):
			result = ["ELIF", l[(l.find("#elif")):]]
			pairs.append(result)
			last = "directive"
			continue

		if(l.find("#endif") != -1):
			result = ["ENDIF", l[(l.find("#endif")):]]
			pairs.append(result)
			last = "directive"
			continue
		#Is text
		if(l != " " or l != "\t" or l != "\n"):
			result = ["TEXT", l]
			if(last == "text"):
				concatenated = pairs[-1][1]
				concateneated = concatenated + l
				pairs[-1][1] = concatenated
				last = "text"
				continue
			else:
				pairs.append(result)
				last = "text"
				continue
		#Is linear whitespace
		if(l == " " or l == "\n"):
			continue
	return pairs

def jsonify(lexeme):
	jsoned = json.dumps(lexeme)
	return jsoned
def main():
	words = readFile()
	#printFile(words)
	lexeme = lexer(words)
	print(jsonify(lexeme))
	#printLexeme(lexeme)

if __name__ == "__main__":
		main()
