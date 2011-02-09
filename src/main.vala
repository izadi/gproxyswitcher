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
			string oaf_activate_iid = null;
			var entry_oaf_activate_iid = GLib.OptionEntry();
			entry_oaf_activate_iid.long_name = "oaf-activate-iid";
			entry_oaf_activate_iid.arg = GLib.OptionArg.STRING;
			entry_oaf_activate_iid.arg_data = &oaf_activate_iid;
			entry_oaf_activate_iid.flags = GLib.OptionFlags.HIDDEN;

			int oaf_ior_fd = -1;
			var entry_oaf_ior_fd = GLib.OptionEntry();
			entry_oaf_ior_fd.long_name = "oaf-ior-fd";
			entry_oaf_ior_fd.arg = GLib.OptionArg.INT;
			entry_oaf_ior_fd.arg_data = &oaf_ior_fd;
			entry_oaf_ior_fd.flags = GLib.OptionFlags.HIDDEN;
			
			var options = new GLib.OptionContext(" - GNOME Proxy Switcher");
			options.set_summary(Config.default.summary);
			options.set_help_enabled(true);
			options.add_main_entries({ entry_oaf_activate_iid, entry_oaf_ior_fd }, null);
			options.add_group(Gtk.get_option_group(true));
							
			if (!options.parse(ref args))
				return 1;

			if (oaf_activate_iid != null)
			{
				stdout.printf("Running in applet mode...\n");
				Gnome.Program.init("GProxySwitcher_Applet", "0.1", Gnome.libgnomeui_module, args, "sm-connect", false);
				return Panel.Applet.factory_main(oaf_activate_iid, typeof(Applet), Applet.factory);
			}
			else
			{
				stdout.printf("Running in tray mode...\n");
				var tray = new Tray();
				tray.visible = true;
				Gtk.main();
				return 0;
			}
		}
		catch (OptionError e)
		{
			stderr.printf("Error in main: %s\n", e.message);
			return 1;
		}
	}
}

