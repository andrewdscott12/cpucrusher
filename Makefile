PROGRAM = cpucrusher
INSTALL_DIR = /usr/local/bin

all: $(PROGRAM)

$(PROGRAM): cpucrusher.c
	gcc -O3 -o $(PROGRAM) cpucrusher.c -Wl,-bstatic -lm -lpthread -Wl,-bdynamic

install: $(PROGRAM)
	mkdir -p $(DESTDIR)$(INSTALL_DIR)
	cp $(PROGRAM) $(DESTDIR)$(INSTALL_DIR)/$(PROGRAM)
	chmod 0755 $(DESTDIR)$(INSTALL_DIR)/$(PROGRAM)

uninstall:
	rm -f $(INSTALL_DIR)/$(PROGRAM)

clean:
	rm -f $(PROGRAM)
