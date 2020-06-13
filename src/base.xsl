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
            .card {
              background-color: aqua;
              width: 18cm;
              min-height: 10cm;
              display: flex;
              flex-flow: column nowrap;
              margin: 0.5cm 0;
            }
            .header {
              background-color: darkgreen;
              height: 1cm;
            }
            .body-common {
              display: flex;
              flex-flow: column nowrap;
              align-items: flex-end;
            }
            .body-top {
              background-color: blueviolet;
            }
            .body-bottom {
              background-color: cadetblue;
              padding: 0.5cm 0;
            }
            .unit-title {
              background-color: chocolate;
              height: 1.5cm;
              width: 12cm;
              text-align: center;
            }
            .unit-title div {
              padding: 0.2cm 0;
            }
            .stat-line {
              background-color: chartreuse;
              width: 12cm;
              height: 1.5cm;
              display: flex;
              flex-flow: row nowrap;
              align-items: center;
            }
            .stat-container {
              display: flex;
              flex-flow: column nowrap;
              flex-grow: 1;
              align-items: center;
            }
            .stat {
              flex-grow: 1;
            }
            .weapon-container {
              display: flex;
              flex-flow: column nowrap;
              background-color: crimson;
              height: 1.5cm;
              width: 12cm;
            }
            .weapon {
              display: flex;
              flex-flow: row nowrap;
            }
            .weapon div {
              flex-basis: 15%;
            }
            div.weapon-icon {
              flex-basis: 5%;
            }
            .rule {
              display: flex;
              flex-flow: row nowrap;
            }
          </style>
        </head>
        <body>
          <section id="cards">
            <xsl:apply-templates select="bs:selections/bs:selection[@type='model']" mode="card"/>
          </section>
        </body>
      </html>
    </xsl:template>

    <xsl:template match="bs:selection[@type='model']" mode="card">
      <div class="card">
        <div class="header"></div>
        <div class="body-common body-top">
          <div class="unit-title">
            <div>
              <xsl:value-of select="@name"/>
            </div>
          </div>
          <div class="stat-line">
            <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Solo' or @typeName='Warjack']/bs:characteristics/bs:characteristic" mode="stat-line"/>
          </div>
        </div>
        <div class="body-common body-bottom">
          <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Weapon']" mode="weapon-line"/>
          <xsl:apply-templates select="bs:selections/bs:selection[@type='upgrade']/bs:profiles/bs:profile[@typeName='Weapon']" mode="weapon-line"/>
          <xsl:apply-templates select="bs:rules/bs:rule" mode="rule"/>
        </div>
      </div>
    </xsl:template>

    <xsl:template match="bs:characteristic" mode="stat-line">
      <xsl:if test="contains('SPD|MAT|RAT|DEF|ARM|FOC', @name)">
        <div class="stat-container">
          <div><xsl:value-of select="@name"/></div>
          <div><xsl:value-of select="."/></div>
        </div>
      </xsl:if>
    </xsl:template>

    <xsl:template match="bs:rule" mode="rule">
      <div class="weapon-container">
        <div class="rule">
          <div class="weapon-icon"></div>
          <div>
            <xsl:value-of select="@name"/>
          </div>
          <div>
            <xsl:value-of select="bs:description/."/>
          </div>
        </div>
      </div>
    </xsl:template>

    <xsl:template match="bs:profile" mode="weapon-line">
      <div class="weapon-container">
        <div class="weapon">
          <div class="weapon-icon"></div>
          <div class="weapon-name" style="flex-grow: 3;">
            <div>
              <xsl:value-of select="@name"/>
            </div>
            <div>
              <xsl:value-of select="bs:characteristics/bs:characteristic[@name='DMG']"/>
            </div>  
          </div>
          <div class="stat-container">
            <xsl:variable name="range" select="bs:characteristics/bs:characteristic[@name='RNG']"/>
            <div>
              <xsl:value-of select="$range/@name"/>
            </div>
            <div>
              <xsl:value-of select="$range/."/>
            </div>
          </div>
          <div class="stat-container">
            <xsl:variable name="power" select="bs:characteristics/bs:characteristic[@name='POW']"/>
            <div>
              <xsl:value-of select="$power/@name"/>
            </div>
            <div>
              <xsl:value-of select="$power/."/>
            </div>
          </div>
        </div>
        <div class="weapon">
          <div class="weapon-icon"></div>
          <div style="flex-grow: 3;">
            <xsl:value-of select="bs:characteristics/bs:characteristic[@name='Rules']"/>
          </div>
        </div>
      </div>
    </xsl:template>

</xsl:stylesheet>