.PHONY: all clean install uninstall

PROGRAM = cpucrusher
INSTALL_DIR = $(DESTDIR)/usr/local/bin
PREFIX ?= /usr/local

all: $(PROGRAM)

$(PROGRAM): cpucrusher.c
	gcc -O3 -o $(PROGRAM) cpucrusher.c -lm -lpthread

install: $(PROGRAM)
	install -D -m 0755 $(PROGRAM) $(DESTDIR)$(INSTALL_DIR)/$(PROGRAM)

uninstall:
	rm -f $(INSTALL_DIR)/$(PROGRAM)

clean:
	rm -f $(PROGRAM)
