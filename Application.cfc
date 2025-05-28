
component {
    this.name = "BlogCMS";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 1, 0, 0);
    this.applicationTimeout = createTimeSpan(1, 0, 0, 0);
    this.setClientCookies = true;
    this.loginStorage = "session";
    this.datasource = "blog_cms_db";

    // onApplicationStart
    function onApplicationStart() {
        application.appStart = now();
        return true;
    }

    // onSessionStart
    function onSessionStart() {
        session.authenticated = false;
    }

    // onRequestStart
    function onRequestStart(string targetPage) {
        if (!structKeyExists(session, "lang")) {
            session.lang = "en"; // default
        }
    }
}
