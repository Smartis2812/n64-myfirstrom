N64KITDIR   = c:/nintendo/n64kit

TARGET  	= myfirstrom
CODEFILES   = main.c graphic.c stage00.c

include $(ROOT)/usr/include/make/PRdefs

DEBUGSYM	= -g
OPTIMIZER   = -O0

NUSYSDIR	= $(N64KITDIR)/nusys
NUSYSINC	= $(NUSYSDIR)/include
NUSYSLIB	= $(NUSYSDIR)/lib

NUOBJ   	= $(NUSYSLIB)/nusys.o
CODEOBJECTS = $(CODEFILES:.c=.o) $(NUOBJ)

CUSTFLAGS   =
LCINCS  	= -I$(NUSYSINC)
LCOPTS  	= -G 0 $(DEBUGSYM) $(CUSTFLAGS)
LDFLAGS 	= -L$(ROOT)/usr/lib -L$(ROOT)/usr/lib/PR -L$(NUSYSLIB) \
              -lnusys_d -lgultra_d -L$(GCCDIR)/mipse/lib -lkmc

CODESEGMENT = codesegment.o
OBJECTS 	= $(CODESEGMENT)

SYMBOL  = $(TARGET).out
ROM 	= $(TARGET).n64

default:$(ROM)

$(CODESEGMENT): $(CODEOBJECTS)
    	$(LD) -o $(CODESEGMENT) -r $(CODEOBJECTS) $(LDFLAGS)

$(ROM) :  $(OBJECTS)
    	$(MAKEROM) spec -I$(NUSYSINC) -r $(ROM) -e $(SYMBOL)

include $(ROOT)/usr/include/make/commonrules
