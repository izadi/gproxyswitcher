AC_INIT([GNOME Proxy Switcher], [0.3.0], [m.izadi@gmail.com], [gproxyswitcher])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS(config.h)
AM_INIT_AUTOMAKE([dist-bzip2])
AM_MAINTAINER_MODE

AC_PROG_CC
AM_PROG_CC_C_O
AC_DISABLE_STATIC
AC_PROG_LIBTOOL

AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)

AH_TEMPLATE([GETTEXT_PACKAGE], [Package name for gettext])
GETTEXT_PACKAGE=$PACKAGE_TARNAME
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE")
AC_SUBST(GETTEXT_PACKAGE)
AM_GLIB_GNU_GETTEXT
IT_PROG_INTLTOOL([0.35.0])

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

#-----
# Sets up a few prefix-relative directories
#if test "x${prefix}" = "xNONE"; then
#	PREFIX="${ac_default_prefix}"
#else
#	PREFIX="${prefix}"
#fi
#AC_DEFINE_UNQUOTED(PACKAGE_DATADIR, "${PREFIX}/${DATADIRNAME}/${PACKAGE}",[Package data directory])
AC_DEFINE_UNQUOTED(PACKAGE_AUTHOR, "Mohsen Izadi <m.izadi@gmail.com>",[Package author])
AC_DEFINE_UNQUOTED(PACKAGE_COPYRIGHT, "Copyright © 2011 Mohsen Izadi",[Package copyright])
#-----

GLIB_REQUIRED=2.12.0
GTK_REQUIRED=2.18.0

PKG_CHECK_MODULES(GPROXYSWITCHER,
	glib-2.0 >= $GLIB_REQUIRED
	gobject-2.0 >= $GLIB_REQUIRED
	gtk+-2.0 >= $GTK_REQUIRED
	gconf-2.0
	libpanelapplet-2.0
	libgnomeui-2.0)
AC_SUBST(GPROXYSWITCHER_CFLAGS)
AC_SUBST(GPROXYSWITCHER_LIBS)

AC_CONFIG_FILES([Makefile
	src/Makefile
	data/Makefile
	data/icons/Makefile
	data/icons/16x16/Makefile
	data/icons/16x16/apps/Makefile
	data/icons/16x16/status/Makefile
	data/icons/22x22/Makefile
	data/icons/22x22/apps/Makefile
	data/icons/22x22/status/Makefile
	data/icons/24x24/Makefile
	data/icons/24x24/apps/Makefile
	data/icons/24x24/status/Makefile
	data/icons/32x32/Makefile
	data/icons/32x32/apps/Makefile
	data/icons/32x32/status/Makefile
	data/icons/48x48/Makefile
	data/icons/48x48/apps/Makefile
	data/icons/48x48/status/Makefile
	data/icons/64x64/Makefile
	data/icons/64x64/apps/Makefile
	data/icons/64x64/status/Makefile
	data/icons/72x72/Makefile
	data/icons/72x72/apps/Makefile
	data/icons/72x72/status/Makefile
	data/icons/96x96/Makefile
	data/icons/96x96/apps/Makefile
	data/icons/96x96/status/Makefile
	data/icons/128x128/Makefile
	data/icons/128x128/apps/Makefile
	data/icons/128x128/status/Makefile
	data/icons/scalable/Makefile
	data/icons/scalable/apps/Makefile
	data/icons/scalable/status/Makefile
	vapi/Makefile
	po/Makefile.in])

AC_OUTPUT
