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
            @import url("https://fonts.googleapis.com/css2?family=Saira+Condensed");
body {
  color: #FFFFFF;
  font-family: 'Saira Condensed', sans-serif;
  line-height: 1.2; }

.col {
  display: flex;
  flex-flow: column nowrap; }

.row {
  display: flex;
  flex-flow: row nowrap; }

.header {
  height: 0.5cm; }

.body-upper {
  width: 100%;
  background-color: darkslategray; }

.body-lower {
  width: 100%;
  align-items: flex-end; }

.center {
  align-items: center; }

.bold {
  font-weight: bold; }

.col-left {
  align-items: flex-start; }

.col-right {
  align-items: flex-end; }

.row-right {
  justify-content: flex-end; }

.row-space-between {
  justify-content: space-between; }

.row-space-evenly {
  justify-content: space-evenly; }

.w75 {
  width: 75%; }

.m2 {
  margin: 2px; }

.m4 {
  margin: 4px; }

.mlr4 {
  margin: 0 4px; }

.p2 {
  padding: 2px; }

.p4 {
  padding: 4px; }

.pr4 {
  padding-right: 4px; }

.mtb2 {
  margin: 2px 0; }

.rad8 {
  border-radius: 8px; }

.rule {
  font-size: 0.8em; }
  .rule span {
    font-weight: bold; }

.card {
  width: 15cm;
  min-height: 10cm;
  align-items: flex-end;
  background-color: #222222; }

.weapon-type {
  font-size: 0.9em; }

.isa-bgcolor {
  background-color: #BE6719; }

.isa-color {
  color: #BEB919; }

.isa-color2 {
  color: orange; }

@media screen {
  #cards {
    display: flex;
    flex-wrap: wrap; }
    #cards .card {
      margin: 10px; } }

@media print {
  .card {
    page-break-inside: avoid; } }

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
    <xsl:template match="bs:selection[@type='model' or @type='unit']" mode="card">
  <xsl:param name="faction"/>
  <div class="col card"> <!-- card -->
    <div class="header"> <!-- header -->

    </div>
    <div class="col body body-upper col-right"> <!-- body upper container -->
      <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Squad' or @typeName='Solo' or @typeName='Warjack']" mode="body-upper">
        <xsl:with-param name="faction"><xsl:value-of select="$faction"/></xsl:with-param>
      </xsl:apply-templates>
    </div>
    <div class="col body body-lower"> <!-- body lower container -->
      <div style="height:0.2cm;"></div> <!-- base size icon container -->
      <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Weapon']" mode="body-lower">
        <xsl:with-param name="faction"><xsl:value-of select="$faction"/></xsl:with-param>
      </xsl:apply-templates> <!-- Squad and Solo -->
      <xsl:apply-templates select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Weapon']" mode="body-lower">
        <xsl:with-param name="faction"><xsl:value-of select="$faction"/></xsl:with-param>
      </xsl:apply-templates> <!-- Warjack -->
    </div>
  </div>

</xsl:template>

<xsl:template match="bs:profile" mode="body-upper">
  <xsl:param name="faction"/>
  <div class="w75 pr4">
    <div class="col center mtb2"> <!-- unit type container -->
      <div style="font-size: 1.5em;"> <!-- unit type -->
        <xsl:attribute name="class">
          <xsl:if test="$faction = 'Iron Star Alliance'">isa-color2</xsl:if>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </div>
      <div> <!-- unit faction -->
        <xsl:value-of select="$faction"/>&#160;<xsl:value-of select="@typeName"/>
      </div>
    </div>
    <div class="row row-space-evenly mtb2 rad8 bold"> <!-- unit stats container -->
      <xsl:attribute name="class">
        <xsl:if test="$faction = 'Iron Star Alliance'">row row-space-evenly mtb2 rad8 bold isa-bgcolor</xsl:if>
      </xsl:attribute>
      <xsl:for-each select="bs:characteristics/bs:characteristic">
        <xsl:if test="contains('SPD|STR|MAT|RAT|DEF|ARM', @name)">
          <div class="col center m4"> <!-- single unit stat -->
            <div>
              <xsl:value-of select="@name"/>
            </div> <!-- move title -->
            <div style="font-size: 1.5em;">
              <xsl:value-of select="."/>
            </div> <!-- move value -->
          </div>
        </xsl:if>
      </xsl:for-each>
    </div>
    <xsl:variable select="../bs:profiles/bs:profile[@typeName='Weapon']/bs:characteristics/bs:characteristic[@name='Rules']" name="weapon-rules"/>
    <xsl:for-each select="../../bs:rules/bs:rule">
      <xsl:if test="not(contains($weapon-rules, @name))">
        <div class="rule">
          <xsl:attribute name="class">
            <xsl:if test="$faction = 'Iron Star Alliance'">rule mtb2 p4 rad8 isa-bgcolor</xsl:if>
          </xsl:attribute>
          <span><xsl:value-of select="@name"/></span>&#160;&#160;<xsl:value-of select="bs:description"/>
        </div>
      </xsl:if>
    </xsl:for-each>
    <div> <!-- unit rules -->

    </div>
  </div>
</xsl:template>

<xsl:template match="bs:profile" mode="body-lower">
  <xsl:param name="faction"/>
  <div class="w75 pr4">
    <div class="row row-space-between mtb2 p4 rad8"> <!-- weapon container -->
      <xsl:attribute name="class">
        <xsl:if test="$faction = 'Iron Star Alliance'">row row-space-between mtb2 p4 rad8 isa-bgcolor</xsl:if>
      </xsl:attribute>
      <div class="col col-left">
        <div> <!-- weapon name -->
          <span style="line-height: 1;">
            <xsl:value-of select="@name"/>
          </span>
        </div>
        <div> <!-- weapon type -->
          <xsl:attribute name="class">
            <xsl:if test="$faction = 'Iron Star Alliance'">isa-color</xsl:if>
          </xsl:attribute>
          <span class="weapon-type">
            <xsl:value-of select="bs:characteristics/bs:characteristic[@name='TYP']"/>
          </span>
        </div> <!-- weapon type -->
        <xsl:variable select="bs:characteristics/bs:characteristic[@name='Rules']" name="rules"/>
        <xsl:for-each select="../../bs:rules/bs:rule">
          <xsl:if test="contains($rules, @name)">
            <div class="rule">
              <span><xsl:value-of select="@name"/></span>&#160;&#160;<xsl:value-of select="bs:description"/>
            </div>
          </xsl:if>
        </xsl:for-each>
      </div>
      <div class="row">
        <div class="col center mlr4 bold"> <!-- weapon range container -->
          <div>
            <xsl:value-of select="bs:characteristics/bs:characteristic[@name='RNG']/@name"/>
          </div> <!-- weapon range title -->
          <div style="font-size:1.3em;">
            <xsl:value-of select="bs:characteristics/bs:characteristic[@name='RNG']"/>
          </div> <!-- weapon range value -->
        </div>
        <div class="col center mlr4 bold"> <!-- weapon range container -->
          <div>
            <xsl:value-of select="bs:characteristics/bs:characteristic[@name='POW']/@name"/>
          </div> <!-- weapon range title -->
          <div style="font-size:1.3em;">
            <xsl:value-of select="bs:characteristics/bs:characteristic[@name='POW']"/>
          </div> <!-- weapon range value -->
        </div>
      </div>
    </div>
  </div>
</xsl:template>
    <!-- endinject -->

</xsl:stylesheet>