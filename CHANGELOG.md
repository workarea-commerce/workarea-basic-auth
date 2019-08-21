Workarea Basic Auth 1.1.0 (2019-03-19)
--------------------------------------------------------------------------------

*   Add bypass for whitelisted ip addresses, set whitelist to alert logic ips

    BASICAUTH-14
    Matt Duffy

*   Update for workarea v3.4 compatibility

    BASICAUTH-12
    Matt Duffy

*   Update plugin to align with product team standards

    Matt Duffy

*   Bump version for release

    Beresford, Jake

*   Correct route to allow ELB to pass through

    BASICAUTH-9
    Beresford, Jake

*   Change reference in rakefile from head to HEAD

    Dave Barnow

*   fix rubocop for build

    Beresford, Jake

*   Add changelog task to Rakefile and prepare for release

    Beresford, Jake

*   Configure rubocop

    Install and configure rubocop using rails config

    BASICAUTH-8
    Eric Pigeon

*   Fix test conversion for Workarea 3 bump

    BASICAUTH-4
    Eric Pigeon

*   BASICAUTH-3: Revert some workarea name changes back to weblinc

    Brian Berg

*   Update basic_auth for work area v3 compatibility

    * Rename directories, files, and file contents
    * Update gemspec
    * Update tests

    BASICAUTH-3
    Brian Berg

*   Add ability to remove paths

    This allows one to remove a path that has been added by default if you
    want to do that.

    BASICAUTH-2
    Tom Scott

*   BASICAUTH-2: Exclude common paths by default

    Projects across the board apply these settings to the basic auth gem
    after initialization. While we still want each project to configure
    activation and what the username/password will be, it's not useful to
    have each project individually configure their own basic auth gem for
    static assets, because they need to be configured for every project.
    This is now in the gem, so projects starting with the latest
    `weblinc-basic_auth` will not need to check their apps to make sure
    images still work after adding basic auth.
    Tom Scott

*   Bump patch version

    Thomas Vendetta

*   Handle lack of User-Agent in HTTP requests

    Sometimes, like in the case of custom API clients, the User-Agent may
    not be explicitly set, and so this will throw an exception because
    HTTP_USER_AGENT is returning nil. Make sure we're always working with a
    String when calling `#include?` to see if 'ELB-HealthChecker' is the
    User-Agent making a request to the server.

    BASICAUTH-1
    Tom Scott

*   Docs: Add asset exclusion

    Thomas Vendetta

*   Add documentation and default AWS health check

    Thomas Vendetta

*   Add proc based matching

    Thomas Vendetta

*   Better matching

    Thomas Vendetta

*   Better exclusion logic

    Thomas Vendetta

*   Bump version proper

    Thomas Vendetta

*   Greater than or equal to 0.5

    Thomas Vendetta

*   Automatically exclude health check

    Thomas Vendetta

*   Update weblinc core minimum version

    Thomas Vendetta

*   Documentation Formatting OCD

    Thomas Vendetta

*   Bump version for post install

    Thomas Vendetta

*   Update desc

    Thomas Vendetta

*   Add post install message w/ config

    Thomas Vendetta

*   Update readme

    Thomas Vendetta

*   Docs

    Thomas Vendetta

*   Docs

    Thomas Vendetta

*   Test invalid creds

    Thomas Vendetta

*   Proper authentication

    Thomas Vendetta

*   Update documentation and tests

    Thomas Vendetta

*   Remove app stuff

    Thomas Vendetta

*   Passing tests

    Thomas Vendetta



WebLinc Basic Auth 1.0.1 (2017-06-01)
--------------------------------------------------------------------------------

*   Correct route to allow ELB to pass through

    BASICAUTH-9
    Beresford, Jake

*   Configure rubocop

    Install and configure rubocop using rails config

    BASICAUTH-8
    Eric Pigeon

*   Fix test conversion for Workarea 3 bump

    BASICAUTH-4
    Eric Pigeon

*   BASICAUTH-3: Revert some workarea name changes back to weblinc
    Brian Berg

*   Update basic_auth for work area v3 compatibility

    * Rename directories, files, and file contents
    * Update gemspec
    * Update tests

    BASICAUTH-3
    Brian Berg

*   Add ability to remove paths

    This allows one to remove a path that has been added by default if you
    want to do that.

    BASICAUTH-2
    Tom Scott

*   BASICAUTH-2: Exclude common paths by default

    Projects across the board apply these settings to the basic auth gem
    after initialization. While we still want each project to configure
    activation and what the username/password will be, it's not useful to
    have each project individually configure their own basic auth gem for
    static assets, because they need to be configured for every project.
    This is now in the gem, so projects starting with the latest
    `weblinc-basic_auth` will not need to check their apps to make sure
    images still work after adding basic auth.
    Tom Scott

*   Handle lack of User-Agent in HTTP requests

    Sometimes, like in the case of custom API clients, the User-Agent may
    not be explicitly set, and so this will throw an exception because
    HTTP_USER_AGENT is returning nil. Make sure we're always working with a
    String when calling `#include?` to see if 'ELB-HealthChecker' is the
    User-Agent making a request to the server.

    BASICAUTH-1
    Tom Scott


WebLinc Basic Auth 1.0.0 (2017-05-22)
--------------------------------------------------------------------------------

*   Configure rubocop

    Install and configure rubocop using rails config

    BASICAUTH-8
    Eric Pigeon

*   Fix test conversion for Workarea 3 bump

    BASICAUTH-4
    Eric Pigeon

*   BASICAUTH-3: Revert some workarea name changes back to weblinc
    Brian Berg

*   Update basic_auth for work area v3 compatibility

    * Rename directories, files, and file contents
    * Update gemspec
    * Update tests

    BASICAUTH-3
    Brian Berg

*   Add ability to remove paths

    This allows one to remove a path that has been added by default if you
    want to do that.

    BASICAUTH-2
    Tom Scott

*   BASICAUTH-2: Exclude common paths by default

    Projects across the board apply these settings to the basic auth gem
    after initialization. While we still want each project to configure
    activation and what the username/password will be, it's not useful to
    have each project individually configure their own basic auth gem for
    static assets, because they need to be configured for every project.
    This is now in the gem, so projects starting with the latest
    `weblinc-basic_auth` will not need to check their apps to make sure
    images still work after adding basic auth.
    Tom Scott

*   Handle lack of User-Agent in HTTP requests

    Sometimes, like in the case of custom API clients, the User-Agent may
    not be explicitly set, and so this will throw an exception because
    HTTP_USER_AGENT is returning nil. Make sure we're always working with a
    String when calling `#include?` to see if 'ELB-HealthChecker' is the
    User-Agent making a request to the server.

    BASICAUTH-1
    Tom Scott


WebLinc Basic Auth 1.0.0 (2017-05-22)
--------------------------------------------------------------------------------

*   Configure rubocop

    Install and configure rubocop using rails config

    BASICAUTH-8
    Eric Pigeon

*   Fix test conversion for Workarea 3 bump

    BASICAUTH-4
    Eric Pigeon

*   BASICAUTH-3: Revert some workarea name changes back to weblinc
    Brian Berg

*   Update basic_auth for work area v3 compatibility

    * Rename directories, files, and file contents
    * Update gemspec
    * Update tests

    BASICAUTH-3
    Brian Berg

*   Add ability to remove paths

    This allows one to remove a path that has been added by default if you
    want to do that.

    BASICAUTH-2
    Tom Scott

*   BASICAUTH-2: Exclude common paths by default

    Projects across the board apply these settings to the basic auth gem
    after initialization. While we still want each project to configure
    activation and what the username/password will be, it's not useful to
    have each project individually configure their own basic auth gem for
    static assets, because they need to be configured for every project.
    This is now in the gem, so projects starting with the latest
    `weblinc-basic_auth` will not need to check their apps to make sure
    images still work after adding basic auth.
    Tom Scott

*   Handle lack of User-Agent in HTTP requests

    Sometimes, like in the case of custom API clients, the User-Agent may
    not be explicitly set, and so this will throw an exception because
    HTTP_USER_AGENT is returning nil. Make sure we're always working with a
    String when calling `#include?` to see if 'ELB-HealthChecker' is the
    User-Agent making a request to the server.

    BASICAUTH-1
    Tom Scott
