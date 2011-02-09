/* config.vala
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

public class GProxySwitcher.Config
{
	private static Config def;
	
	private string[] auth;
	
	private Config()
	{
		auth = new string[]
		{
			global::Config.PACKAGE_AUTHOR
		};
	}

	public static unowned Config default
	{
		get
		{
			if (def == null)
				def = new Config();
			return def;
		}
	}
			
	public string[] authors
	{
		get { return auth; }
	}
	
	public string summary
	{
		get { return "A simple applet to switch between locations defined in GNOME's Network Proxy.";}
	}
	
	public string name
	{
		get { return global::Config.PACKAGE_NAME; }
	}
	
	public string version
	{
		get { return global::Config.PACKAGE_VERSION; }
	}

	public string copyright
	{
		get { return global::Config.PACKAGE_COPYRIGHT; }
	}
	
	public string applet_proxy_icon_name
	{
		get { return global::Config.PACKAGE + "-proxy"; }
	}
	
	public string applet_direct_icon_name
	{
		get { return global::Config.PACKAGE + "-direct"; }
	}
	
	public string icon_name
	{
		get { return global::Config.PACKAGE; }
	}
	
	public string preferences_command_line
	{
		get { return "gnome-network-properties"; }
	}
}

