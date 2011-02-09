/* tray.vala
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

public class GProxySwitcher.Tray: Gtk.StatusIcon
{
	public Tray()
	{
		icon_name = Config.default.applet_proxy_icon_name;
		has_tooltip = true;

		activate.connect(on_activate);
		query_tooltip.connect(on_query_tooltip);
		popup_menu.connect(on_popup_menu);
	}

	private void on_activate()
	{
		var locations_group = new SList<Gtk.RadioMenuItem>();
		var menu = new Gtk.Menu();
		var locs = LocationsManager.get_locations();
		var def = LocationsManager.get_current_location();
		Gtk.RadioMenuItem group = null;
		foreach (var loc in locs)
		{
			var item = group == null ? new Gtk.RadioMenuItem.with_label(locations_group, loc) : new Gtk.RadioMenuItem.with_label_from_widget(group, loc);
			if (group == null) group = item;
			if (loc == def)
				item.active = true;
			item.toggled.connect(on_menu_item_location_toggled);
			menu.add(item);
		}

		menu.show_all();
		menu.popup(null, null, position_menu, 0, Gtk.get_current_event_time());
	}

	private bool on_query_tooltip(int x, int y, bool keyboard_mode, Gtk.Tooltip tooltip)
	{
		tooltip.set_text("Current Proxy: " + LocationsManager.get_current_location());
		return true;
	}

	private void on_menu_item_location_toggled(Gtk.CheckMenuItem item)
	{
		if (item.active)
			LocationsManager.set_location(item.label);
	}

	private void on_menu_item_preferences_activate(Gtk.MenuItem menu_item)
	{
		Gdk.spawn_command_line_on_screen(screen, Config.default.preferences_command_line);
	}
	
	private void on_menu_item_about_activate(Gtk.MenuItem menu_item)
	{
		About.show();
	}

	private void on_menu_item_quit_activate(Gtk.MenuItem menu_item)
	{
		Gtk.main_quit();
	}

	private void on_popup_menu(uint button, uint activate_time)
	{
		var menu = new Gtk.Menu();
		var menu_item_preferences = new Gtk.ImageMenuItem.from_stock(Gtk.STOCK_PREFERENCES, null);
		menu_item_preferences.activate.connect(on_menu_item_preferences_activate);
		menu.add(menu_item_preferences);

		var menu_item_about = new Gtk.ImageMenuItem.from_stock(Gtk.STOCK_ABOUT, null);
		menu_item_about.activate.connect(on_menu_item_about_activate);
		menu.add(menu_item_about);

		menu.add(new Gtk.SeparatorMenuItem());
		
		var menu_item_quit = new Gtk.ImageMenuItem.from_stock(Gtk.STOCK_QUIT, null);
		menu_item_quit.activate.connect(on_menu_item_quit_activate);
		menu.add(menu_item_quit);

		menu.show_all();
		menu.popup(null, null, position_menu, button, activate_time);
	}
}

