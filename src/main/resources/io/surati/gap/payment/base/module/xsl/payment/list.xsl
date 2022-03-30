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
      <xsl:text>GAP - Historique - Paiements</xsl:text>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
    <div class="app-page-title app-page-title-simple">
      <div class="page-title-wrapper">
        <div class="page-title-heading">
          <div class="page-title-icon">
            <i class="lnr-pointer-left icon-gradient bg-night-fade"/>
          </div>
          <div>
            <xsl:text>Historique</xsl:text>
            <div class="page-title-subheading opacity-10">
              <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item">
                    <a href="/home">
                      <i aria-hidden="true" class="fa fa-home"/>
                    </a>
                  </li>
                  <li class="active breadcrumb-item">
                    Paiements
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
    <div class="main-card mb-3 card card-body" app="app" ng-controller="AppCtrl as vm">
      <div class="card-header">
        <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
          <xsl:text>Liste des paiements</xsl:text>
        </div>
        <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
          <div class="btn-actions-pane-right">
            <div class="row">
              <a class="btn-icon btn-wide btn-outline-2x btn btn-outline-focus btn-sm d-flex mr-1" ng-click="vm.exportExcel()" ng-class="{{disabled: vm.loadingData}}" href="javascript:void(0)">
                <xsl:text>Exporter XLSX</xsl:text>
                <span class="pl-2 align-middle opacity-7">
                  <i class="fa fa-file"/>
                </span>
              </a>
              <a href="/payment/home" class="btn-icon btn-wide btn-outline-2x btn btn-outline-focus btn-sm d-flex mr-1">
                <xsl:text>Exécuter un ordre de paiement</xsl:text>
                <span class="pl-2 align-middle opacity-7">
                  <i class="fa fa-plus"/>
                </span>
              </a>
            </div>
          </div>
        </xsl:if>
      </div>
      <div class="card-body">
        <div class="row dataTables_wrapper dt-bootstrap4">
          <div class="col-sm-12 col-md-3">
            <div class="dataTables_length">
              <label>Afficher 
	      				<select name="example_length" aria-controls="example" class="custom-select custom-select-sm form-control form-control-sm" ng-model="vm.nbItemsPerPage" ng-options="option for option in vm.nbperpageoptions" ng-change="vm.nbItemsPerPageChanged(vm.nbItemsPerPage)"/> éléments
     				</label>
            </div>
          </div>
          <div class="col-sm-12 col-md-9">
            <div class="input-group input-group-sm">
              <input type="search" class="form-control form-control-sm" placeholder="Saisir N° de formule, Réf de paiement, Bénéficiaire, Lieu d'édition" aria-controls="example" ng-model="vm.filter" ng-model-options="{{ debounce: 1000 }}" ng-change="vm.filterChanged(vm.filter)" aria-describedby="search-addon"/>
              <div class="input-group-append">
                <span class="input-group-text" id="search-addon">
                  <i class="fa fa-search"/>
                </span>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-12 col-md-6">
            <div class="d-flex align-items-center">
              <label class="col-md-5">Période de paiement :</label>
              <div class="input-group input-group-sm">
                <input type="date" class="form-control" aria-controls="example" ng-model="vm.begindate" ng-blur="vm.search()"/>
                <div class="input-group-append">
                  <button ng-click="vm.begindate=''; vm.search()" class="btn btn-outline-secondary" type="button">X</button>
                </div>
              </div>
              <div class="input-group input-group-sm">
                <input type="date" class="form-control" aria-controls="example" ng-model="vm.enddate" ng-blur="vm.search()"/>
                <div class="input-group-append">
                  <button ng-click="vm.enddate=''; vm.search()" class="btn btn-outline-secondary" type="button">X</button>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-12 col-md-4 offset-md-2">
            <div class="d-flex align-items-center">
              <label class="col-md-4">Statut:</label>
              <select class="col-md-8 custom-select custom-select-sm form-control form-control-sm" aria-controls="example" ng-model="vm.statusId" ng-model-options="{{ debounce: 500 }}" ng-change="vm.search()">
                <option value="NONE"> -- Choisir un statut -- </option>
                <option ng-repeat="item in vm.status" value="{{{{item.id}}}}">{{item.name}}</option>
              </select>
            </div>
          </div>
        </div>
        <div class="row mt-3" ng-if="vm.loadingData">
          <div class="col-sm-12 text-center">
            <h4 class="text-muted">Chargement des données... <small>Veuillez patienter</small></h4>
            <img src="/io/surati/gap/web/base/img/loader.gif" width="250"/>
          </div>
        </div>
        <div ng-if="!vm.loadingData" class="mt-3">
          <h6 class="text-center pb-1 pt-5" ng-if="vm.items.length == 0">
            <xsl:text>Il n'y a aucun paiement trouvé.</xsl:text>
          </h6>
          <div class="row" ng-if="vm.items.length &gt; 0">
            <div class="col-sm-12 col-md-12">
              <div class="table-responsive">
                <table class="table table-hover table-striped table-bordered table-sm dataTable dtr-inline">
                  <thead>
                    <tr>
                      <th>N°</th>
                      <th>Date</th>
                      <th>Référence</th>
                      <th>Bénéficiaire</th>
                      <th>Montant</th>
                      <th>Formule</th>
                      <th>Statut</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr ng-repeat="item in vm.items">
                      <td>
		                    {{ vm.firstPosition + $index }}
		                  </td>
                      <td>
		                    {{ item.date_view }}
		                  </td>
                      <td>
		                    {{ item.reference }}
		                  </td>
                      <td>
		                    {{ item.beneficiary }}
		                  </td>
                      <td>
		                    {{ item.amount_in_human }}
		                  </td>
                      <td>
		                    {{ item.note }}
		                  </td>
                      <td>
		                    {{ item.status }}
		                  </td>
                      <td>
                        <div role="group">
                          <a href="/payment/view?id={{{{item.id}}}}&amp;{root_page/full}" class="mb-1 mr-1 btn btn-xs btn-outline-primary">
                            <i class="fa fa-eye"/>
                          </a>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="row mt-3" ng-if="vm.items.length &gt; 0">
            <div class="col-sm-12 col-md-5">
              <div class="dataTables_info" id="example_info" role="status" aria-live="polite">Affichant de {{vm.firstPosition}} à {{vm.lastPosition}} - {{vm.totalCount}} éléments</div>
            </div>
            <div class="col-md-7">
              <ul uib-pagination="" first-text="Premier" last-text="Dernier" previous-text="Précédent" next-text="Suivant" total-items="vm.totalCount" ng-model="vm.currentPage" items-per-page="vm.nbItemsPerPage" max-size="vm.pageSize" num-pages="vm.pagesCount" class="pagination-md float-right" rotate="false" boundary-links="true" force-ellipses="true" ng-change="vm.pageChanged()"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script">
    <script type="text/javascript"><![CDATA[		
				var app = angular.module("app", ['ui.bootstrap']);
				app.controller("AppCtrl", ["$scope", "$http", function ($scope, $http) {
					   var vm = this;
		                   
		               vm.exportPayments = exportPayments;
		               
		               vm.totalCount = 0;
		               
		               vm.firstPosition = 0;
		               vm.lastPosition = 0;
		               
		               vm.nbperpageoptions = [10, 25, 50, 100];
	        
				       vm.exportExcel = function() {
				       		vm.loadingData = true;
				       		var params = queries();
				       		var url = "/api/payment/history/export-excel?page=%s&nbperpage=%s&filter=%s&begindate=%s&enddate=%s&statusid=%s"
			            		.format(
			            			params.page,
			            			vm.totalCount, // Take all entries
			            			params.filter,
			            			params.begindate,
			            			params.enddate,
			            			params.statusid
			            		);
				            render(
				            	url,
				            	{ },
				            	function (url) {
				                	window.open(url, "_blank");
				                	vm.loadingData = false;
				            	}
			            	);            
				        }
	        
		               vm.nbItemsPerPageChanged = function(newnb) {
		               		vm.search();
		               }
		               
		               vm.filterChanged = function(filter) {
		               		vm.search();
		               }
		               
		               function queries() {
		                   return {
			                    page: vm.currentPage,
			                    nbperpage: vm.nbItemsPerPage,
			                    filter: vm.filter,
			                    begindate: vm.begindate,
			                    enddate: vm.enddate,
			                    statusid: vm.statusId
			                };
		               }
		               
		               vm.search = function() {							
				            vm.loadingData = true;
				            return $http.get('/payment/search', { params : queries() }).then(
						            function(response){
						            	vm.loadingData = false;
						            	
						            	vm.totalCount = response.data.count;						            
							            vm.items = response.data.items;
							            vm.firstPosition = vm.nbItemsPerPage * (vm.currentPage - 1) + 1;
							            vm.lastPosition = vm.firstPosition + vm.items.length - 1;
						            },
						            function(error){
						            	vm.loadingData = false;
						            }
				            );
				        }
         
		               vm.pageChanged = function(){
		               		vm.search();
		               };		             		              
		               
		               vm.status = [
			                    ]]><xsl:for-each select="bank_note_statuss/bank_note_status">
			                    {
			                    	id: '<xsl:value-of select="id"/>',
			                    	name: '<xsl:value-of select="name"/>'
			                    },
			                    </xsl:for-each><![CDATA[
			           ];
			               
		               function exportPayments() {
		               		var queries = [];
		               		if(vm.filter) {
		               			queries.push('filter=' + vm.filter);
		               		}
		               		if(vm.begindate) {
		               			queries.push('begindate=' + vm.begindate.toISOString());
		               		}
		               		if(vm.enddate) {
		               			queries.push('enddate=' + vm.enddate.toISOString());
		               		}
		               		if(vm.statusId != 'NONE') {
		               			queries.push('statusid=' + vm.statusId);
		               		}
		               		var url = "/payment/export";
		               		if(queries.length > 0) {
		               			url = url + '?' + queries.join('&');
		               		}
				            render(
				            	url,
				            	{ },
				            	function (docurl) {
				                	window.open(docurl, "_blank");
				                	vm.loadingData = false;
				            	}
				           );            
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
				            vm.loadingData = true;
											
				            buildReport(url, config, function (arraybuffer) {	                	
			                    var currentBlob = new Blob([arraybuffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });                    
			                    var url = URL.createObjectURL(currentBlob);	                   
			
			                    if (callback)
			                        callback(url);	                     	                    
			                }, function (response) {
			                    vm.loadingData = false;
			                    toastr.error("Error during generating report : " + response.statusText);
			                });           
				        }
				        
					   this.$onInit = function(){
					   					   	    
					   	    vm.nbItemsPerPage = 10;
					   	    vm.currentPage = 1;
					   	    vm.pageSize = 5;
					   	    vm.statusId = "NONE";
					   	    vm.search();
					   };
			    }]);	
				
				angular.bootstrap(document, ['app']);			
        ]]></script>
  </xsl:template>
</xsl:stylesheet>
