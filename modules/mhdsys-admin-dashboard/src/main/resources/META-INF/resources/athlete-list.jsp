<%@ include file="/init.jsp" %>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.min.css">
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.min.js"></script>

<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/vfs_fonts.js"></script>

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
#athlete-list_wrapper .top {
        display: flex;
        justify-content: space-between;
}
#athlete-list_wrapper .bottom {
   /* display: flex;*/
    justify-content: space-between;
    align-items: baseline;
}
</style>

<div class="common-forms-div">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="border-0 card shadow">
					
					<div class="align-items-center back-btn-cn card-header d-flex justify-content-between" style="">
						<h5 class="mb-0"> <liferay-ui:message key="athlete-details-list" /></h5>
						<div><a href="/group/guest/dashboard" class="btn btn-primary btn-sm rounded-pill back-btn-cn"><i class="bi bi-arrow-left-circle"></i>  <liferay-ui:message key="back" /></a></div>
					</div>
					
					<div class="card-body">
						<!-- filter -->
						<div class="filter-container">
							<!-- Filter Toggle Button -->
							<button class="btn btn-primary m-0" id="filterBtn">
								<liferay-ui:message key="filter" />
							</button>
							
							<!-- Filter Card -->
							<div class="filter-card mt-4" id="filterCard">
								<div class="card card-background p-0">
									<div class="card-header header-card">
											<liferay-ui:message key="filter-options" />
									</div>

							<form id="athlete-details" method="POST">
									<div class="card-body">
										<div class="row">
										    
											<div class="col-md-6">
	                                            <div class="form-group">
	                                                <label><liferay-ui:message key="first-name"/></label>
	                                                <input type="text" class="form-control" name="firstName" id="firstName" />
	                                            </div>
	                                        </div>
	                                        
	                                        <div class="col-md-6">
	                                            <div class="form-group">
	                                                <label><liferay-ui:message key="last-name"/></label>
	                                                <input type="text" class="form-control" name="lastName" id="lastName" />
	                                            </div>
	                                        </div>
	                                        
	                                        <div class="col-md-6">
	                                            <div class="form-group">
	                                                <label><liferay-ui:message key="contact-number"/></label>
	                                                <input type="text" class="form-control" name="contactNumber" id="contactNumber" />
	                                            </div>
	                                        </div>
	                                        
	                                        <div class="col-md-6">
	                                            <div class="form-group">
	                                                <label><liferay-ui:message key="designation"/></label>
	                                                <input type="text" class="form-control" name="designation" id="designation" />
	                                            </div>
	                                        </div>
										
										</div>
									</div>
								</form>
									
									<div class="card-footer text-right bg-white">
										<button type="button" class="btn btn-success" id="resetBtn">
					                        <liferay-ui:message key="reset" />
					                    </button>
										
										<button type="submit" class="btn btn-success" id="searchBtn">
											<liferay-ui:message key="search" />
										</button>
									</div>
								</div>
							</div>
						</div>
						<!-- filter  -->
					
				<div class="universal-table mt-4">
					<div class="">
					<table id="athlete-list" class="table-bordered" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><liferay-ui:message key="first-name"/></th>
							<th><liferay-ui:message key="last-name"/></th>
							<th><liferay-ui:message key="contact-number"/></th>
							<th><liferay-ui:message key="designation"/></th>
						</tr>
					</thead> 
					 
					<tbody>
					 <c:forEach var="athlete" items="${athleteList}">
						<tr>
							<td>${athlete.firstName}</td>
							<td>${athlete.lastName}</td>
							<td>${athlete.mobileNumber}</td>
							<td>${athlete.designation}</td>
							
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
</div>

<script>
$(document).ready(function() {
jQuery.noConflict();

var table = $('#athlete-list').DataTable({
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
	$('#firstName').val('');
	$('#lastName').val('');
	$('#contactNumber').val('');
	$('#designation').val('');
	
    const $filterCard = $('#filterCard');
    $filterCard.toggleClass('show');
    $(this).text($filterCard.hasClass('show') ? '<liferay-ui:message key='close' />' : '<liferay-ui:message key='filter' />');
});

$('#resetBtn').click(function() {
	$('#firstName').val('');
	$('#lastName').val('');
	$('#contactNumber').val('');
	$('#designation').val('');
    
    if (typeof table !== 'undefined') {
        table.search('').columns().search('').draw();
        $('.dataTables_filter input').val('');
    }
});

$(document).on('click', '#searchBtn', function () {
    table.search('').columns().search('').draw();
    $('.dataTables_filter input').val('');
    
    var firstName = $('#firstName').val().trim();
    var lastName = $('#lastName').val().trim();
    var contactNumber = $('#contactNumber').val().trim();
    var designation = $('#designation').val().trim();
    
    console.log("Searching : " + firstName );
    if (firstName) table.column(0).search(firstName);
    if (lastName) table.column(1).search(lastName);
    if (contactNumber) table.column(2).search(contactNumber);
    if (designation) table.column(3).search(designation);
    
    table.draw();
});

});
</script>