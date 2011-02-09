/* applet.vala
 *
 * Copyright (C) 2011  Mohsen Izadi
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *  
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class GProxySwitcher.Applet: Panel.Applet
{
	private class Location
	{
		public Location(string name, string label)
		{
			this.name = name;
			this.label = label;
		}
	
		public string name { get; private set; }
		public string label { get; private set; }
	}

	private BonoboUI.Verb verb_preferences;
	private BonoboUI.Verb verb_about;
	private Location[] locations;

	public static bool factory(Panel.Applet applet, string iid)
	{
		((Applet) applet).create();
		return true;
	}

	private static void on_verb_location_callback(BonoboUI.Component component,
		void* user_data, string cname)
	{
		var location = (Location) user_data;
		LocationsManager.set_location(location.label);
	}

	private static void on_verb_preferences_callback(BonoboUI.Component component,
		void* user_data, string cname)
	{
		Gdk.spawn_command_line_on_screen(((Applet) user_data).get_screen(), Config.default.preferences_command_line);
	}

	private static void on_verb_about_callback(BonoboUI.Component component,
		void* user_data, string cname)
	{
		About.show();
	}

	private void on_change_background(Panel.AppletBackgroundType type,
		Gdk.Color? color, Gdk.Pixmap? pixmap)
	{
		set_style(null);

		var rc_style = new Gtk.RcStyle();
		modify_style(rc_style);

		switch (type)
		{
		case Panel.AppletBackgroundType.COLOR_BACKGROUND:
			modify_bg(Gtk.StateType.NORMAL, color);
			break;
		case Panel.AppletBackgroundType.PIXMAP_BACKGROUND:
			style.bg_pixmap[0] = pixmap;
			set_style(style);
			break;
		}
	}

	private bool on_button_press_event(Gtk.Widget widget, Gdk.EventButton event)
	{
		if (event.type != Gdk.EventType.BUTTON_PRESS || event.button != 3)
			return false;
	
		var locs = LocationsManager.get_locations();
		var cur = LocationsManager.get_current_location();

		locations = new Location[locs.length];
		for (int i = 0; i < locs.length; i++)
			locations[i] = new Location("location_" + i.to_string(), locs[i]);
		var verbs = new BonoboUI.Verb[locations.length + 2];
	
		string menu_definition = 
			"<popup name=\"button3\">\n";
		
		for (int i = 0; i < locations.length; i++)
		{
			menu_definition +=
				"    <menuitem name=\"" + locations[i].name + "\"\n" +
				"        verb=\"" + locations[i].name + "\"\n";
			if (locations[i].label == cur)
				menu_definition +=
					"        pixtype=\"stock\"\n" +
					"        pixname=\"" + Gtk.STOCK_YES + "\"\n";
			menu_definition +=
				"        _label=\"" + locations[i].label + "\" />\n";
			verbs[i] = BonoboUI.Verb();
			verbs[i].cname = locations[i].name;
			verbs[i].cb = on_verb_location_callback;
			verbs[i].user_data = locations[i];
		}

		menu_definition +=
			"    <separator />\n";

		menu_definition +=
			"    <menuitem name=\"about\"\n" +
			"        verb=\"preferences\"\n" +
			"        _label=\"_Preferences\"\n" +
			"        pixtype=\"stock\"\n" +
			"        pixname=\"" + Gtk.STOCK_PREFERENCES + "\" />\n";
		verbs[locations.length] = verb_preferences;
	
		menu_definition +=
			"    <menuitem name=\"about\"\n" +
			"        verb=\"about\"\n" +
			"        _label=\"_About...\"\n" +
			"        pixtype=\"stock\"\n" +
			"        pixname=\"" + Gtk.STOCK_ABOUT + "\" />\n";
		verbs[locations.length + 1] = verb_about;
	
		menu_definition += "</popup>";

		setup_menu(menu_definition, verbs, null);

		return false;
	}

	private void create()
	{
		verb_about = BonoboUI.Verb();
		verb_about.cname = "about";
		verb_about.cb = on_verb_about_callback;

		verb_preferences = BonoboUI.Verb();
		verb_preferences.cname = "preferences";
		verb_preferences.user_data = this;
		verb_preferences.cb = on_verb_preferences_callback;

		change_background.connect(on_change_background);
		button_press_event.connect(on_button_press_event);
	
		var image = new Gtk.Image.from_icon_name(Config.default.applet_proxy_icon_name, Gtk.IconSize.SMALL_TOOLBAR);
		add(image);

		show_all();
	}
}

