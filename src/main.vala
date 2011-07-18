/* main.vala
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

public class GProxySwitcher.Main
{
	public static int main(string[] args)
	{
		try
		{
			var options = new GLib.OptionContext(" - GNOME Proxy Switcher");
			options.set_summary(Config.default.summary);
			options.set_help_enabled(true);
			options.add_main_entries({}, null);
			options.add_group(Gtk.get_option_group(true));
							
			if (!options.parse(ref args))
				return 1;

			stdout.printf("Running in tray mode...\n");
			var tray = new Tray();
			tray.visible = true;
			Gtk.main();
			return 0;
		}
		catch (OptionError e)
		{
			stderr.printf("Error in main: %s\n", e.message);
			return 1;
		}
	}
}

