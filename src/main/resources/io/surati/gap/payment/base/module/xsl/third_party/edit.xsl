<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2022 Surati

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to read
the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/io/surati/gap/web/base/xsl/layout.xsl"/>
  <xsl:template match="page" mode="head">
    <title>
      <xsl:text>GAP - Tiers</xsl:text>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
    <xsl:variable name="is_new" select="not(item/id)"/>
    <div class="app-page-title app-page-title-simple">
      <div class="page-title-wrapper">
        <div class="page-title-heading">
          <div class="page-title-icon">
            <i class="lnr-user icon-gradient bg-night-fade"/>
          </div>
          <div>
            <xsl:text>Tiers</xsl:text>
            <div class="page-title-subheading opacity-10">
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item">
                    <a href="/home">
                      <i aria-hidden="true" class="fa fa-home"/>
                    </a>
                  </li>
                  <li class="breadcrumb-item">
                    <a href="/third-party">Tiers</a>
                  </li>
                  <li class="active breadcrumb-item" aria-current="page">
                    <xsl:choose>
                      <xsl:when test="$is_new">
                        <xsl:text>Créer un tiers</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>Modifier Tiers </xsl:text>
                        <xsl:value-of select="item/abbreviated"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="body">
    <xsl:variable name="is_new" select="not(item/id)"/>
    <div class="main-card mb-3 card">
      <div class="card">
        <div class="card-body">
          <form action="/third-party/save" method="post">
            <xsl:if test="not($is_new)">
              <input name="id" type="hidden" value="{item/id}"/>
            </xsl:if>
            <div class="form-row">
              <div class="col-md-6">
                <div class="position-relative form-group">
                  <label for="code" class="">
                    <xsl:text>Code tiers</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="code" id="code" value="{item/code}" placeholder="Entrez un code ..." type="text" class="form-control" required=""/>
                </div>
              </div>
              <div class="col-md-6">
                <div class="position-relative form-group">
                  <label for="abbreviated" class="">
                    <xsl:text>Abrégé</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="abbreviated" id="abbreviated" value="{item/abbreviated}" placeholder="Entrez l'abrégé ..." type="text" class="form-control" required=""/>
                </div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <div class="position-relative form-group">
                  <label for="name" class="">
                    <xsl:text>Intitulé</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="name" id="name" value="{item/name}" placeholder="Entrez un nom ..." type="text" class="form-control" required=""/>
                </div>
              </div>
              <div class="col-md-6">
                <div class="position-relative form-group">
                  <label for="family_id" class="">
                    <xsl:text>Famille</xsl:text>
                  </label>
                  <select name="family_id" class="form-control">
                    <option value="0">-- SVP choisir une famille --</option>
                    <xsl:for-each select="third_party_families/third_party_family">
                      <option value="{id}">
                        <xsl:if test="not($is_new) and id = ../../item/family_id">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="name"/>
                      </option>
                    </xsl:for-each>
                  </select>
                </div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <div class="position-relative form-group">
                  <label for="name" class="">
                    <xsl:text>Délai de paiement (en jours)</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="payment_deadline" id="payment_deadline" value="{item/payment_deadline}" placeholder="Entrez le nombre de jours" type="number" min="0" class="form-control" required=""/>
                </div>
              </div>
            </div>
            <div class="divider"/>
            <div class="clearfix">
              <button type="submit" class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-primary">
                <xsl:choose>
                  <xsl:when test="$is_new">
                    <xsl:text>Créer </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>Modifier </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <i class="fa fa-check"/>
              </button>
              <button type="button" onclick="location.href='/third-party'" class="btn-shadow float-right btn-wide btn-pill mr-1 btn btn-outline-secondary">
                <xsl:if test="not($is_new)">
                  <xsl:attribute name="onclick">
                    <xsl:text>location.href='/third-party/view?id=</xsl:text>
                    <xsl:value-of select="item/id"/>
                    <xsl:text>'</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:text>Annuler </xsl:text>
                <i class="fa fa-undo"/>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script"/>
</xsl:stylesheet>
