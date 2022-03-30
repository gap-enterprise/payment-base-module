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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sec="http://www.surati.io/Security/User/Profile" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/io/surati/gap/web/base/xsl/layout.xsl"/>
  <xsl:template match="page" mode="head">
    <title>
      <xsl:text>GAP - Tiers</xsl:text>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
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
                    <xsl:text>Tiers </xsl:text>
                    <xsl:value-of select="item/abbreviated"/>
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
    <div class="main-card mb-3 card">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-md-6">
              <h5>
                <xsl:text>Code tiers</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/code"/>
              </p>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Abrégé</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/abbreviated"/>
              </p>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Intitulé</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/name"/>
              </p>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Famille</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/family"/>
              </p>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Délai de paiement</xsl:text>
              </h5>
              <p><xsl:value-of select="item/payment_deadline"/> jours</p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="card-header">
                <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                  <xsl:text>Comptes bancaires</xsl:text>
                </div>
                <xsl:if test="sec:hasAccess(.,'CONFIGURER_TIERS')">
                  <div class="btn-actions-pane-right">
                    <a href="/bank-account/edit?holder={item/id}" type="button" class="btn-icon btn-wide btn-outline-2x btn btn-outline-focus btn-sm d-flex">
                      <xsl:text>Nouveau compte</xsl:text>
                      <span class="pl-2 align-middle opacity-7">
                        <i class="fa fa-plus"/>
                      </span>
                    </a>
                  </div>
                </xsl:if>
              </div>
              <xsl:if test="bank_accounts[not(bank_account)]">
                <h6 class="text-center pb-1 pt-1">
                  <xsl:text>Il n'y a aucun compte bancaire.</xsl:text>
                </h6>
              </xsl:if>
              <xsl:if test="bank_accounts[bank_account]">
                <div class="table-responsive">
                  <table class=" mb-0 table table-hover table-sm">
                    <thead>
                      <tr>
                        <th>N°</th>
                        <th>Banque</th>
                        <th>Code guichet</th>
                        <th>Numéro</th>
                        <th>Clé</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="bank_accounts/bank_account">
                        <tr>
                          <td>
                            <xsl:value-of select="position()"/>
                          </td>
                          <td>
                            <xsl:value-of select="bank"/>
                          </td>
                          <td>
                            <xsl:value-of select="branch_code"/>
                          </td>
                          <td>
                            <xsl:value-of select="number"/>
                          </td>
                          <td>
                            <xsl:value-of select="key"/>
                          </td>
                          <td>
                            <div role="group">
                              <a href="/bank-account/view?id={id}&amp;holder={../../item/id}" class="mb-2 mr-2 btn btn-sm btn-outline-primary">
                                <i class="fa fa-eye"/>
                              </a>
                              <xsl:if test="../../sec:hasAccess(.,'CONFIGURER_TIERS')">
                                <a href="/bank-account/edit?id={id}&amp;holder={../../item/id}" class="mb-2 mr-2 btn btn-sm btn-outline-success">
                                  <i class="fa fa-edit"/>
                                </a>
                                <a href="/bank-account/delete?id={id}&amp;holder={../../item/id}" class="mb-2 mr-2 btn btn-sm btn-outline-danger" onclick="return confirm('Voulez-vous supprimer ce compte ?');">
                                  <i class="fa fa-trash"/>
                                </a>
                              </xsl:if>
                            </div>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </tbody>
                  </table>
                </div>
              </xsl:if>
            </div>
            <div class="col-md-12">
              <div class="card-header">
                <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                  <xsl:text>Moyens de paiement autorisés</xsl:text>
                </div>
                <xsl:if test="sec:hasAccess(.,'CONFIGURER_TIERS')">
                  <div class="btn-actions-pane-right">
                    <a href="/third-party/payment-mean-allowed/new?tp={item/id}" type="button" class="btn-icon btn-wide btn-outline-2x btn btn-outline-focus btn-sm d-flex">
                      <xsl:text>Autoriser un moyen de paiement</xsl:text>
                      <span class="pl-2 align-middle opacity-7">
                        <i class="fa fa-plus"/>
                      </span>
                    </a>
                  </div>
                </xsl:if>
              </div>
              <xsl:if test="payment_mean_types[not(payment_mean_type)]">
                <h6 class="text-center pb-1 pt-1">
                  <xsl:text>Il n'y a aucun moyen de paiement autorisé.</xsl:text>
                </h6>
              </xsl:if>
              <xsl:if test="payment_mean_types[payment_mean_type]">
                <div class="table-responsive">
                  <table class=" mb-0 table table-hover table-sm">
                    <thead>
                      <tr>
                        <th>N°</th>
                        <th>Libellé</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="payment_mean_types/payment_mean_type">
                        <tr>
                          <xsl:if test="inherited = 'true'">
                            <xsl:attribute name="class">opacity-3</xsl:attribute>
                          </xsl:if>
                          <td>
                            <xsl:value-of select="position()"/>
                          </td>
                          <td>
                            <xsl:value-of select="name"/>
                          </td>
                          <td>
                            <div role="group">
                              <xsl:if test="../../sec:hasAccess(.,'CONFIGURER_TIERS')">
                                <a href="/third-party/payment-mean-allowed/delete?meantype={id}&amp;tp={../../item/id}" class="mb-2 mr-2 btn btn-sm btn-outline-danger" onclick="return confirm('Voulez-vous retirer ce moyen de paiement du tiers ?');">
                                  <i class="fa fa-trash"/>
                                </a>
                              </xsl:if>
                            </div>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </tbody>
                  </table>
                </div>
              </xsl:if>
            </div>
          </div>
          <div class="divider"/>
          <div class="clearfix">
            <a href="/third-party" class="btn-shadow float-right btn-wide btn-pill btn btn-outline-secondary">
              <xsl:text>Retourner </xsl:text>
              <i class="fa fa-arrow-left"/>
            </a>
            <xsl:if test="sec:hasAccess(.,'CONFIGURER_TIERS')">
              <a href="/third-party/edit" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-success">
                <xsl:text>Nouveau </xsl:text>
                <i class="fa fa-file"/>
              </a>
              <a href="/third-party/delete?id={item/id}" class="btn-shadow btn-wide float-right mr-1 btn-pill btn-hover-shine btn btn-danger" onclick="return confirm('Voulez-vous supprimer ce tiers ?');">
                <xsl:text>Supprimer </xsl:text>
                <i class="fa fa-trash"/>
              </a>
              <a href="/third-party/edit?id={item/id}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-primary">
                <xsl:text>Modifier </xsl:text>
                <i class="fa fa-edit"/>
              </a>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script"/>
</xsl:stylesheet>
