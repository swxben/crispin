<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:regExp="http://exslt.org/regular-expressions"
	extension-element-prefixes="regExp msxsl">
  <xsl:output method="text" omit-xml-declaration="yes" indent="yes" encoding="utf-8" />

  <!-- I needed replace() to help with non-breaking space replacement further down, but replace() is in XSLT 2.0 and .NET 1.1 only
supports XSLT 1.0, this adds a function named regExp:replace() that is almost identical. I found this on 
http://www.stylusstudio.com/~ssdn/default.asp?action=9&fid=23&read=3438&FirstTopic=1527&LastTopic=1626 -->
  <msxsl:script language="JavaScript" implements-prefix="regExp">
    <![CDATA[
function replace(ctx, re, flags, repStr) {
	var ipString = "";
	if (typeof(ctx) == "object") {
		if (ctx.length) {
			for (var i=0; i < 1; i++) {
				var ctxN = ctx.item(i);
				if (ctxN.nodeType == 1) {
					ipString += _wander(ctxN);
				}
				if (ctxN.nodeType == 2) {
					ipString += ctxN.nodeValue;
				}
			}
		} else {
			return '';
		}
	} else {
		ipString = ctx;
	}
	var re = new RegExp(re, flags);
	return ipString.replace(re, repStr);
}
function _wander(ctx) {
	var retStr = "";
	for (var i=0; i < ctx.childNodes.length; i++) {
		var ctxN = ctx.childNodes[i];
		switch(ctxN.nodeType) {
			case 1:
				retStr += _wander(ctxN);
				break;
			case 3:
				retStr += ctxN.nodeValue;
				break;
			default:
				break;
		}
	}
	return retStr;
}
]]>
  </msxsl:script>


  <!-- Templates -->
  <!-- spacer cell template -->
  <xsl:template name="add-spacer-cell">
    <xsl:param name="col"/>
    <xsl:if test="$col > 0">
      <xsl:value-of select="','" />
      <xsl:call-template name="add-spacer-cell">
        <xsl:with-param name="col">
          <xsl:number value="number($col) - 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template match="/">
    <!-- Find all data tables in the XRPT -->
    <xsl:for-each select="report/content/pageSequence/*/table[@type='DataGrid' or @type='DataGridPas2' or @type='Data']|report/content/pageSequence/*/*/table[@type='DataGrid' or @type='DataGridPas2' or @type='Data']">
      <!-- for each section in the table -->
      <xsl:for-each select="thead|tbody|tfoot">
        <!-- for each row in the section -->
        <xsl:for-each select="tr">
          <!-- for each cell in the row -->
          <xsl:for-each select="td|th">
            <!-- write the cell content -->
            <xsl:choose>
              <xsl:when test="@value">"<xsl:value-of select="@value" />"</xsl:when>
              <!-- the regExp:replace() replaces '&#160;' (hex non-breaking space) with a normal space, otherwise it
						prints a funny letter with a circle above it or whatever -->
              <xsl:otherwise>"<xsl:value-of select="normalize-space(regExp:replace(string(.),'&#160;','',' '))" />"</xsl:otherwise>
            </xsl:choose>
            <!-- check for colspan, insert spacer commas -->
            <xsl:if test="@colspan">
              <xsl:call-template name="add-spacer-cell">
                <xsl:with-param name="col">
                  <xsl:number value="number(@colspan) - 1"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
            <!-- if not the last cell, write a comma -->
            <xsl:if test="position() != last()">
              <xsl:value-of select="','" />
            </xsl:if>
          </xsl:for-each>
          <!-- line break -->
          <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>