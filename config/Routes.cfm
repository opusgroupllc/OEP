﻿<cfscript>
	// Allow unique URL or combination of URLs, we recommend both enabled
	setUniqueURLS(false);
	// Auto reload configuration, true in dev makes sense to reload the routes on every request
	//setAutoReload(false);
	// Sets automatic route extension detection and places the extension in the rc.format variable
	// setExtensionDetection(true);
	// The valid extensions this interceptor will detect
	// setValidExtensions('xml,json,jsont,rss,html,htm');
	// If enabled, the interceptor will throw a 406 exception that an invalid format was detected or just ignore it
	// setThrowOnInvalidExtension(true);

	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("https://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("https://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}

	// Your Application Routes
	addRoute(pattern=":handler/:action?");

	addRoute(pattern = "login", handler = "login", action = "index", ssl = true);
	addRoute(pattern = "login", handler = "authenticate", action = "authenticate");
	addRoute(pattern = "login", handler = "invalid_user", action = "invalid_user");

	addRoute(pattern = "home", handler = "home", action = "index", ssl = true);

	addRoute(pattern = "user/:action?", handler = "user", action = "index", ssl = true);
	addRoute(pattern = "user/:action?", handler = "user", action = "add", ssl = true);
	addRoute(pattern = "user/:action?", handler = "user", action = "edit", ssl = true);

	//addNameSpace(pattern = "/news", namespace = "news")
//		.addRoute(pattern = "/", handler = "post", action = "index", namespace = "news");

	addRoute(pattern = "news/:action?", handler = "news", action = "index", ssl = true);
	addRoute(pattern = "news/:action?", handler = "news", action = "item", ssl = true);
	addRoute(pattern = "news/:action?", handler = "news", action = "add", ssl = true);
	addRoute(pattern = "news/:action?", handler = "news", action = "edit", ssl = true);

	addRoute(pattern = "blog/:action?", handler = "blog", action = "index", ssl = true);
	addRoute(pattern = "blog/:action?", handler = "blog", action = "item", ssl = true);
	addRoute(pattern = "blog/:action?", handler = "blog", action = "add", ssl = true);
	addRoute(pattern = "blog/:action?", handler = "blog", action = "edit", ssl = true);

	addRoute(pattern = "link/:action?", handler = "link", action = "index", ssl = true);
	addRoute(pattern = "link/:action?", handler = "link", action = "item", ssl = true);
	addRoute(pattern = "link/:action?", handler = "link", action = "add", ssl = true);
	addRoute(pattern = "link/:action?", handler = "link", action = "edit", ssl = true);

	addRoute(pattern = "site_feedback_and_suggestions/:action?", handler = "site_feedback_and_suggestions", action = "index", ssl = true);
	addRoute(pattern = "site_feedback_and_suggestions/:action?", handler = "site_feedback_and_suggestions", action = "item", ssl = true);
	addRoute(pattern = "site_feedback_and_suggestions/:action?", handler = "site_feedback_and_suggestions", action = "add", ssl = true);
	addRoute(pattern = "site_feedback_and_suggestions/:action?", handler = "site_feedback_and_suggestions", action = "edit", ssl = true);


	/** Developers can modify the CGI.PATH_INFO value in advance of the SES
		interceptor to do all sorts of manipulations in advance of route
		detection. If provided, this function will be called by the SES
		interceptor instead of referencing the value CGI.PATH_INFO.

		This is a great place to perform custom manipulations to fix systemic
		URL issues your Web site may have or simplify routes for i18n sites.

		@Event The ColdBox RequestContext Object
	**/
	function PathInfoProvider(Event){
		/* Example:
		var URI = CGI.PATH_INFO;
		if (URI eq "api/foo/bar")
		{
			Event.setProxyRequest(true);
			return "some/other/value/for/your/routes";
		}
		*/
		return CGI.PATH_INFO;
	}
</cfscript>