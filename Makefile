PROGRAM = cpucrusher
INSTALL_DIR = /usr/local/bin

all: $(PROGRAM)

$(PROGRAM): cpucrusher.c
	gcc -O3 -o $(PROGRAM) cpucrusher.c -lm -lpthread

install: $(PROGRAM)
	mkdir -p $(DESTDIR)$(INSTALL_DIR)
	install -m 0755 $(PROGRAM) $(DESTDIR)$(INSTALL_DIR)/$(PROGRAM)

uninstall:
	rm -f $(INSTALL_DIR)/$(PROGRAM)

clean:
	rm -f $(PROGRAM)
