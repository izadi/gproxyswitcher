/* locations-manager.vala
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

public class GProxySwitcher.LocationsManager
{
	private const string SYSTEM_KEY = "/system";

	private const string USE_PROXY_KEY = "/http_proxy/use_http_proxy";
	private const string USE_SAME_PROXY_KEY = "/http_proxy/use_same_proxy";
	private const string HTTP_PROXY_HOST_KEY = "/http_proxy/host";
	private const string HTTP_PROXY_PORT_KEY = "/http_proxy/port";
	private const string HTTP_USE_AUTH_KEY = "/http_proxy/use_authentication";
	private const string HTTP_AUTH_USER_KEY = "/http_proxy/authentication_user";
	private const string HTTP_AUTH_PASSWD_KEY = "/http_proxy/authentication_password";
	private const string IGNORE_HOSTS_KEY = "/http_proxy/ignore_hosts";
	private const string PROXY_MODE_KEY = "/proxy/mode";
	private const string SECURE_PROXY_HOST_KEY = "/proxy/secure_host";
	private const string OLD_SECURE_PROXY_HOST_KEY = "/proxy/old_secure_host";
	private const string SECURE_PROXY_PORT_KEY = "/proxy/secure_port";
	private const string OLD_SECURE_PROXY_PORT_KEY = "/proxy/old_secure_port";
	private const string FTP_PROXY_HOST_KEY = "/proxy/ftp_host";
	private const string OLD_FTP_PROXY_HOST_KEY = "/proxy/old_ftp_host";
	private const string FTP_PROXY_PORT_KEY = "/proxy/ftp_port";
	private const string OLD_FTP_PROXY_PORT_KEY = "/proxy/old_ftp_port";
	private const string SOCKS_PROXY_HOST_KEY = "/proxy/socks_host";
	private const string OLD_SOCKS_PROXY_HOST_KEY = "/proxy/old_socks_host";
	private const string SOCKS_PROXY_PORT_KEY = "/proxy/socks_port";
	private const string OLD_SOCKS_PROXY_PORT_KEY = "/proxy/old_socks_port";
	private const string PROXY_AUTOCONFIG_URL_KEY = "/proxy/autoconfig_url";

	private const string LOCATION_DIR_KEY = "/apps/control-center/network";
	private const string CURRENT_LOCATION_KEY = "/apps/control-center/network/current_location";

	private static string get_current_location_from_client(GConf.Client client) throws GLib.Error
	{
		return client.get_string(CURRENT_LOCATION_KEY);
	}

	public static string get_current_location()
	{
		try
		{
			return get_current_location_from_client(GConf.Client.get_default());
		}
		catch (GLib.Error e)
		{
			stderr.printf("Error in getting current location: %s\n", e.message);
			return "";
		}
	}

	public static string[] get_locations()
	{
		try
		{
			var client = GConf.Client.get_default();

			var list = client.all_dirs(LOCATION_DIR_KEY);
			int count = 0;
			for (unowned SList<string> item = list; item != null; item = item.next, count++)
				item.data = GConf.unescape_key(item.data.substring(LOCATION_DIR_KEY.length + 1), -1);

			var current = get_current_location_from_client(client);
			list.append(current);
			count++;

			list.sort((CompareFunc) strcmp);
	
			var result = new string[count];
	
			int i = 0;
			for (unowned SList<string> item = list; item != null; item = item.next, i++)
				result[i] = item.data;
		
			return result;
		}
		catch (GLib.Error e)
		{
			stderr.printf("Error in getting locations: %s\n", e.message);
			return {};
		}
	}

	private static string copy_location_create_key(string? from, string what)
	{
		return (from ?? SYSTEM_KEY) + what;
	}

	private static void copy_location(string? from, string? to, GConf.Client client) throws GLib.Error
	{
		string dest, src;

		/* USE_PROXY */
		dest = copy_location_create_key(to, USE_PROXY_KEY);
		src = copy_location_create_key(from, USE_PROXY_KEY);

		client.set_bool(dest, client.get_bool(src));

		/* USE_SAME_PROXY */
		dest = copy_location_create_key(to, USE_SAME_PROXY_KEY);
		src = copy_location_create_key(from, USE_SAME_PROXY_KEY);

		client.set_bool(dest, client.get_bool(src));

		/* HTTP_PROXY_HOST */
		dest = copy_location_create_key(to, HTTP_PROXY_HOST_KEY);
		src = copy_location_create_key(from, HTTP_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* HTTP_PROXY_PORT */
		dest = copy_location_create_key(to, HTTP_PROXY_PORT_KEY);
		src = copy_location_create_key(from, HTTP_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* HTTP_USE_AUTH */
		dest = copy_location_create_key(to, HTTP_USE_AUTH_KEY);
		src = copy_location_create_key(from, HTTP_USE_AUTH_KEY);

		client.set_bool(dest, client.get_bool(src));

		/* HTTP_AUTH_USER */
		dest = copy_location_create_key(to, HTTP_AUTH_USER_KEY);
		src = copy_location_create_key(from, HTTP_AUTH_USER_KEY);

		client.set_string(dest, client.get_string(src));

		/* HTTP_AUTH_PASSWD */
		dest = copy_location_create_key(to, HTTP_AUTH_PASSWD_KEY);
		src = copy_location_create_key(from, HTTP_AUTH_PASSWD_KEY);

		 client.set_string(dest, client.get_string(src));

		/* IGNORE_HOSTS */
		dest = copy_location_create_key(to, IGNORE_HOSTS_KEY);
		src = copy_location_create_key(from, IGNORE_HOSTS_KEY);

		client.set_list(dest, GConf.ValueType.STRING, client.get_list(src, GConf.ValueType.STRING));

		/* PROXY_MODE */
		dest = copy_location_create_key(to, PROXY_MODE_KEY);
		src = copy_location_create_key(from, PROXY_MODE_KEY);

		client.set_string(dest, client.get_string(src));

		/* SECURE_PROXY_HOST */
		dest = copy_location_create_key(to, SECURE_PROXY_HOST_KEY);
		src = copy_location_create_key(from, SECURE_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* OLD_SECURE_PROXY_HOST */
		dest = copy_location_create_key(to, OLD_SECURE_PROXY_HOST_KEY);
		src = copy_location_create_key(from, OLD_SECURE_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* SECURE_PROXY_PORT */
		dest = copy_location_create_key(to, SECURE_PROXY_PORT_KEY);
		src = copy_location_create_key(from, SECURE_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* OLD_SECURE_PROXY_PORT */
		dest = copy_location_create_key(to, OLD_SECURE_PROXY_PORT_KEY);
		src = copy_location_create_key(from, OLD_SECURE_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* FTP_PROXY_HOST */
		dest = copy_location_create_key(to, FTP_PROXY_HOST_KEY);
		src = copy_location_create_key(from, FTP_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* OLD_FTP_PROXY_HOST */
		dest = copy_location_create_key(to, OLD_FTP_PROXY_HOST_KEY);
		src = copy_location_create_key(from, OLD_FTP_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* FTP_PROXY_PORT */
		dest = copy_location_create_key(to, FTP_PROXY_PORT_KEY);
		src = copy_location_create_key(from, FTP_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* OLD_FTP_PROXY_PORT */
		dest = copy_location_create_key(to, OLD_FTP_PROXY_PORT_KEY);
		src = copy_location_create_key(from, OLD_FTP_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* SOCKS_PROXY_HOST */
		dest = copy_location_create_key(to, SOCKS_PROXY_HOST_KEY);
		src = copy_location_create_key(from, SOCKS_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* OLD_SOCKS_PROXY_HOST */
		dest = copy_location_create_key(to, OLD_SOCKS_PROXY_HOST_KEY);
		src = copy_location_create_key(from, OLD_SOCKS_PROXY_HOST_KEY);

		client.set_string(dest, client.get_string(src));

		/* SOCKS_PROXY_PORT */
		dest = copy_location_create_key(to, SOCKS_PROXY_PORT_KEY);
		src = copy_location_create_key(from, SOCKS_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* OLD_SOCKS_PROXY_PORT */
		dest = copy_location_create_key(to, OLD_SOCKS_PROXY_PORT_KEY);
		src = copy_location_create_key(from, OLD_SOCKS_PROXY_PORT_KEY);

		client.set_int(dest, client.get_int(src));

		/* PROXY_AUTOCONFIG_URL */
		dest = copy_location_create_key(to, PROXY_AUTOCONFIG_URL_KEY);
		src = copy_location_create_key(from, PROXY_AUTOCONFIG_URL_KEY);

		client.set_string(dest, client.get_string(src));
	}

	public static void set_location(string location)
	{
		try
		{
			var client = GConf.Client.get_default();
	
			var current = get_current_location_from_client(client);
	
			if (current == location) return;
	
			// Save current settings in locations
			copy_location(null, LOCATION_DIR_KEY + "/" + GConf.escape_key(current, -1), client);
	
			var key = LOCATION_DIR_KEY + "/" + GConf.escape_key(location, -1);

			// Load new settings from locations
			copy_location(key, null, client);

			// Remove new settings from locations
			client.recursive_unset(key, GConf.UnsetFlags.NAMES);
	
			// Set current location
			client.set_string(CURRENT_LOCATION_KEY, location);
	
			client.suggest_sync();
		}
		catch (GLib.Error e)
		{
			stderr.printf("Error in setting location: %s\n", e.message);
		}
	}
}

