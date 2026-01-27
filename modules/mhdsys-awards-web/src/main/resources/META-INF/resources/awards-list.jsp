<%@page import="com.mhdsys.awards.web.constants.AwardsWebPortletKeys"%>
<%@ include file="/init.jsp" %>

<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.9/pdfmake.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.9/vfs_fonts.js"></script>

<style>
.filter-card {
    display: none;
    opacity: 0;
    transition: all 0.3s ease-in-out;
}
.filter-card.show {
    display: block;
    opacity: 1;
}
 #award_application_list_wrapper .top {
        display: flex;
        justify-content: space-between;
}
#award_application_list_wrapper .bottom {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
}
.universal-table table tbody tr:last-child td:nth-child(2) {
    border-bottom-left-radius: 0px;
}
</style>

<div class="common-forms-div">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="border-0 card shadow">
					
					<div class="align-items-center back-btn-cn card-header d-flex justify-content-between" style="">
						<h5 class="mb-0"> <liferay-ui:message key="award-application-list" /> </h5>
						<div><a href="/group/guest/awards" class="btn btn-primary btn-sm rounded-pill back-btn-cn"><i class="bi bi-arrow-left-circle"></i>  <liferay-ui:message key="back" /></a></div>
					</div>
					
				<div class="card-body">
					<!-- filter -->
						<div class="filter-container">
							<button class="btn btn-primary m-0" id="filterBtn"> <liferay-ui:message key="filter" /> </button>
							
							<div class="filter-card mt-4" id="filterCard">
								<div class="card card-background p-0">
									<div class="card-header header-card"> <liferay-ui:message key="filter-options" /> </div>

							<form id="buyer_purchase" method="POST">
									<div class="card-body">
										<div class="row">
										    <div class="col-md-3">
										        <div class="form-group">
	                                                <label><liferay-ui:message key="applicant-name"/></label>
	                                                 <input type="text" class="form-control" id="applicant" name="applicant" />
                                            	</div>
										    </div>
										
										    <div class="col-md-3">
										        <div class="form-group">
                                                	<label><liferay-ui:message key="competition-name"/></label>
                                                	<input type="text" class="form-control" id="competition" name="competition" />
                                            	</div>
										    </div>
										
										    <div class="col-md-3">
										        <div class="form-group">
	                                                <label> <liferay-ui:message key="sport-name" /></label>
	                                                <select id="sport" name="sport" class="form-control">
														<option value=""><liferay-ui:message key="all" /></option>
														 <c:forEach var="sportsMaster" items="${sportsMaster}">
															<option value="${sportsMaster.name_en }">${sportsMaster.name_en}</option>
														 </c:forEach>
													</select>
                                            	</div>
										    </div>
										
										    <div class="col-md-3">
										        <div class="form-group">
	                                                <label> <liferay-ui:message key="country-of-competition" /></label>
	                                                <input type="text" class="form-control" id="country" name="country" />
                                            	</div>
										    </div>
										    
										    <div class="col-md-3">
										      <div class="form-group">
                                                <label> <liferay-ui:message key="role-name" /></label>
                                                <select id="role" name="role" class="form-control">
													<option value=""><liferay-ui:message key="all" /></option>
													<option value="Coach of Para"><liferay-ui:message key="coach-of-para" /></option>
													<option value="Athlete"><liferay-ui:message key="athlete" /></option>
													<option value="Coach"><liferay-ui:message key="coach" /></option>
													<option value="Adventure Person"><liferay-ui:message key="adventure-person" /></option>
													<option value="Para Athlete"><liferay-ui:message key="para-athlete" /></option>
												</select>
                                           	  </div>
										    </div>
										
										</div>
									</div>
								</form>
									
									<div class="card-footer text-right bg-white">
										<button type="button" class="btn btn-success" id="resetBtn"> <liferay-ui:message key="reset" />  </button>
										
										<button type="submit" class="btn btn-success" id="searchBtn"> <liferay-ui:message key="search" /> </button>
									</div>
								</div>
							</div>
						</div>

						<div class="universal-table mt-4">
							<table id="award_application_list" class="table-bordered" cellspacing="0" width="100%">
					                <thead>
					                    <tr>
					                        <th><liferay-ui:message key="applicant-name" /></th>
					                        <th><liferay-ui:message key="competition-name" /></th>
					                       	<th><liferay-ui:message key="sport-name" /></th>
					                        <th><liferay-ui:message key="country-of-competition" /></th>
					                        <th><liferay-ui:message key="role-name" /></th>
					                        <th><liferay-ui:message key="competition-certificate" /></th>
					                        <th><liferay-ui:message key="undertaking" /></th>
					                    </tr>
					                </thead>
					                <tbody>
					                    
					                    <c:forEach var="application" items="${applicantList}">
					                        <tr>
					                            <td>${application.userName}</td>
					                            <td>${application.competitionName}</td>
					                           	<td>${application.sportsName}</td>
					                            <td>${application.countryOfCompetition}</td>
					                            <td>${application.roleName}</td>
					                            <td>
												    <c:if test="${not empty application.certificateFileURL}">
												        <a href="${application.certificateFileURL}" target="_blank">
												            View Certificate
												        </a>
												    </c:if>
												</td>
												<td>
												    <c:if test="${not empty application.undertakingFileURL}">
												        <a href="${application.undertakingFileURL}" target="_blank">
												            View Undertaking
												        </a>
												    </c:if>
												</td>
					                          </tr>
					                    </c:forEach>
					                </tbody>
					          </table>
					     </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
jQuery.noConflict();
	
var table = $('#award_application_list').DataTable({
    "paging": true,
    "ordering": false,
    "searching": true,
    "responsive": true,
    "autoWidth": false,
    "language": {
		  "search": '<liferay-ui:message key="search" />',
			"emptyTable": '<liferay-ui:message key="no-data-available-in-table" />',
		  "infoFiltered": "",
		  "lengthMenu": '_MENU_',  
		  "info": "<liferay-ui:message key="Showing-total-entries" />",
		  "zeroRecords": "<liferay-ui:message key="No-matching-records-found" />",
		  "infoEmpty": "<liferay-ui:message key='Showing-total-entries' />",
		   oPaginate: {
			    sNext: '<em class="bi bi-chevron-right"></em>',
			    sPrevious: '<em class="bi bi-chevron-left"></em>',
			    }
	    },
	    "layout": {
	        topStart: {
	            buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
	        }
	    },
    "dom": '<"top"Bf>rt<"bottom"lip><"clear">',
    "buttons": [
        {
            extend: 'copy',
            exportOptions: {
                columns: ':not(:last-child)'
            }
        },
        {
            extend: 'csv',
            exportOptions: {
                columns: ':not(:last-child)'
            }
        },
        {
            extend: 'excel',
            exportOptions: {
                columns: ':not(:last-child)'
            },
            customize: function(xlsx) {
                var sheet = xlsx.xl.worksheets['sheet1.xml'];
            }
        },
        {
            extend: 'pdf',
            exportOptions: {
                columns: ':not(:last-child)'
            },
            customize: function(doc) {
                doc.defaultStyle.fontSize = 8;
                doc.styles.tableHeader.fontSize = 9;
                doc.pageMargins = [20, 20, 20, 20];
            }
        },
        {
            extend: 'print',
            exportOptions: {
                columns: ':not(:last-child)'
            }
        }
    ],
    "initComplete": function() {
    	 $('.buttons-copy').html('<i class="bi bi-copy" title="<liferay-ui:message key="copy" />"></i>');
	        $('.buttons-csv').html('<i class="bi bi-filetype-csv" title="<liferay-ui:message key="csv" />"></i>');
	        $('.buttons-excel').html('<i class="bi bi-file-earmark-excel" title="<liferay-ui:message key="excel" />"></i>');
	        $('.buttons-pdf').html('<i class="bi bi-file-earmark-pdf" title="<liferay-ui:message key="pdf" />"></i>');
	        $('.buttons-print').html('<i class="bi bi-printer" title="<liferay-ui:message key="print" />"></i>');
    }
});

$('#filterBtn').click(function() {
    
    $('#applicant').val('');
    $('#competition').val(''); 
    $('#sport').val('');
    $('#country').val('');
    $('#role').val('');
    
    const $filterCard = $('#filterCard');
    $filterCard.toggleClass('show');
    $(this).text($filterCard.hasClass('show') ? '<liferay-ui:message key='close' />' : '<liferay-ui:message key='filter' />');
});

$('#resetBtn').click(function() {
	$('#applicant').val('');
    $('#competition').val(''); 
    $('#sport').val('');
    $('#country').val('');
    $('#role').val('');
    
    if (typeof table !== 'undefined') {
        table.search('').columns().search('').draw();
        $('.dataTables_filter input').val('');
    }
});

$(document).on('click', '#searchBtn', function () {
    table.search('').columns().search('').draw();
    $('.dataTables_filter input').val('');
    
    var applicant = $('#applicant').val().trim();
    var competition = $('#competition').val().trim();
    var sport = $('#sport').val().trim();
    var country = $('#country').val().trim();
    var role = $('#role').val().trim();
    
    if (applicant) table.column(0).search(applicant);
    if (competition) table.column(1).search(competition);
    if (sport) table.column(2).search(sport);
    if (country) table.column(3).search(country);
    if (role) table.column(4).search(role);
    
    table.draw();
});

});

</script>