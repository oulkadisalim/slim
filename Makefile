#Makefile cree par BRAHIMI ALI
#Octobre 2018

#definition des commandes
CC = gcc
RM = rm -f 
TAR = tar
MKDIR = mkdir
CHMOD = chmod
CP = rsync -R

#options du compilateur
CFLAGS = -I/opt/local/include -Wall -Werror
LDFLAGS = -L/opt/local/lib -lpng -lm

#fichiers et dossiers
PROGNAME = fifth
SRC = $(wildcard *.c)
HEADERS= readwritepng.h
OBJS = $(SRC:.c=.o)

PACKAGE=$(PROGNAME)
VERSION = 0.1
distdir = $(PACKAGE)-$(VERSION)
DISTFILES = $(SRC) Makefile $(HEADERS) 

DOXYFILE = documentation/Doxyfile

all: $(PROGNAME)

$(PROGNAME): $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	$(RM) $(PROGNAME) $(OBJS) *~ $(distdir).tgz


dist: distdir
	$(CHMOD) -R a+r $(distdir)
	$(TAR) zcvf $(distdir).tgz $(distdir)
	$(RM) -r $(distdir)

distdir: $(DISTFILES)
	$(RM) -r $(distdir)
	$(MKDIR) $(distdir)
	$(CHMOD) 777 $(distdir)
	$(CP) $(DISTFILES) $(distdir)

doc: $(DOXYFILE)
	cd documentation && doxygen && cd ..
