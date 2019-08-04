/* Copyright (C) 2019 Konrad Gräfe <konradgraefe@aol.com>
 *
 * This software may be modified and distributed under the terms
 * of the GPLv2 license. See the COPYING file for details.
 */

#include <purple.h>

static PurplePluginInfo info = {
	PURPLE_PLUGIN_MAGIC,
	PURPLE_MAJOR_VERSION,
	PURPLE_MINOR_VERSION,
	PURPLE_PLUGIN_STANDARD,                         /* type           */
	NULL,                                           /* ui_requirement */
	PURPLE_PLUGIN_FLAG_INVISIBLE,                   /* flags          */
	NULL,                                           /* dependencies   */
	PURPLE_PRIORITY_DEFAULT,                        /* priority       */

	"core-kgraefe-add-prefix",                      /* id             */
	"Add prefix",                                   /* name           */
	PLUGIN_VERSION,                                 /* version        */
	NULL,                                           /* summary        */
	NULL,                                           /* description    */
	"Konrad Gräfe <konradgraefe@aol.com>",          /* author         */
	"https://github.com/kgraefe/purple-add-prefix", /* homepage       */

	NULL,                                           /* load           */
	NULL,                                           /* unload         */
	NULL,                                           /* destroy        */

	NULL,                                           /* ui_info        */
	NULL,                                           /* extra_info     */
	NULL,                                           /* prefs_info     */
	NULL,                                           /* actions        */
	/* padding */
	NULL,
	NULL,
	NULL,
	NULL
};

static void add_search_path(const char *subdir) {
	char *search_path;

	search_path = g_build_filename(ADD_PREFIX, "lib", subdir, NULL);

	purple_debug_info(PLUGIN_STATIC_NAME,
		"Adding '%s' to plugin search path...\n", search_path
	);
	purple_plugins_add_search_path(search_path);

	g_free(search_path);
}
static void init_plugin(PurplePlugin *plugin) {
	const char *ui;

	add_search_path("purple-2");

	ui = purple_core_get_ui();
	if(purple_strequal(ui, "gtk-gaim")) {
		add_search_path("pidgin");
	}
	if(purple_strequal(ui, "gnt-purple")) {
		add_search_path("finch");
	}

	/* We added the search paths during plugin initialization which is called
	 * from purple_plugins_probe(). As our paths have been appended to the list
	 * of search paths purple_plugins_probe() picks them up automatically on
	 * its current run.
	 */
}

PURPLE_INIT_PLUGIN(PLUGIN_STATIC_NAME, init_plugin, info)
