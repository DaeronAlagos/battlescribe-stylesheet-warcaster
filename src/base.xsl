<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="bs:roster/bs:forces/bs:force">
      <html>
        <head>
          <style>
            <!-- inject:../build/style.css -->
            <!-- contents of html partials will be injected here -->
            <!-- endinject -->
          </style>
        </head>
        <body>
          <section id="cards">
            <xsl:apply-templates select="bs:selections/bs:selection[@type='model' or @type='unit']" mode="card">
              <xsl:with-param name="faction"><xsl:value-of select="@catalogueName"/></xsl:with-param>
            </xsl:apply-templates>
          </section>
        </body>
      </html>
    </xsl:template>

    <!-- inject:card.xsl -->
    <!-- contents of html partials will be injected here -->
    <!-- endinject -->

</xsl:stylesheet>