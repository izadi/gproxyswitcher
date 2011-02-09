/* about.vala
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

public class GProxySwitcher.About
{
	public static void show()
	{
		var config = Config.default;
		
		var dialog = new Gtk.AboutDialog();
		dialog.authors = config.authors;
		dialog.comments = config.summary;
		dialog.logo_icon_name = config.icon_name;
		dialog.program_name = config.name;
		dialog.version = config.version;
		dialog.copyright = config.copyright;
		dialog.run();
		dialog.destroy();
	}
}

