from sys import argv ## brings in package, asks for parameter fed through by user

script, filename = argv ## assigning argv to filename

txt = open(filename) ## open filename

print "here is your file %r:" % filename
print txt.read() ## read the text file

print "type the filename again:"
file_again = raw_input("> ") ## ask user to type in filename again

txt_again = open(file_again) ## take filename typed and assigned the open function to it

print txt_again.read() ## call open function, read text file 
