#-----------------------------------------------------------------------------
# Choose a compiler & its options
#--------------------------------------------------------------------------

CC   = gcc
OPTS = -std=c99 -MMD -W -O3

#--------------------------------------------------------------------
# Put all together
#--------------------------------------------------------------------
SRCS= HelloWorldMain.c
SUBDIRS = . 
INCLUDE = $(addprefix -I,$(SUBDIRS))
OBJS=${SRCS:.c=.o}
LIB = HelloWorldLib.c
CFLAGS   = $(OPTS) $(INCLUDE)
TARGET = HelloWorldMain

all: $(TARGET)

#--------------------------------------------------------------------	
objs: ${OBJS}
#--------------------------------------------------------------------

HelloWorldMain: objs 
	${CC} ${CFLAGS} -o $@ HelloWorldMain.o $(LIB)

#$(TARGET): objs 
	#${CC} ${CFLAGS} -o $@ $(OBJS) $(LIB)

clean:
	rm -f *.o $(OBJS)
cleanall:
	rm -f *.o *.d $(TARGET) Dependencies

#--------------------------------------------------------------------
.SUFFIXES: .c

.c.o:
	${CC} ${CFLAGS} -c $< -o $@
	cat $*.d >> Dependencies
	rm -f $*.d 

Dependencies:
	touch Dependencies

include Dependencies
