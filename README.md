# Purple Add Prefix

This plugin adds an additional prefix to the plugin search path of libpurple
clients like Pidgin and finch. This works around a problem with Pidgin in
[Homebrew][1] where Pidgin cannot find plugins from other packages.

Homebrew installs all packages in separate prefixes (cellar) and symlinks them
together into a global prefix. This plugin adds the global prefix to the plugin
search path. This is done at plugin enumeration so it may not (and can not) be
loaded.

## Building on macOS
For building on macOS [Homebrew][1] must be installed on the system. To build
the plugin you need to extract a relase tarball and compile it from source:

1. Install runtime and build dependencies:

    ```
    brew install pidgin pkg-config
    ```

2. Compile for use with Homebrew:

    ```
    make ADD_PREFIX=/usr/local
    ```

3. Install into home directory:

    ```
    mkdir -p ~/.purple/plugins
    cp addprefix.so ~/.purple/plugins/
    ```

[1]: https://brew.sh
