x = "there are %d types of people." % 10
binary = "binary"
do_not = "don't"
y = "those who know %s and those who %s." % (binary,do_not)

print x
print y

print "i said: %r" % x
print "i also said: '%s'." % y

hilarious = False
joke_evaluation = "isnt that joke so funny?! %r"

print joke_evaluation % hilarious

w = "thi sis the left side of..."
e = "a string with a right side"

print w+e
