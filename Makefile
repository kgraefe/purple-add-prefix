PLUGIN=purple-add-prefix
VERSION=1.1

-include local.mak

CC=gcc

CFLAGS+=-DPLUGIN_VERSION='"$(VERSION)"'
CFLAGS+=-DPLUGIN_STATIC_NAME='"$(PLUGIN)"'

ifeq ($(ADD_PREFIX),)
$(error ADD_PREFIX is not defined!)
else
CFLAGS+=-DADD_PREFIX='"$(ADD_PREFIX)"'
endif

CFLAGS+=-Wall -Werror-implicit-function-declaration
CFLAGS+=-Wno-deprecated-declarations
CFLAGS+=-Wno-\#pragma-messages
CFLAGS+=$(shell pkg-config purple --cflags)

LDFLAGS+=$(shell pkg-config purple --libs)

PLUGIN_DIR=$(shell pkg-config purple --variable=plugindir)

all: $(PLUGIN).so

$(PLUGIN).so: plugin.c
	$(CC) -fPIC $(CFLAGS) -shared -o $@ $+ $(LDFLAGS)

install: $(PLUGIN).so
	cp $(PLUGIN).so $(PLUGIN_DIR)

uninstall:
	rm -f $(PLUGIN_DIR)/$(PLUGIN).so

dist: $(PLUGIN)-$(VERSION).tar.gz

$(PLUGIN)-$(VERSION).tar.gz: COPYING README.md CHANGES.md Makefile plugin.c
	tar -c -s '#^#$(PLUGIN)-$(VERSION)/#' -z -f $@ $+

clean:
	rm -f $(PLUGIN).so $(PLUGIN)-*.tar.gz

.PHONY: all install uninstall clean dist
