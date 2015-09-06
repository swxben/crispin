<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
  <!ENTITY ldquo "&#8220;">
  <!ENTITY lsquo "&#8216;">
  <!ENTITY rdquo "&#8221;">
  <!ENTITY rsquo "&#8217;">
  <!ENTITY quot "&#34;">
]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">
  <xsl:output
    method="xml"
    indent="yes" 
    />

  <!-- Page setup (report/pageSetup): -->
  <xsl:variable name="pageMarginLeft">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageMarginLeft"><xsl:value-of select="report/pageSetup/pageMarginLeft"/></xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageMarginRight">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageMarginRight">
        <xsl:value-of select="report/pageSetup/pageMarginRight"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageMarginTop">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageMarginTop">
        <xsl:value-of select="report/pageSetup/pageMarginTop"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageMarginBottom">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageMarginBottom">
        <xsl:value-of select="report/pageSetup/pageMarginBottom"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageLeaderMarginLeft">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageLeaderMarginLeft">
        <xsl:value-of select="report/pageSetup/pageLeaderMarginLeft"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageLeaderMarginRight">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageLeaderMarginRight">
        <xsl:value-of select="report/pageSetup/pageLeaderMarginRight"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageLeaderMarginTop">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageLeaderMarginTop">
        <xsl:value-of select="report/pageSetup/pageLeaderMarginTop"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageLeaderMarginBottom">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageLeaderMarginBottom">
        <xsl:value-of select="report/pageSetup/pageLeaderMarginBottom"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageWidth">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageWidth">
        <xsl:value-of select="report/pageSetup/pageWidth"/>
      </xsl:when>
      <xsl:otherwise>21.0058</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pageHeight">
    <xsl:choose>
      <xsl:when test="report/pageSetup/pageHeight">
        <xsl:value-of select="report/pageSetup/pageHeight"/>
      </xsl:when>
      <xsl:otherwise>29.6926</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="footerHeight">
    <xsl:choose>
      <xsl:when test="report/pageSetup/footerHeight">
        <xsl:value-of select="report/pageSetup/footerHeight"/>
      </xsl:when>
      <xsl:otherwise>3</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="footerLeaderHeight">
    <xsl:choose>
      <xsl:when test="report/pageSetup/footerLeaderHeight">
        <xsl:value-of select="report/pageSetup/footerLeaderHeight"/>
      </xsl:when>
      <xsl:otherwise>3</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="nestedDataTablePadding">
    <xsl:choose>
      <xsl:when test="report/pageSetup/nestedDataTablePadding">
        <xsl:value-of select="report/pageSetup/nestedDataTablePadding"/>
      </xsl:when>
      <xsl:otherwise>0.5</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="showAutoFooter">
    <xsl:choose>
      <xsl:when test="report/pageSetup/showAutoFooter">
        <xsl:value-of select="report/pageSetup/showAutoFooter"/>
      </xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="pageFontSize" select="10" />

  <!-- figure out content height and width -->
  <xsl:variable name="contentWidthPortrait" select="$pageWidth - $pageMarginLeft - $pageMarginRight" />
  <xsl:variable name="contentHeightPortrait" select="$pageHeight - $pageMarginTop - $pageMarginBottom - $footerHeight" />
  <xsl:variable name="contentWidthLandscape" select="$pageHeight - $pageMarginLeft - $pageMarginRight" />
  <xsl:variable name="contentHeightLandscape" select="$pageWidth - $pageMarginTop - $pageMarginBottom - $footerHeight" />
  <!-- leader page height and width -->
  <xsl:variable name="contentWidthPortraitLeader" select="$pageWidth - $pageLeaderMarginLeft - $pageLeaderMarginRight" />
  <xsl:variable name="contentHeightPortraitLeader" select="$pageHeight - $pageLeaderMarginTop - $pageLeaderMarginBottom - $footerLeaderHeight" />
  <xsl:variable name="contentWidthLandscapeLeader" select="$pageHeight - $pageLeaderMarginLeft - $pageLeaderMarginRight" />
  <xsl:variable name="contentHeightLandscapeLeader" select="$pageWidth - $pageLeaderMarginTop - $pageLeaderMarginBottom - $footerLeaderHeight" />

  <!-- set up the fo:root element and the fo page layouts -->
  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>

      <!-- Portrait -->
      <!-- Leader -->
      <fo:simple-page-master master-name="portraitPageLeader"
        page-height="{$pageHeight}cm"
        page-width="{$pageWidth}cm"
        margin-left="{$pageLeaderMarginLeft}cm"
        margin-right="{$pageLeaderMarginRight}cm"
        margin-top="{$pageLeaderMarginTop}cm"
        margin-bottom="0cm"
      >
        <fo:region-body region-name="xsl-region-body" margin-bottom="{$footerLeaderHeight}cm" />
        <fo:region-before region-name="xsl-region-before" extent="0cm" />
        <fo:region-after region-name="xsl-region-after" extent="{$footerLeaderHeight}cm" />
        </fo:simple-page-master>
        <!-- Follower -->
        <fo:simple-page-master master-name="portraitPageFollower"
          page-height="{$pageHeight}cm"
          page-width="{$pageWidth}cm"
          margin-left="{$pageMarginLeft}cm"
          margin-right="{$pageMarginRight}cm"
          margin-top="{$pageMarginTop}cm"
          margin-bottom="0cm"
        >
          <fo:region-body region-name="xsl-region-body" margin-bottom="{$footerHeight}cm" />
          <fo:region-before region-name="xsl-region-before" extent="0cm" />
          <fo:region-after region-name="xsl-region-after" extent="{$footerHeight}cm" />
        </fo:simple-page-master>


        <!-- Landscape -->
        <!-- Leader -->
        <fo:simple-page-master master-name="landscapePageLeader"
          page-height="{$pageHeight}cm"
          page-width="{$pageWidth}cm"
          margin-left="{$pageLeaderMarginTop}cm"
          margin-right="0cm"
          margin-top="{$pageLeaderMarginLeft}cm"
          margin-bottom="{$pageLeaderMarginRight}cm"
          reference-orientation="90"
        >
          <fo:region-body region-name="xsl-region-body" margin-bottom="{$footerLeaderHeight}cm" />
          <fo:region-before region-name="xsl-region-before" extent="0cm" />
          <fo:region-after region-name="xsl-region-after" extent="{$footerLeaderHeight}cm" />
        </fo:simple-page-master>
        <!-- Follower -->
        <fo:simple-page-master master-name="landscapePageFollower"
          page-height="{$pageHeight}cm"
          page-width="{$pageWidth}cm"
          margin-left="{$pageMarginTop}cm"
          margin-right="0cm"
          margin-top="{$pageMarginLeft}cm"
          margin-bottom="{$pageMarginRight}cm"
          reference-orientation="90"
        >
          <fo:region-body region-name="xsl-region-body" margin-bottom="{$footerHeight}cm" />
          <fo:region-before region-name="xsl-region-before" extent="0cm" />
          <fo:region-after region-name="xsl-region-after" extent="{$footerHeight}cm" />
        </fo:simple-page-master>

        <!-- A sequence of portrait pages, leader and follower -->
        <fo:page-sequence-master master-name="portraitPageSequence">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference master-reference="portraitPageLeader" page-position="first" />
          </fo:repeatable-page-master-alternatives>
          <fo:repeatable-page-master-reference master-reference="portraitPageFollower" />
        </fo:page-sequence-master>

        <!-- A sequence of portrait pages, all followers -->
        <fo:page-sequence-master master-name="portraitPageSequenceAllFollowers">
          <fo:repeatable-page-master-reference master-reference="portraitPageFollower" />
        </fo:page-sequence-master>

        <!-- A sequence of landscape pages -->
        <fo:page-sequence-master master-name="landscapePageSequence">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference master-reference="landscapePageLeader" page-position="first" />
          </fo:repeatable-page-master-alternatives>
          <fo:repeatable-page-master-reference master-reference="landscapePageFollower" />
        </fo:page-sequence-master>

        <!-- A sequence of landscape pages, all followers -->
        <fo:page-sequence-master master-name="landscapePageSequenceAllFollowers">
          <fo:repeatable-page-master-reference master-reference="landscapePageFollower" />
        </fo:page-sequence-master>
      </fo:layout-master-set>

      <!-- page sequences are contained in pageSequence tags -->
      <xsl:for-each select="report/content/pageSequence">
        <fo:page-sequence>
          <xsl:attribute name="master-reference">
            <!-- figure out which page sequence master to use:
            orientation := 'landscape'|'portrait'(def)
            sequence := 'normal'(def)|'follower'
            -->
            <xsl:choose>
              <xsl:when test="@orientation='landscape'">landscapePageSequence<xsl:if test="@sequence='follower'">AllFollowers</xsl:if></xsl:when>
              <xsl:otherwise>portraitPageSequence<xsl:if test="@sequence='follower'">AllFollowers</xsl:if></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <!-- if the pageSequence has a font-family or font-size, use that, otherwise use report settings -->
          <xsl:choose>
            <xsl:when test="@font-family">
              <xsl:attribute name="font-family">
                <xsl:value-of select="@font-family" />
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="/report/@font-family">
              <xsl:attribute name="font-family">
                <xsl:value-of select="/report/@font-family" />
              </xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <xsl:attribute name="font-size">
            <xsl:choose>
              <xsl:when test="@font-size">
                <xsl:value-of select="@font-size" />
              </xsl:when>
              <xsl:when test="/report/@font-size">
                <xsl:value-of select="/report/@font-size" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$pageFontSize" />
                <xsl:text>pt</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>

          <!-- Footer -->
          <fo:static-content flow-name="xsl-region-after">
            <!-- <pageSequence>...<pageFooter>..</pageFooter>...</pageSequence> -->
            <!-- this is for simple text that can change from page to page -->
            <fo:block>
              <fo:retrieve-marker retrieve-class-name="pageFooter" retrieve-position="first-starting-within-page" retrieve-boundary="page" />
            </fo:block>
            <!-- global setting $showAutoFooter -->
            <xsl:if test="$showAutoFooter='true'">
              <fo:block font-size="8pt" text-align="center">
                <fo:block>
                  <xsl:value-of select="/report/title/." />
                </fo:block>
                <fo:block>
                  <xsl:text>Page </xsl:text><fo:page-number />
                </fo:block>
              </fo:block>
            </xsl:if>
            <!-- <pageSequence>...<footer>..</footer>...</pageSequence> -->
            <!-- This is a more complex footer that is used on each page. If pageSequence/footer is not defined, falls back
            on report/footer, otherwise not used -->
            <xsl:choose>
              <xsl:when test="footer">
                <xsl:for-each select="footer">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:when>
              <xsl:when test="/report/footer">
                <xsl:for-each select="/report/footer">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:when>
            </xsl:choose>
          </fo:static-content>

          <!-- Now the content of each pageSequence -->
          <fo:flow flow-name="xsl-region-body">
            <fo:table>
              <fo:table-column column-width="100%" />
              <fo:table-body>
                <xsl:apply-templates />
              </fo:table-body>
            </fo:table>
          </fo:flow>
        </fo:page-sequence>
      </xsl:for-each>
    </fo:root>
  </xsl:template>

  <!-- ignore footer tags (this is for pageSequence/footer tags, they are processed elsewhere, if they aren't ignored here 
  their content is included in the page sequence -->
  <xsl:template match="footer"></xsl:template>

  <!-- grabs a pageFooter tag and converts it into a fo:marker -->
  <xsl:template match="pageFooter">
    <fo:marker marker-class-name="pageFooter">
      <xsl:apply-templates />
    </fo:marker>
  </xsl:template>

  <!-- insert a special value -->
  <xsl:template match="insertSpecial">
    <xsl:choose>
      <xsl:when test="@value='pageNumber'">
        <fo:page-number />
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- wraps in a block that will page break when it closes -->
  <xsl:template match="page">
    <xsl:apply-templates />
    <fo:table-row break-before="page">
      <fo:table-cell>
        <fo:block></fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <!-- This is a simple vertical spacer -->
  <xsl:template match="vspacer">
    <fo:block>
      <xsl:attribute name="space-after">
        <xsl:value-of select="@height" />
      </xsl:attribute>
    </fo:block>
  </xsl:template>

  <xsl:template match="contentBlock|htmlBlock">
    <fo:table-row keep-with-next="always">
      <fo:table-cell>
        <xsl:call-template name="set-alignment"/>
        <xsl:call-template name="set-block-styles"/>
        <xsl:apply-templates />
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <!-- template to the align attribute in several HTML elements -->
  <xsl:template name="set-alignment">
    <xsl:choose>
      <xsl:when test="@align='left'">
        <xsl:attribute name="text-align">start</xsl:attribute>
      </xsl:when>
      <xsl:when test="@align='center'">
        <xsl:attribute name="text-align">center</xsl:attribute>
      </xsl:when>
      <xsl:when test="@align='right'">
        <xsl:attribute name="text-align">end</xsl:attribute>
      </xsl:when>
      <xsl:when test="@align='justify'">
        <xsl:attribute name="text-align">justify</xsl:attribute>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- template to set various block level styles (used in td and th ATM) -->
  <xsl:template name="set-block-styles">
    <xsl:if test="@colspan">
      <xsl:attribute name="number-columns-spanned">
        <xsl:value-of select="@colspan" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@rowspan">
      <xsl:attribute name="number-rows-spanned">
        <xsl:value-of select="@rowspan" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@background-color">
      <xsl:attribute name="background-color">
        <xsl:value-of select="@background-color" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@color">
      <xsl:attribute name="color">
        <xsl:value-of select="@color" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@height">
      <xsl:attribute name="height">
        <xsl:value-of select="@height" />
      </xsl:attribute>
    </xsl:if>
    <!-- simplified borders -->
    <xsl:if test="@border='true'">
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-top='true'">
      <xsl:attribute name="border-top-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-left='true'">
      <xsl:attribute name="border-left-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-bottom='true'">
      <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-right='true'">
      <xsl:attribute name="border-right-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    </xsl:if>
    <!-- custom borders -->
    <xsl:if test="@border-top-style">
      <xsl:attribute name="border-top-style">
        <xsl:value-of select="@border-top-style" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-top-width">
      <xsl:attribute name="border-top-width">
        <xsl:value-of select="@border-top-width" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-top-color">
      <xsl:attribute name="border-top-color">
        <xsl:value-of select="@border-top-color" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-left-style">
      <xsl:attribute name="border-left-style">
        <xsl:value-of select="@border-left-style" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-left-width">
      <xsl:attribute name="border-left-width">
        <xsl:value-of select="@border-left-width" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-left-color">
      <xsl:attribute name="border-left-color">
        <xsl:value-of select="@border-left-color" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-bottom-style">
      <xsl:attribute name="border-bottom-style">
        <xsl:value-of select="@border-bottom-style" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-bottom-width">
      <xsl:attribute name="border-bottom-width">
        <xsl:value-of select="@border-bottom-width" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-bottom-color">
      <xsl:attribute name="border-bottom-color">
        <xsl:value-of select="@border-bottom-color" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-right-style">
      <xsl:attribute name="border-right-style">
        <xsl:value-of select="@border-right-style" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-right-width">
      <xsl:attribute name="border-right-width">
        <xsl:value-of select="@border-right-width" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-right-color">
      <xsl:attribute name="border-right-color">
        <xsl:value-of select="@border-right-color" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-style">
      <xsl:attribute name="border-top-style">
        <xsl:value-of select="@border-style" />
      </xsl:attribute>
      <xsl:attribute name="border-right-style">
        <xsl:value-of select="@border-style" />
      </xsl:attribute>
      <xsl:attribute name="border-bottom-style">
        <xsl:value-of select="@border-style" />
      </xsl:attribute>
      <xsl:attribute name="border-left-style">
        <xsl:value-of select="@border-style" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-width">
      <xsl:attribute name="border-top-width">
        <xsl:value-of select="@border-width" />
      </xsl:attribute>
      <xsl:attribute name="border-right-width">
        <xsl:value-of select="@border-width" />
      </xsl:attribute>
      <xsl:attribute name="border-bottom-width">
        <xsl:value-of select="@border-width" />
      </xsl:attribute>
      <xsl:attribute name="border-left-width">
        <xsl:value-of select="@border-width" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border-color">
      <xsl:attribute name="border-top-color">
        <xsl:value-of select="@border-color" />
      </xsl:attribute>
      <xsl:attribute name="border-right-color">
        <xsl:value-of select="@border-color" />
      </xsl:attribute>
      <xsl:attribute name="border-bottom-color">
        <xsl:value-of select="@border-color" />
      </xsl:attribute>
      <xsl:attribute name="border-left-color">
        <xsl:value-of select="@border-color" />
      </xsl:attribute>
    </xsl:if>
    <!-- padding -->
    <xsl:if test="@padding-top">
      <xsl:attribute name="padding-top">
        <xsl:value-of select="@padding-top" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@padding-left">
      <xsl:attribute name="padding-left">
        <xsl:value-of select="@padding-left" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@padding-bottom">
      <xsl:attribute name="padding-bottom">
        <xsl:value-of select="@padding-bottom" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@padding-right">
      <xsl:attribute name="padding-right">
        <xsl:value-of select="@padding-right" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@padding">
      <xsl:attribute name="padding-top">
        <xsl:value-of select="@padding" />
      </xsl:attribute>
      <xsl:attribute name="padding-left">
        <xsl:value-of select="@padding" />
      </xsl:attribute>
      <xsl:attribute name="padding-bottom">
        <xsl:value-of select="@padding" />
      </xsl:attribute>
      <xsl:attribute name="padding-right">
        <xsl:value-of select="@padding" />
      </xsl:attribute>
    </xsl:if>
    <!-- font -->
    <xsl:if test="@font-family">
      <xsl:attribute name="font-family">
        <xsl:value-of select="@font-family" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@font-size">
      <xsl:attribute name="font-size">
        <xsl:value-of select="@font-size" />
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@font-weight">
      <xsl:attribute name="font-weight">
        <xsl:value-of select="@font-weight"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@font-style">
      <xsl:attribute name="font-style">
        <xsl:value-of select="@font-style"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@text-decoration">
      <xsl:attribute name="text-decoration">
        <xsl:value-of select="@text-decoration"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- blockquote -->
  <xsl:template match="blockquote">
    <fo:block
      space-before="6pt"
      space-after="6pt"
      start-indent="1em"
      end-indent="1em"
    >
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


  <!-- h1 -->
  <xsl:template match="h1">
    <fo:block font-weight="bold" space-after="0em">
      <xsl:attribute name="space-before">
        <xsl:choose>
          <xsl:when test="@space-before">
            <xsl:value-of select="@space-before" />
          </xsl:when>
          <xsl:otherwise>0.67em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="space-after">
        <xsl:choose>
          <xsl:when test="@space-after">
            <xsl:value-of select="@space-after" />
          </xsl:when>
          <xsl:otherwise>1em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="font-size">
        <xsl:choose>
          <xsl:when test="@font-size">
            <xsl:value-of select="@font-size" />
          </xsl:when>
          <xsl:otherwise>2em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>

      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- h2 -->
  <xsl:template match="h2">
    <fo:block font-size="1.5em" font-weight="bold" space-before="0.83em">
      <xsl:attribute name="space-before">
        <xsl:choose>
          <xsl:when test="@space-before">
            <xsl:value-of select="@space-before" />
          </xsl:when>
          <xsl:otherwise>0.83em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="space-after">
        <xsl:choose>
          <xsl:when test="@space-after">
            <xsl:value-of select="@space-after" />
          </xsl:when>
          <xsl:otherwise>1em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>

      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- h3 -->
  <xsl:template match="h3">
    <fo:block font-size="1.17em" font-weight="bold" space-before="1em">
      <xsl:attribute name="space-before">
        <xsl:choose>
          <xsl:when test="@space-before">
            <xsl:value-of select="@space-before" />
          </xsl:when>
          <xsl:otherwise>1em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="space-after">
      <xsl:choose>
        <xsl:when test="@space-after">
          <xsl:value-of select="@space-after" />
        </xsl:when>
        <xsl:otherwise>1em</xsl:otherwise>
      </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>

      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- h4 -->
  <xsl:template match="h4">
    <fo:block font-weight="bold" space-after="1.33em">
      <xsl:attribute name="space-before">
      <xsl:choose>
        <xsl:when test="@space-before">
          <xsl:value-of select="@space-before" />
        </xsl:when>
        <xsl:otherwise>1.67em</xsl:otherwise>
      </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="space-after">
        <xsl:choose>
          <xsl:when test="@space-after">
            <xsl:value-of select="@space-after" />
          </xsl:when>
          <xsl:otherwise>1em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>

      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- h5 -->
  <xsl:template match="h5">
    <fo:block font-size="0.83em" font-weight="bold" space-after="1.67em">
      <xsl:attribute name="space-before">
        <xsl:choose>
          <xsl:when test="@space-before">
        <xsl:value-of select="@space-before" />
        </xsl:when>
        <xsl:otherwise>1.67em</xsl:otherwise>
      </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="space-after">
      <xsl:choose>
        <xsl:when test="@space-after">
          <xsl:value-of select="@space-after" />
        </xsl:when>
        <xsl:otherwise>1em</xsl:otherwise>
      </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>

      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- h6 -->
  <xsl:template match="h6">
    <fo:block font-size="0.67em" font-weight="bold" space-after="2.33em">
      <xsl:attribute name="space-before">
        <xsl:choose>
          <xsl:when test="@space-before">
            <xsl:value-of select="@space-before" />
          </xsl:when>
          <xsl:otherwise>2.33em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="space-after">
        <xsl:choose>
          <xsl:when test="@space-after">
            <xsl:value-of select="@space-after" />
          </xsl:when>
          <xsl:otherwise>1em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>

      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


  <xsl:template match="div">
    <fo:block>
      <xsl:call-template name="set-block-styles"/>
      <xsl:if test="@class='bordered'">
        <xsl:attribute name="border-width">1pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- span -->
  <xsl:template match="span">
    <fo:inline>
      <xsl:call-template name="set-block-styles"/>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- paragraph (p) -->
  <xsl:template match="p">
    <fo:block space-before="0em" space-after="1.33em">
      <xsl:call-template name="set-alignment"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="ol">
    <fo:list-block
      provisional-distance-between-starts="10mm"
      provisional-label-separation="1mm"
      space-before="1.33em"
      space-after="1.33em"
    >
      <xsl:apply-templates />
    </fo:list-block>
  </xsl:template>

  <xsl:template match="ol/li">
    <fo:list-item space-after="1mm">
      <fo:list-item-label start-indent="5mm">
        <fo:block>
          <xsl:choose>
            <xsl:when test="../@type != ''">
              <xsl:number format="{../@type}"/>
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:number format="1"/>
              <xsl:text>.</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="10mm">
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <!-- Unordered list -->
  <xsl:template match="ul">
    <fo:list-block
      provisional-distance-between-starts="10mm"
      provisional-label-separation="1mm"
      space-before="0em"
      space-after="1.33em"
    >
      <xsl:apply-templates/>
    </fo:list-block>
  </xsl:template>

  <!-- Unordered list item -->
  <xsl:template match="ul/li">
    <fo:list-item space-after="1mm">
      <fo:list-item-label start-indent="5mm">
        <xsl:choose>
          <xsl:when test="../@type ='disc'">
            <fo:block>&#x2022;</fo:block>
          </xsl:when>
          <xsl:when test="../@type='square'">
            <fo:block font-family="ZapfDingbats">&#110;</fo:block>
          </xsl:when>
          <xsl:when test="../@type='circle'">
            <fo:block font-family="ZapfDingbats">&#109;</fo:block>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="count(ancestor::ul) = 1">
                <fo:block>&#x2022;</fo:block>
              </xsl:when>
              <xsl:when test="count(ancestor::ul) = 2">
                <fo:block font-family="ZapfDingbats">&#109;</fo:block>
              </xsl:when>
              <xsl:otherwise>
                <fo:block font-family="ZapfDingbats">&#110;</fo:block>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </fo:list-item-label>
      <fo:list-item-body>
        <fo:block start-indent="10mm">
          <xsl:apply-templates />
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="dl">
    <fo:block space-before="6pt" space-after="6pt">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <xsl:template match="dt">
    <fo:block>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <xsl:template match="dd">
    <fo:block start-indent="5mm">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <!-- Table, must use tbody, thead and tfooter to contain rows rather than directly -->
  <!-- I added the keep-together="always" attribute but NFOP (and more generally FOP) doesn't support it's use,
  there are workarounds involving adding keep-together-with-next to all rows but the last which would be easy if
  the transformation between XRPT to XSL-FO were done in code, but this is XSLT, going to have to suffer with broken
  tables for now 

  type := { '', 'DataGrid', 'DataGridPas2' }
  Both data grid styles have the same font & padding etc, DataGrid has lines on every cell border while DataGridPas2 only has a rule on the
  top and bottom of the header and footer rows (Pas v2 compatibility).

  Nested tables are padded left and right by $nestedDataTablePadding in cm, unless the table.ignorenesting attribute is set to 'true',
  this allows auto padding of nested tables which helps for nested tree structures (but can be annoying)
  -->
  <xsl:template match="table">
    <xsl:choose>
      <xsl:when test="count(ancestor::table) != 0 and @ignorenesting!='true'">
        <!-- this is an embedded table, so embed it in another table to pad the left & right sides -->
        <fo:table>
          <fo:table-column>
            <xsl:attribute name="column-width">
              <xsl:choose>
                <xsl:when test="count(ancestor::table) != 0 and @ignorenesting!='true'">
                  <xsl:value-of select="$nestedDataTablePadding" />
                  <xsl:text>cm</xsl:text>
                </xsl:when>
                <xsl:otherwise>0em</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </fo:table-column>
          <fo:table-column></fo:table-column>
          <fo:table-column>
            <xsl:attribute name="column-width">
              <xsl:choose>
                <xsl:when test="count(ancestor::table) != 0 and @ignorenesting!='true'">
                  <xsl:value-of select="$nestedDataTablePadding" />
                  <xsl:text>cm</xsl:text>
                </xsl:when>
                <xsl:otherwise>0em</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </fo:table-column>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell>
                <fo:block />
              </fo:table-cell>
              <fo:table-cell>

                <fo:table>
                  <xsl:choose>
                    <xsl:when test="@type='DataGrid' or @type='DataGridPas2'">
                      <xsl:attribute name="margin-bottom">
                        <xsl:value-of select="$pageFontSize" />
                        <xsl:text>pt</xsl:text>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="@keep-together='always'">
                      <xsl:attribute name="keep-together">always</xsl:attribute>
                    </xsl:when>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="@type='DataGrid'">
                      <xsl:attribute name="border-top-style">solid</xsl:attribute>
                      <xsl:attribute name="border-left-style">solid</xsl:attribute>
                      <xsl:attribute name="border-width">0.5pt</xsl:attribute>
                    </xsl:when>
                  </xsl:choose>
                  <xsl:call-template name="set-block-styles" />
                  <xsl:call-template name="set-alignment"/>
                  <xsl:apply-templates />
                </fo:table>

              </fo:table-cell>
              <fo:table-cell>
                <fo:block />
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </xsl:when>
      <xsl:otherwise>

        <!-- not an embedded table -->
        <fo:table>
          <xsl:choose>
            <xsl:when test="@type='DataGrid' or @type='DataGridPas2'">
              <xsl:attribute name="margin-bottom">
                <xsl:value-of select="$pageFontSize" />
                <xsl:text>pt</xsl:text>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="@keep-together='always'">
              <xsl:attribute name="keep-together">always</xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="@type='DataGrid'">
              <xsl:attribute name="border-top-style">solid</xsl:attribute>
              <xsl:attribute name="border-left-style">solid</xsl:attribute>
              <xsl:attribute name="border-width">0.5pt</xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <xsl:call-template name="set-alignment"/>
          <xsl:call-template name="set-block-styles" />
          <xsl:apply-templates />
        </fo:table>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Table columns, specify the width of the columns -->
  <xsl:template match="col">
    <!-- write the column -->
    <fo:table-column>
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:attribute name="column-width">
            <xsl:choose>
              <!-- if width is a %, set the width to (@width/100 * (content width - (#of ancestor tables-1)*2*nested data table padding))).
              # of ancestor tables is reduced by one because this col tag is within its table -->
              <xsl:when test="contains(@width, '%')">
                <xsl:choose>
                  <!-- landscape -->
                  <xsl:when test="ancestor::pageSequence/@orientation='landscape'">
                    <xsl:choose>
                      <xsl:when test="ancestor::pageSequence/@sequence='leader'">
                        <!-- leader -->
                        <xsl:value-of select="number(translate(@width,'%','')) div 100 * ($contentWidthLandscapeLeader - ((count(ancestor::table)-1) * 2 * $nestedDataTablePadding))"/>
                        <xsl:text>cm</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- normal -->
                        <xsl:value-of select="number(translate(@width,'%','')) div 100 * ($contentWidthLandscape - ((count(ancestor::table)-1) * 2 * $nestedDataTablePadding))"/>
                        <xsl:text>cm</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <!-- portrait -->
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="ancestor::pageSequence/@sequence='leader'">
                        <!-- leader -->
                        <xsl:value-of select="number(translate(@width,'%','')) div 100 * ($contentWidthPortraitLeader - ((count(ancestor::table)-1) * 2 * $nestedDataTablePadding))"/>
                        <xsl:text>cm</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- normal -->
                        <xsl:value-of select="number(translate(@width,'%','')) div 100 * ($contentWidthPortrait - ((count(ancestor::table)-1) * 2 * $nestedDataTablePadding))"/>
                        <xsl:text>cm</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <!-- if width is a number (no units) assume width in 1/72" (a pixel @ 72dpi) -->
              <xsl:when test="@width &lt;= 0 or @width >= 0">
                <xsl:value-of select="floor(@width div 72)"/>
                <xsl:text>in</xsl:text>
              </xsl:when>
              <!-- otherwise just drop the width value straight in -->
              <xsl:otherwise>
                <xsl:value-of select="@width"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
    </fo:table-column>
  </xsl:template>

  <!-- table headers, this appears on each page -->
  <xsl:template match="thead">
    <fo:table-header>
      <xsl:apply-templates />
    </fo:table-header>
  </xsl:template>

  <!-- table body -->
  <xsl:template match="tbody">
    <fo:table-body>
      <xsl:apply-templates />
    </fo:table-body>
  </xsl:template>

  <!-- table footer. Apparently in XSL-FO the header AND footer must appear before the body. And I think the footer is used on each page
  anyway. So I'm just putting the footer in a table-body block -->
  <xsl:template match="tfoot">
    <fo:table-body>
      <xsl:apply-templates />
    </fo:table-body>
  </xsl:template>

  <!-- a table row -->
  <xsl:template match="tr">
    <fo:table-row>
      <xsl:apply-templates/>
    </fo:table-row>
  </xsl:template>

  <!-- th, table header cell -->
  <xsl:template match="th">
    <fo:table-cell font-weight="bold" text-align="center">
      <!-- only draw auto borders if none of border or border-xxx have been given in the <th> -->
      <xsl:if test="not(@border or @border-top or @border-left or @border-bottom or @border-right)">
        <xsl:if test="ancestor::table/@type='DataGrid'">
          <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
          <xsl:attribute name="border-right-style">solid</xsl:attribute>
          <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        </xsl:if>
        <!-- only draw borders in pas2 grids if in the head or foot -->
        <xsl:if test="ancestor::table/@type='DataGridPas2'">
          <xsl:attribute name="border-top-style">solid</xsl:attribute>
          <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
          <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:call-template name="set-block-styles" />

      <fo:block>
        <xsl:call-template name="set-alignment" />
        <!-- if the containing table has a font-size attribute use that otherwise if this is a datagrid set to 95% of normal -->
        <xsl:choose>
          <xsl:when test="ancestor::table/@font-size">
            <xsl:attribute name="font-size">
              <xsl:value-of select="ancestor::table/@font-size" />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="ancestor::table/@type='DataGrid' or ancestor::table/@type='DataGridPas2'">
              <!-- <xsl:attribute name="font-size"><xsl:value-of select="$pageFontSize * 0.8" />pt</xsl:attribute> -->
              <xsl:attribute name="font-size">95%</xsl:attribute>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="@start-indent">
          <xsl:attribute name="start-indent">
            <xsl:value-of select="@start-indent" />
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@end-indent">
          <xsl:attribute name="end-indent">
            <xsl:value-of select="@end-indent" />
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <!-- td, table cell -->
  <xsl:template match="td">
    <fo:table-cell>
      <!-- only draw auto borders if none of border or border-xxx have been given in the <th> -->
      <xsl:if test="not(@border or @border-top or @border-left or @border-bottom or @border-right)">
        <xsl:if test="ancestor::table/@type='DataGrid'">
          <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
          <xsl:attribute name="border-right-style">solid</xsl:attribute>
          <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:call-template name="set-block-styles" />
      <fo:block>
        <xsl:call-template name="set-alignment" />
        <!-- if the containing table has a font-size attribute use that otherwise if this is a datagrid set to 95% of normal -->
        <xsl:choose>
          <xsl:when test="ancestor::table/@font-size">
            <xsl:attribute name="font-size">
              <xsl:value-of select="ancestor::table/@font-size" />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="ancestor::table/@type='DataGrid' or ancestor::table/@type='DataGridPas2'">
              <!-- <xsl:attribute name="font-size"><xsl:value-of select="$pageFontSize * 0.8" />pt</xsl:attribute> -->
              <xsl:attribute name="font-size">95%</xsl:attribute>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@start-indent">
          <xsl:attribute name="start-indent">
            <xsl:value-of select="@start-indent" />
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@end-indent">
          <xsl:attribute name="end-indent">
            <xsl:value-of select="@end-indent" />
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <xsl:template match="tt">
    <fo:inline font-family="monospace">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="caption">
    <fo:caption>
      <fo:block>
        <xsl:apply-templates />
      </fo:block>
    </fo:caption>
  </xsl:template>
  
  <!-- external anchor -->
  <xsl:template match="a">
    <xsl:comment>anchor</xsl:comment>
    <fo:basic-link color="blue" text-decoration="underline">
      <xsl:attribute name="external-destination">url('<xsl:value-of select="@href"/>')</xsl:attribute>
      <xsl:apply-templates/>
    </fo:basic-link>
    <xsl:comment>/anchor</xsl:comment>
  </xsl:template>

  <!-- img -->
  <!-- PNG and JPEG have been tested, either as remote URLs or base64 encoded url -->
  <xsl:template match="img">
    <xsl:comment>img</xsl:comment>
    <fo:block>
      <fo:external-graphic>
      <xsl:call-template name="set-block-styles"/>
        <xsl:attribute name="src">url('<xsl:value-of select="@src"/>')</xsl:attribute>
        <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
        <xsl:call-template name="tpl-property-scaling"/>
        <xsl:call-template name="tpl-height-width"/>
      </fo:external-graphic>
    </fo:block>
    <xsl:comment>/img</xsl:comment>
  </xsl:template>

  <!-- svg either with a src="url" attribute or embedded SVG markup -->
  <!-- Note that embedded markup doesn't actually work. Crispin works around this
  by preprocessing embedded SVG markup into base64 encoded urls. -->
  <xsl:template match="svg">
    <xsl:comment>svg</xsl:comment>
    <fo:block>
      <xsl:choose>
        <xsl:when test="@src">
          <xsl:comment>svg with src</xsl:comment>
          <fo:external-graphic>
            <xsl:call-template name="set-block-styles"/>
            <xsl:attribute name="src">url('<xsl:value-of select="@src"/>')</xsl:attribute>
            <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
            <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
            <xsl:call-template name="tpl-property-scaling"/>
            <xsl:call-template name="tpl-height-width"/>
          </fo:external-graphic>
          <xsl:comment>/svg with src</xsl:comment>
        </xsl:when>
        <xsl:otherwise>
          <fo:instream-foreign-object>
            <xsl:copy-of select="."/>
          </fo:instream-foreign-object>
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
    <xsl:comment>/svg</xsl:comment>
  </xsl:template>

  <xsl:template name="tpl-property-scaling">
    <!-- scaling="[uniform | non-uniform | inherit]", default "uniform", http://www.w3.org/TR/xsl/#scaling -->
    <xsl:attribute name="scaling">
      <xsl:choose>
        <xsl:when test="@scaling">
          <xsl:value-of select="@scaling"/>
        </xsl:when>
        <xsl:otherwise>uniform</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="tpl-height-width">
    <!-- If the img tag uses width and height, assume that it's html-like px -->
    <xsl:if test="@width">
      <xsl:attribute name="content-width">
        <xsl:value-of select="@width"/>
        <xsl:text>px</xsl:text>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@height">
      <xsl:attribute name="content-height">
        <xsl:value-of select="@height"/>
        <xsl:text>px</xsl:text>
      </xsl:attribute>
    </xsl:if>

    <!-- If the img tag uses content-width and content-height, assume that it includes the units like nice CSS or XSL-FO -->
    <xsl:if test="@content-width">
      <xsl:attribute name="content-width">
        <xsl:value-of select="@content-width"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@content-height">
      <xsl:attribute name="content-height">
        <xsl:value-of select="@content-height"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template match="pre">
    <fo:block white-space-collapse="false">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <!-- Strong or bold -->
  <xsl:template match="b|strong">
    <fo:inline font-weight="bold">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <!-- Italic or Emphasized -->
  <xsl:template match="i|em">
    <fo:inline font-style="italic">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <!-- Underline, ok so not really in HTML :-D -->
  <xsl:template match="underline">
    <fo:inline text-decoration="underline">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <!-- Del or strike -->
  <xsl:template match="del|strike">
    <fo:inline text-decoration="line-through">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <!-- small, reduces the font size to 7pt -->
  <xsl:template match="small">
    <fo:inline font-size="7pt">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <!-- subscript -->
  <xsl:template match="sub">
    <fo:inline alignment-adjust="2pt" font-size="70%">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <!-- superscript -->
  <xsl:template match="sup">
    <fo:inline alignment-adjust="-2pt" font-size="70%">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  
  <!-- code -->
  <xsl:template match="pre">
    <fo:inline font-family="monospace">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- horizontal rule -->
  <xsl:template match="hr">
    <fo:block>
      <fo:leader
        leader-pattern="rule"
        leader-length.optimum="100%"
      >
        <xsl:choose>
          <xsl:when test="@rule-style">
            <xsl:attribute name="rule-style">
              <xsl:value-of select="@rule-style" />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="rule-style">double</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="@rule-thickness">
            <xsl:attribute name="rule-thickness">
              <xsl:value-of select="@rule-thickness" />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="rule-thickness">1pt</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@color">
          <xsl:attribute name="color">
            <xsl:value-of select="@color" />
          </xsl:attribute>
        </xsl:if>
      </fo:leader>
    </fo:block>
  </xsl:template>

  <!-- Line break (br) -->
  <xsl:template match="br">
    <fo:block> </fo:block>
  </xsl:template>
</xsl:stylesheet>
