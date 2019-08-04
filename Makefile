PLUGIN=addprefix
VERSION=1.0

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

clean:
	rm -f $(PLUGIN).so

.PHONY: all install uninstall clean