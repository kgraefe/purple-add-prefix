# Purple Add Prefix

This plugin adds an additional prefix to the plugin search path of libpurple
clients like Pidgin and finch. This works around a problem with Pidgin in
[Homebrew][1] where Pidgin cannot find plugins from other packages.

Homebrew installs all packages in separate prefixes (cellar) and symlinks them
together into a global prefix. This plugin adds the global prefix to the plugin
search path. This is done at plugin enumeration so it may not (and can not) be
loaded.

[1]: https://brew.sh
