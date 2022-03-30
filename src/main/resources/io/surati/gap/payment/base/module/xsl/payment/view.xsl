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
      <xsl:text>GAP - Paiements</xsl:text>
    </title>
    <link rel="stylesheet" href="/css/print.min.css"/>
    <link rel="stylesheet" href="/css/toastr.min.css"/>
  </xsl:template>
  <xsl:template match="page" mode="header">
    <div class="app-page-title app-page-title-simple">
      <div class="page-title-wrapper">
        <div class="page-title-heading">
          <div class="page-title-icon">
            <i class="lnr-inbox icon-gradient bg-night-fade"/>
          </div>
          <div>
            <xsl:value-of select="root_page/title"/>
            <div class="page-title-subheading opacity-10">
              <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item">
                    <a href="/home">
                      <i aria-hidden="true" class="fa fa-home"/>
                    </a>
                  </li>
                  <li class="breadcrumb-item">
                    <a href="{root_page/uri}">
                      <xsl:value-of select="root_page/subtitle"/>
                    </a>
                  </li>
                  <li class="active breadcrumb-item" aria-current="page">
                    <xsl:text>Visualiser un paiement</xsl:text>
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
        <div class="card-body" ng-controller="printCtrl">
          <div class="form-row">
            <div class="col-md-6">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Carnet de formules</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/book"/>
                </p>
              </div>
            </div>
            <div class="col-md-2">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Formule</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/note"/>
                </p>
              </div>
            </div>
            <div class="col-md-4">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Référence de paiement</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/reference"/>
                </p>
              </div>
            </div>
            <div class="col-md-6">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Montant en chiffres</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/amount_in_human"/>
                </p>
              </div>
            </div>
            <div class="col-md-6">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Montant en lettres</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/amount_in_letters"/>
                </p>
              </div>
            </div>
            <div class="col-md-6">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Bénéficiaire</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/beneficiary"/>
                </p>
              </div>
            </div>
            <div class="col-md-3">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Date</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/date_view"/>
                </p>
              </div>
            </div>
            <xsl:if test="item/mean_type_id='LETTRE_DE_CHANGE' or item/mean_type_id='BILLET_A_ORDRE'">
              <div class="col-md-3">
                <h5>
                  <xsl:text>Date d'échéance</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/duedate_view"/>
                </p>
              </div>
            </xsl:if>
            <div class="col-md-3">
              <div class="position-relative form-group">
                <h5>
                  <xsl:text>Lieu</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/place"/>
                </p>
              </div>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Etat</xsl:text>
              </h5>
              <p class="badge badge-primary">
                <xsl:value-of select="item/status"/>
              </p>
            </div>
            <xsl:if test="item/status_id='CANCELLED'">
              <div class="col-md-3">
                <h5>
                  <xsl:text>Raison de l'annulation</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/cancel_reason"/>
                </p>
              </div>
              <div class="col-md-3">
                <h5>
                  <xsl:text>Date d'annulation</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/cancel_date_view"/>
                </p>
              </div>
            </xsl:if>
            <div class="col-md-12">
              <div class="card-header">
                <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                  <xsl:text>Ordres de paiement exécutés</xsl:text>
                </div>
              </div>
              <div class="table-responsive">
                <table class="align-middle text-truncate mb-0 table table-borderless table-hover">
                  <thead>
                    <tr>
                      <th class="text-center">N°</th>
                      <th class="text-center">Date</th>
                      <th class="text-center">Référence</th>
                      <xsl:if test="group/is_hetero">
                        <th class="text-center">Bénéficiaire</th>
                      </xsl:if>
                      <th class="text-center">Doc de référence</th>
                      <th class="text-center">Montant payé</th>
                      <th class="text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="group/payment_orders/payment_order">
                      <tr>
                        <td class="text-center text-muted" style="width: 80px;">
                          <xsl:value-of select="position()"/>
                          <input name="order_id" type="hidden" value="{id}"/>
                        </td>
                        <td class="text-center" style="width: 80px;">
                          <xsl:value-of select="date_view"/>
                        </td>
                        <td class="text-center">
                          <xsl:value-of select="reference"/>
                        </td>
                        <xsl:if test="../../../group/is_hetero">
                          <td class="text-center">
                            <xsl:value-of select="beneficiary"/>
                          </td>
                        </xsl:if>
                        <td class="text-center">
                          <xsl:value-of select="ref_doc_name"/>
                        </td>
                        <td class="text-center">
                          <div class="badge badge-pill badge-success">
                            <xsl:value-of select="amount_to_pay_in_human"/>
                          </div>
                        </td>
                        <td class="text-center">
                          <xsl:if test="../../../sec:hasAccess(.,'VISUALISER_ORDRES_PAIEMENT') or ../../../sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT') or ../../../sec:hasAccess(.,'AUTORISER_ORDRES_PAIEMENT')">
                            <div role="group" class="btn-group-sm btn-group">
                              <button class="btn-shadow btn btn-primary" onclick="location.href='/payment-order/view?id={id}&amp;{../../../current_page/full}'">Voir</button>
                            </div>
                          </xsl:if>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="divider"/>
          <div class="clearfix">
            <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
              <xsl:if test="item/status_id='TO_PRINT'">
              
              </xsl:if>
              <a class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-primary" ng-click="printNote()" ng-class="{{disabled: loadingData}}" href="javascript:void(0)">
                <xsl:text>Imprimer formule </xsl:text>
                <i class="fa fa-print"/>
              </a>
              <xsl:if test="item/status_id='TO_PRINT'">
              
              </xsl:if>
              <a class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-primary mr-1" ng-class="{{disabled: loadingData}}" ng-click="printPaymentResume()" href="javascript:void(0)">
                <xsl:text>Imprimer bordereau </xsl:text>
                <i class="fa fa-print"/>
              </a>
              <xsl:if test="not(item/mean_type_id='CHEQUE') and item/status_id='TO_PRINT'">

              </xsl:if>
              <xsl:if test="not(item/mean_type_id='CHEQUE')">
                <a class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-primary mr-1" ng-click="printLetter()" ng-class="{{disabled: loadingData}}" href="javascript:void(0)">
                  <xsl:text>Imprimer lettre </xsl:text>
                  <i class="fa fa-print"/>
                </a>
              </xsl:if>
            </xsl:if>
            <xsl:if test="sec:hasAccess(.,'ANNULER_PAIEMENTS')">
              <xsl:if test="item/status_id='ISSUED' or item/status_id='TO_PRINT'">
                <a class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-danger mr-1" href="/payment/cancel/edit?id={item/id}&amp;{root_page/full}">
                  <xsl:text>Annuler </xsl:text>
                  <i class="fa fa-minus-circle"/>
                </a>
              </xsl:if>
            </xsl:if>
            <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
              <xsl:if test="item/status_id='TO_PRINT'">
                <a class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-success mr-1" href="/payment/finalize?id={item/id}&amp;{root_page/full}" onclick="return confirm('Voulez-vous finaliser ce paiement ?');">
                  <xsl:text>Finaliser </xsl:text>
                  <i class="fa fa-check"/>
                </a>
              </xsl:if>
              <a class="btn-shadow float-right btn-wide btn-pill mr-1 btn btn-outline-secondary" href="{root_page/uri}">
                <xsl:text>Retourner </xsl:text>
                <i class="fa fa-arrow-left"/>
              </a>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script">
    <script src="/js/print.min.js"/>
    <script type="text/javascript"><![CDATA[
        var app = angular.module("app", []);
				                 
		app.controller("printCtrl", ["$scope", "$rootScope", "$timeout", "$http", function ($scope, $rootScope, $timeout, $http) {
			
	        // Methods
	        $scope.printNote = printNote;
	        $scope.printPaymentResume = printPaymentResume;
	        $scope.printLetter = printLetter;
	        
	        function printNote() {
	            render('/bank-note/print?id=]]><xsl:value-of select="item/id"/><![CDATA[', { }, function (url) {
	                printJS({printable:url, type:'pdf', showModal:false})
	                $scope.loadingData = false;
	            });            
	        }
	        
	        function printPaymentResume() {
	            render('/payment-resume/print?id=]]><xsl:value-of select="item/id"/><![CDATA[', { }, function (url) {
	                printJS({printable:url, type:'pdf', showModal:false})
	                $scope.loadingData = false;
	            });            
	        }
	
			function printLetter() {
	            render('/letter/print?id=]]><xsl:value-of select="item/id"/><![CDATA[', { }, function (url) {
	                printJS({printable:url, type:'pdf', showModal:false})
	                $scope.loadingData = false;
	            });            
	        }
	        
			function buildReport(url, data, success, failure) {
			
			    var config = {
	                headers : {
	                    'Content-Type': 'application/json;charset=utf-8;'
	                },
	                responseType: "arraybuffer"
	            };
	            
	            return $http.post(url, data, config).
                      then(function (response) {
                          if(success)
                            success(response.data);
                      }, function (error, status) {
                          if (error.status == -1) {
                              toastr.error('Connexion au serveur momentanément interrompue.');
                          } else if (error.status == '401') {
                              toastr.error(error);
                          } else if(error.status == '400') {
                          	toastr.error(error);
                          } else if (error.status == '500') {
                              toastr.error("An error occured during generation of report. Please contact administrator.");
                          } 
                          
                          if(failure)
                              failure(error);
                      });
	        }
        
	        function render(url, config, callback) {
	            $scope.loadingData = true;
								
	            buildReport(url, config, function (arraybuffer) {	                	
                    var currentBlob = new Blob([arraybuffer], { type: 'application/pdf' });                    
                    var url = URL.createObjectURL(currentBlob);	                   

                    if (callback)
                        callback(url);	                     	                    
                }, function (response) {
                    $scope.loadingData = false;
                    toastr.error("Error during generating report : " + response.statusText);
                });           
	        }
	        
	        this.$onInit = function () {
   			
	        }
		}]);
		
		angular.bootstrap(document, ['app']);
        ]]></script>
  </xsl:template>
</xsl:stylesheet>
