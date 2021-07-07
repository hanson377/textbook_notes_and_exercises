from sys import argv

script, filename = argv

print "we are going to erase %r." % filename ## takes argument passed on command line
print "if you dont want that, hit CTRL-C"
print "if you do want that, hit RETURN"

raw_input("?") ## simply a prompt to perform one of the actions above

print "opening the file..."
target = open(filename,'w') ## opens the file from above

print "truncating the file. goodbye!" ## erases content from within
target.truncate()

print "now im going to ask you for three lines"

line1 = raw_input("line 1: ") ## prompt to put something in here
line2 = raw_input("line 2: ")
line3 = raw_input("line 3: ")

print "im going to write these to the file."

target.write(line1) ## writes our prompt for line 1
target.write("\n") ## returns a space
target.write(line2)
target.write("\n")
target.write(line3)
target.write("\n")

print "and finally, we close it."
target.close()
