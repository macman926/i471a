import fileinput
import csv
import json
import sys
import re

#Should each line be read one at a time where I return the json pair for each line? or is it put in as one line
def readFile():
	words = sys.stdin.read().splitlines()
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
			sym_expr = re.compile("[A-Za-z_]\w*")
			next_space_expr = re.compile("\s")
			next_space_match = next_space_expr.search(l, match.end(0))
			if(next_space_match is not None):
				sym_match = sym_expr.search(l, match.end(0), next_space_match.end(0))
				sr = l[sym_match.start(0) : sym_match.end(0)]
				if sym_match and (sr != " "):
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
			sym_expr = re.compile("\D\w*")
			next_space_expr = re.compile("\s")
			next_space_match = next_space_expr.search(l, match.end(0))
			if(next_space_match is not None):
				sym_match = sym_expr.search(l, match.end(0), next_space_match.end(0))
				sr = l[sym_match.start(0) : sym_match.end(0)]
				if sym_match and (sr != " "):
					result = ["SYM", (l[sym_match.start(0): sym_match.end(0)])]
					pairs.append(result)
			continue
		expr = re.compile("^(\s*#elif)\s*")
		match = re.match(expr, l)
		if match:
			last = "directive"
			result = ["ELIF", "#elif"]
			pairs.append(result)
			sym_expr = re.compile("\D\w*")
			next_space_expr = re.compile("\s")
			next_space_match = next_space_expr.search(l, match.end(0))
			if(next_space_match is not None):
				sym_match = sym_expr.search(l, match.end(0), next_space_match.end(0))
				sr = l[sym_match.start(0) : sym_match.end(0)]
				print (sr)
				if sym_match and (sr != " "):
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
				print (lasttext)
				append_string = ["TEXT", lasttext + " " + l + "\n"]
				#print(append_string)
				pairs.append(append_string)
				continue
			text = l+"\n"
			result = ["TEXT", text]
			pairs.append(result)
			last = "text"
	return pairs
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
