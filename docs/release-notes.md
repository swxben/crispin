### 2.4.0

- Update FOP to 2.1
- Update IKVM to 8.1.5717.0
- Tidy up exception thrown if an error happens during XSL-FO to PDF conversion

### 2.3.2

- Make `FopInterface` public


### 2.3.1

- Fix version of FOP


### 2.3.0

- Update FOP to 2.0! woohoo!
- Support for SVGs in both HTML and PDF
- Support the `a` tag in PDFs

### 2.2.2

- Trim whitespace from incoming XRPT data, to help sanitise reports generated from Razor where the `<?xml` tag may not be the very first thing

### 2.2.1

- Revert the IKVM and RazorGenerator upgrade, as it was breaking in production...

### 2.2

- Upgraded IKVM and RazorGenerator
- Added new methods to `ReportingService` for converting report markup to PDF byte buffers, CSV and HTML

### 2.1

- Added support for setting the `external-graphic` scaling attribute (via `<img scaling="[uniform|non-uniform|inherit]">`). See <http://www.w3.org/TR/xsl/#scaling>.
- Remove workaround for non-JPEGS
	- Originally non-JPEG images were transparently converted to JPEGS and written back to the XSL using a `file://` url. This was to compensate for a version of Apache FOP being used that didn't support images that weren't JPEG. The version of Apache FOP in use supports PNGs so I'm dropping the hack.
