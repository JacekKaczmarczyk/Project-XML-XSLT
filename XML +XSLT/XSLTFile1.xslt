<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:variable name="header">
    <h2>
      Wybrane gry z mojej biblioteki
    </h2>
  </xsl:variable>

  <xsl:template match="/">
    <html>

      <body bgcolor="#66ccff">
        <xsl:copy-of select="$header" />
        <p>
          <table border="4">
            <tr bgcolor="#ff6600">
              <th>Nr</th>
              <th>Tytul</th>
              <th>Autor</th>
              <th>Gatunek</th>
              <th>Wydawca</th>
              <th>Pochodzenie</th>
              <th>Typ Gry</th>
              <th>Platformy</th>
              <th>Odnośnik</th>
              <th>Data wydania</th>
              <th>PEGI</th>
              <th>Zdjęcie</th>
            </tr>
            <xsl:call-template name="gry" />
          </table>
        </p>
        <p>
          <br/>
          <h4>Lista moich ulubionych gier</h4>
          <xsl:call-template name="lisssta" />
        </p>
        <xsl:call-template name="autor"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="autor">
    <br/>
    <br/>
    <p>
      <i>
        KOPIRAJT:
        <xsl:value-of select="Biblioteka/autor/nazwisko"/>
        ,
        <xsl:value-of select="Biblioteka/autor/data"/>
      </i>
    </p>

  </xsl:template>

  <xsl:template name="gry">
    <xsl:for-each select="Biblioteka/gra">
      <xsl:sort select="numer" order="ascending"/>
      <tr>
        <td bgcolor="#00cc99">
          <xsl:value-of select="numer"/>
        </td>
        <td>
          <xsl:value-of select="tytul"/>
        </td>
        <xsl:call-template name="studio"/>
        <td>
         <xsl:value-of select="gatunek"/>
        </td>
        <td>
           <xsl:value-of select="autorzy/wydawca"/>
        </td>
        <td>
          <xsl:value-of select="autorzy/studio/kraj"/>
        </td>
        <td>
          <xsl:value-of select="@rodzaj"/>
        </td>
        <td>
          <xsl:value-of select="platformy"/>
        </td>
        <td>
         <a target="_blank">
            <xsl:attribute name="href">
              <xsl:value-of select="link"/>
            </xsl:attribute>
            <xsl:value-of select="link"/>
          </a>
        </td>
        <td>
           <xsl:value-of select="format-number(datawydania, '##,##.####')"/>
        </td>
        <xsl:choose>
          <xsl:when test="PEGI &gt; 17">
            <td bgcolor="#ff0000">
              <xsl:value-of select="PEGI"/>
            </td>
          </xsl:when>
          <xsl:when test="PEGI &gt; 15">
            <td bgcolor="#ff9900">
              <xsl:value-of select="PEGI"/>
            </td>
          </xsl:when>
          <xsl:otherwise>
            <td bgcolor="#00cc00">
              <xsl:value-of select="PEGI"/>
            </td>
          </xsl:otherwise>
        </xsl:choose>

       
        <td>
          <xsl:apply-templates select="img"/>
        </td>
      </tr>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="lisssta">
    <ol>
      <xsl:for-each select="Biblioteka/gra">
        <xsl:sort select="ocena" order="descending"/>
        <xsl:if test="autorzy/studio/@lubie = 'tak'">
          <li>
            <xsl:value-of select="tytul"/>
            <h3>
              <b>
                <xsl:value-of select='format-number(ocena, "##%")' />
              </b>
            </h3>
          </li>
        </xsl:if>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template name="studio">

    <xsl:choose>
      <xsl:when test="autorzy/studio/@lubie = 'tak'">
        <style>
          .wiksa{
          animation-name: animo;
          animation-duration: 4s;
          animation-iteration-count: infinite;
          }
          @keyframes animo {
          0% {
          background-color: red;
          }

          25% {
          background-color: yellow;
          }

          50% {
          background-color: blue;
          }

          75% {
          background-color: green;
          }

          100% {
          background-color: red;
          }
          
          }
          
        </style>
        <td class="wiksa">
          <b>
            <xsl:value-of select="autorzy/studio/nazwa"/>
          </b>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td bgcolor="#996633">
          <h3>
            <xsl:value-of select="autorzy/studio/nazwa"/>
          </h3>
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="img">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="width"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="height"/>
      </xsl:attribute>
    </img>
  </xsl:template>

</xsl:stylesheet>
