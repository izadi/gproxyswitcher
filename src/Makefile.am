NULL = 

AM_CPPFLAGS = \
	$(GPROXYSWITCHER_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

bin_PROGRAMS = gproxyswitcher

gproxyswitcher_SOURCES = \
	about.vala \
	applet.vala \
	config.vala \
	locations-manager.vala \
	main.vala \
	tray.vala \
	$(NULL)

gproxyswitcher_VALAFLAGS = \
	--vapidir ../vapi \
	--pkg config \
	--pkg gtk+-2.0 \
	--pkg libpanelapplet-2.0 \
	--pkg gconf-2.0 \
	--pkg libgnomeui-2.0 \
	$(NULL)

gproxyswitcher_LDADD = \
	$(GPROXYSWITCHER_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)

