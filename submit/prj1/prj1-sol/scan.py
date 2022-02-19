import fileinput
import csv
import json
import sys
import re

#Should each line be read one at a time where I return the json pair for each line? or is it put in as one line
def readFile():
	words = sys.stdin.readlines()
	return words
def writeFile(j, arg1):
	prefix = arg1[0:arg1.find(".")]+".scan.json"
	with open(prefix, 'w') as outfile:
		outfile.write(j)
def printFile(words):
	c = 0
	for w in words:
		print(str(c) + " " + w)
		c+= 1
def output(jsoned):
	sys.stdout.write(jsoned)
	print()
class pair:
	first = ""
	second = ""
	def __init__(self,first,second):
		self.first = first
		self.second = second
def lexer2(lang):
	last = "none"
	pairs = []
	for l in lang:
		expr = re.compile("^(\s*#ifdef\s*)")
		match = re.match(expr, l)
		if match:
			last = "directive"
			result = ["IFDEF", "#ifdef"]
			pairs.append(result)
			sym_expr = re.compile("\w*\S")
			sym_match = sym_expr.search(l, match.end(0))
			if sym_match:
				last = "sym"
				result = ["SYM", (l[sym_match.start(0): sym_match.end(0)])]
				pairs.append(result)
			continue
		expr = re.compile("^(\s*#ifndef\s*)")
		match = re.match(expr, l)
		if match:
			last = "directive"
			result = ["IFNDEF", "#ifndef"]
			pairs.append(result)
			sym_expr = re.compile("\w*\S")
			sym_match = sym_expr.search(l, match.end(0))
			if sym_match:
				result = ["SYM", (l[sym_match.start(0): sym_match.end(0)])]
				pairs.append(result)
			continue
		expr = re.compile("^(\s*#elif\s*)")
		match = re.match(expr, l)
		if match:
			last = "directive"
			result = ["ELIF", "#elif"]
			pairs.append(result)
			sym_expr = re.compile("\w*\S")
			sym_match = sym_expr.search(l, match.end(0))
			if sym_match:
				result = ["SYM", (l[sym_match.start(0): sym_match.end(0)])]
				pairs.append(result)
			continue
		expr = re.compile("^(\s*#endif\s*)")
		match = re.match(expr, l)
		if match:
			last = "directive"
			result = ["ENDIF", "#endif"]
			pairs.append(result)
			continue
		expr = re.compile("^(\s*#else\s*)")
		match = re.match(expr, l)
		if match:
			last = "directive"
			result = ["ELSE", "#else"]
			pairs.append(result)
			continue
		expr = re.compile("\s*\w*")
		match = re.match(expr, l)
		if match:
			if(last == "text"):
				lasttext = pairs.pop()[1]
				append_string = ["TEXT", lasttext + " " + l]
				pairs.append(append_string)
				continue
			result = ["TEXT", l]
			pairs.append(result)
			last = "text"
	return pairs

"""
def lexer(language):
	pairs = []
	last = "none"
	for l in language:
		#Is directive line
		#Check if directive has tab or space in front of it
		#Change if blocks to look at the start of the string instead of calling find in the string 

		#IFNDEF LINES
		if(l.find("\t#ifndef" != -1): #tab
			result = ["IFNDEF", l[(l.find("\t#ifndef")) : l.find("\t#ifndef")+7]]
			pairs.append(result)
			if(l.find("_") != -1 or l[l.find("\t#ifndef") + 8].isalpha()):
	#CONTINUE HERE
		if(l.find("#ifndef") != -1):
			result = ["IFNDEF", l[(l.find("#ifndef")) : l.find("#ifndef")+7]]
			pairs.append(result)
			#Add sym
			if(l.find("_")  != -1 or l[l.find("#ifndef") + 8].isalpha()):
				sym = ["SYM", l[(l.find("#ifndef"))+8 : l.find(" ",l.find("#ifndef ")+8)]]
				pairs.append(sym)
			last = "directive"
			continue
		#ELSE LINES
		if(l.find("#else") != -1):
			result = ["ELSE", l[(l.find("#else")):]]
			pairs.append(result)
			last = "directive"
			continue
		#IFDEF LINES
		if(l.find("#ifdef") != -1):
			result = ["IFDEF", l[(l.find("#ifdef")):l.find("ifdef")+6]]
			pairs.append(result)
			#Add sym
			if(l.find("_") != -1 or l[l.find("#ifdef") + 7].isalpha()):
				sym = ["SYM", l[(l.find("#ifdef"))+7 : l.find(" ", l.find("#ifdef ")+7)]]
				pairs.append(sym)
			last = "directive"
			continue
		#ELIF LINES
		if(l.find("#elif") != -1):
			result = ["ELIF", l[(l.find("#elif")):l.find("#elif")+5]]
			pairs.append(result)
			#Add sym
			if(l.find("_") != -1 or l[l.find("#elif")+6].isalpha()):
				sym = ["SYM", l[(l.find("#elif"))+6 : l.find(" ", l.find("#elif ")+6)]]
				pairs.append(sym)
			last = "directive"
			continue
		#ENDIF LINES
		if(l.find("#endif") != -1):
			result = ["ENDIF", l[(l.find("#endif")):]]
			pairs.append(result)
			last = "directive"
			continue
		#Text Lines
		if(l != " " or l != "\t" or l != "\n"):
			result = ["TEXT", l]
			if(last == "text"):
				concatenated = pairs[-1][1]
				#concateneated = concatenated + l
				#print(concatenated)
				pairs[-1][1] = concatenated + "\n" + " " + l + "\n"
				last = "text"
				continue
			else:
				pairs.append(result)
				last = "text"
				continue
		#Is linear whitespace
		if(l == " " or l == "\n" or l == "\t"):
			continue
	return pairs
"""
def jsonify(lexeme):
	jsoned = json.dumps(lexeme)
	return jsoned
#Is ./make.sh supposed to just run ./scan and ./parse
def main():
	words = readFile()
	#printFile(words)
	lexeme = lexer2(words)
	j = jsonify(lexeme)
	#printLexeme(lexeme)
	#print (sys.argv[1])
	#writeFile(j,sys.argv[1])
	output(j)
if __name__ == "__main__":
	main()
