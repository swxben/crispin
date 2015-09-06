<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:output method="html" indent="yes" />

  <!-- This is the root node that generates the HTML -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="report/title" />
        </title>
        <style type="text/css">
          @media screen {
            body {
              background-color: gray;
              padding: 0;
              margin: 0;
            }
            div.pagePortrait {
              background-color: white;
              padding: 20px;
              margin: 20px auto;
              width: 750px;
              border: 1px solid black;
            }
            div.pageLandscape {
              background-color: white;
              padding: 20px;
              margin: 20px auto;
              width: 1060px;
              border: 1px solid black;
            }
          }

          div#Footer {
          }
          body, table {
            font-family: sans-serif;
            font-size: 10pt;
            color: black;
          }

          table.layoutTable { width: 100%; }
          table.dataGrid { width: 100%; }
          table.dataGridPas2 { width: 100%; }

          div.content {
          }
          div.contentBlock {
          }

          .bordered {
            border: 1px solid black;
          }
        </style>
      </head>
      <body>
        <xsl:for-each select="report/content/pageSequence">
          <div>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="@orientation='landscape'">pageLandscape</xsl:when>
                <xsl:otherwise>pagePortrait</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <!-- each page sequence has a unique id of pageSequenceX, which is used to have a distinct style per page sequence -->
            <xsl:attribute name="id">
              pageSequence<xsl:value-of select="position()" />
            </xsl:attribute>

            <style type="text/css">
              #pageSequence<xsl:value-of select="position()" />,
              #pageSequence<xsl:value-of select="position()" /> table {
              <xsl:if test="@font-family">
                font-family: <xsl:value-of select="@font-family" />;
              </xsl:if>
              <xsl:if test="@font-size">
                font-size: <xsl:value-of select="@font-size" />;
              </xsl:if>
              }
            </style>

            <xsl:apply-templates />

            <xsl:for-each select="footer">
              <div class="footer">
                <xsl:apply-templates />
              </div>
            </xsl:for-each>
            <xsl:for-each select="report/footer">
              <div class="footer">
                <xsl:apply-templates />
              </div>
            </xsl:for-each>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>


  <!-- TEMPLATES -->
  <!-- template to set the style -->
  <xsl:template name="set-style">
    <xsl:attribute name="style">
      <xsl:if test="@background-color">
        background-color: "<xsl:value-of select="@background-color" />";
      </xsl:if>
      <xsl:if test="@color">
        color: <xsl:value-of select="@color" />;
      </xsl:if>
      <xsl:if test="@height">
        height: <xsl:value-of select="@height" />;
      </xsl:if>
      <!-- alignment -->
      <xsl:if test="@align">
        text-align: <xsl:value-of select="@align" />;
      </xsl:if>

      <!-- borders -->
      <xsl:choose>
        <!-- only draw auto borders if none of border or border-xxx have been given in the <th> -->
        <xsl:when test="not(@border or @border-top or @border-left or @border-bottom or @border-right)">
          <xsl:if test="ancestor::table/@type='DataGrid'">
            border-bottom: 1px solid black; border-right: 1px solid black;
          </xsl:if>
          <!-- only draw borders in pas2 grids if in the head or foot -->
          <xsl:if test="ancestor::table/@type='DataGridPas2' and name()='th'">
            border-top: 1px solid black; border-bottom: 1px solid black;
          </xsl:if>
        </xsl:when>
        <!-- there are explicit borders -->
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="@border='true'">border: 1px solid black;</xsl:when>
            <xsl:otherwise>
              <xsl:if test="@border-top='true'">border-top: 1px solid black;</xsl:if>
              <xsl:if test="@border-left='true'">border-left: 1px solid black;</xsl:if>
              <xsl:if test="@border-bottom='true'">border-bottom: 1px solid black;</xsl:if>
              <xsl:if test="@border-right='true'">border-right: 1px solid black;</xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>

      <!-- font size & style -->
      <!-- if the containing table has a font-size attribute use that otherwise if this is a datagrid set to 95% of normal -->
      <xsl:choose>
        <xsl:when test="ancestor::table/@font-size">
          font-size: <xsl:value-of select="ancestor::table/@font-size" />;
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="ancestor::table/@type='DataGrid' or ancestor::table/@type='DataGridPas2'">
            font-size: 95%;
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@font-weight">
        font-weight: <xsl:value-of select="@font-weight"/>;
      </xsl:if>
      <xsl:if test="@font-style">
        font-style: <xsl:value-of select="@font-style"/>;
      </xsl:if>
      <xsl:if test="@text-decoration">
        text-decoration: <xsl:value-of select="@text-decoration"/>;
      </xsl:if>

      <!-- indent -->
      <xsl:if test="@start-indent">
        padding-left: <xsl:value-of select="@start-indent" />;
      </xsl:if>
      <xsl:if test="@end-indent">
        padding-right: <xsl:value-of select="@end-indent" />;
      </xsl:if>

      <!-- padding -->
      <xsl:if test="@padding-top">
        padding-top: <xsl:value-of select="@padding-top" />;
      </xsl:if>
      <xsl:if test="@padding-left">
        padding-left: <xsl:value-of select="@padding-left" />;
      </xsl:if>
      <xsl:if test="@padding-bottom">
        padding-bottom: <xsl:value-of select="@padding-bottom" />;
      </xsl:if>
      <xsl:if test="@padding-right">
        padding-right: <xsl:value-of select="@padding-right" />;
      </xsl:if>
      <xsl:if test="@padding">
        padding: <xsl:value-of select="@padding" />;
      </xsl:if>
    </xsl:attribute>
  </xsl:template>

  <!-- template to set the class (just copies the value) -->
  <xsl:template name="set-class">
    <xsl:if test="@class">
      <xsl:attribute name="class">
        <xsl:value-of select="@class" />
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- template to set the type (just copies the value) -->
  <xsl:template name="set-type">
    <xsl:if test="@type">
      <xsl:attribute name="type">
        <xsl:value-of select="@type" />
      </xsl:attribute>
    </xsl:if>
  </xsl:template>






  <!-- htmlBlock and contentBlock are treated the same, and are turned into divs with a class of contentBlock -->
  <xsl:template match="htmlBlock|contentBlock" >
    <div class="contentBlock">
      <xsl:attribute name="style">
        <xsl:if test="@align">
          text-align: <xsl:value-of select="@align" />;
        </xsl:if>
      </xsl:attribute>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </div>
  </xsl:template>


  <!-- ignore any footer elements found here, they are handled in the root element (above) -->
  <xsl:template match="footer"></xsl:template>



  <!-- TABLE -->
  <xsl:template match="table">
    <table cellpadding="0" cellspacing="0">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@type='DataGrid'">dataGrid</xsl:when>
          <xsl:when test="@type='DataGridPas2'">dataGridPas2</xsl:when>
          <xsl:otherwise>layoutTable</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates />
    </table>
    <br />
  </xsl:template>

  <!-- caption -->
  <xsl:template match="caption">
    <caption>
      <xsl:apply-templates />
    </caption>
  </xsl:template>

  <!-- col -->
  <xsl:template match="col">
    <col>
      <xsl:attribute name="width">
        <xsl:choose>
          <!-- width in percent, just use -->
          <xsl:when test="contains(@width, '%')">
            <xsl:value-of select="@width" />
          </xsl:when>
          <!-- otherwise assume width in 1/72", aka points -->
          <xsl:otherwise>
            <xsl:value-of select="@width" />pt
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </col>
  </xsl:template>

  <!-- thead -->
  <xsl:template match="thead">
    <thead>
      <xsl:apply-templates />
    </thead>
  </xsl:template>
  <!-- tbody -->
  <xsl:template match="tbody">
    <tbody>
      <xsl:apply-templates />
    </tbody>
  </xsl:template>
  <!-- tfoot -->
  <xsl:template match="tfoot">
    <tfoot>
      <xsl:apply-templates />
    </tfoot>
  </xsl:template>

  <!-- tr -->
  <xsl:template match="tr">
    <tr>
      <xsl:apply-templates />
    </tr>
  </xsl:template>

  <!-- th -->
  <xsl:template match="th">
    <th>
      <xsl:call-template name="set-style" />
      <xsl:if test="@colspan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@colspan" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </th>
  </xsl:template>

  <!-- td -->
  <xsl:template match="td">
    <td>
      <xsl:call-template name="set-style" />
      <xsl:if test="@colspan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@colspan" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </td>
  </xsl:template>





  <!-- insert a special value -->
  <xsl:template match="insertSpecial">
    <xsl:choose>
      <xsl:when test="@value='pageNumber'"></xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- page, ATM just adds a hr -->
  <xsl:template match="page">
    <xsl:apply-templates />
    <hr />
  </xsl:template>

  <!-- This is a simple vertical spacer -->
  <xsl:template match="vspacer">
    <span>
      <xsl:attribute name="style">
        display: block; height: <xsl:value-of select="@height" />
      </xsl:attribute>
    </span>
  </xsl:template>

  <!-- underline -->
  <xsl:template match="underline">
    <span style="text-decoration: underline">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- del -->
  <xsl:template match="del">
    <del>
      <xsl:apply-templates/>
    </del>
  </xsl:template>

  <!-- blockquote -->
  <xsl:template match="blockquote">
    <blockquote>
      <xsl:apply-templates/>
    </blockquote>
  </xsl:template>




  <!-- h1 -->
  <!-- The space-before attribute can be provided in the h1 tag now -->
  <xsl:template match="h1">
    <h1>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>

  <!-- h2 -->
  <xsl:template match="h2">
    <h2>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>

  <!-- h3 -->
  <xsl:template match="h3">
    <h3>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </h3>
  </xsl:template>

  <!-- h4 -->
  <xsl:template match="h4">
    <h4>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </h4>
  </xsl:template>

  <!-- h5 -->
  <xsl:template match="h5">
    <h5>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </h5>
  </xsl:template>

  <!-- h6 -->
  <xsl:template match="h6">
    <h6>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </h6>
  </xsl:template>

  <!-- div -->
  <xsl:template match="div">
    <div>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- span -->
  <xsl:template match="span">
    <span>
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- p -->
  <xsl:template match="p">
    <p>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-style"/>
      <xsl:apply-templates/>
    </p>
  </xsl:template>


  <!-- Lists -->
  <!-- ordered list -->
  <xsl:template match="ol">
    <ol>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-type" />
      <xsl:apply-templates />
    </ol>
  </xsl:template>
  <!-- Unordered list -->
  <xsl:template match="ul">
    <ul>
      <xsl:call-template name="set-class" />
      <xsl:call-template name="set-type" />
      <xsl:apply-templates />
    </ul>
  </xsl:template>
  <!-- list item -->
  <xsl:template match="li">
    <li>
      <xsl:call-template name="set-class" />
      <xsl:apply-templates />
    </li>
  </xsl:template>

  <!-- dl (definition list) -->
  <xsl:template match="dl">
    <dl>
      <xsl:call-template name="set-class" />
      <xsl:apply-templates />
    </dl>
  </xsl:template>
  <!-- dt (definition term) -->
  <xsl:template match="dt">
    <dt>
      <xsl:call-template name="set-class" />
      <xsl:apply-templates />
    </dt>
  </xsl:template>
  <!-- dd (definition) -->
  <xsl:template match="dd">
    <dd>
      <xsl:call-template name="set-class" />
      <xsl:apply-templates />
    </dd>
  </xsl:template>

  <!-- img -->
  <xsl:template match="img">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <!-- If the img tag uses width and height, assume that it's html-like px -->
      <xsl:if test="@width">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>px
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>px
        </xsl:attribute>
      </xsl:if>
      <!-- If the img tag uses content-width and content-height, assume that it includes the units like nice CSS or XSL-FO -->
      <xsl:if test="@content-width or @content-height">
        <xsl:attribute name="style">
          width:<xsl:value-of select="@content-width"/>;height:<xsl:value-of select="@content-height"/>
        </xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <!-- tt -->
  <xsl:template match="tt">
    <tt>
      <xsl:apply-templates />
    </tt>
  </xsl:template>

  <!-- pre -->
  <xsl:template match="pre">
    <pre>
      <xsl:apply-templates />
    </pre>
  </xsl:template>

  <!-- Strong or bold -->
  <xsl:template match="b|strong">
    <strong>
      <xsl:apply-templates />
    </strong>
  </xsl:template>

  <!-- Italic or Emphasized -->
  <xsl:template match="i|em">
    <em>
      <xsl:apply-templates />
    </em>
  </xsl:template>

  <!-- small, reduces the font size to 7pt -->
  <xsl:template match="small">
    <span style="font-size: 7pt;">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- subscript -->
  <xsl:template match="sub">
    <sub>
      <xsl:apply-templates />
    </sub>
  </xsl:template>

  <!-- superscript -->
  <xsl:template match="sup">
    <sup>
      <xsl:apply-templates />
    </sup>
  </xsl:template>

  <xsl:template match="hr">
    <hr />
  </xsl:template>

  <!-- Line break (br) -->
  <xsl:template match="br">
    <br />
  </xsl:template>

  <!-- svg - uses an img tag, inline svgs are preproccesed into a base64 data url -->
  <xsl:template match="svg">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <!-- If the img tag uses width and height, assume that it's html-like px -->
      <xsl:if test="@width">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>px
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>px
        </xsl:attribute>
      </xsl:if>
      <!-- If the img tag uses content-width and content-height, assume that it includes the units like nice CSS or XSL-FO -->
      <xsl:if test="@content-width or @content-height">
        <xsl:attribute name="style">
          width:<xsl:value-of select="@content-width"/>;height:<xsl:value-of select="@content-height"/>
        </xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

</xsl:stylesheet>