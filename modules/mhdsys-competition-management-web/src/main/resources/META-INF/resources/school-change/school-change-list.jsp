<%@page import="com.mhdsys.competition.management.web.constants.CompetitionManagementWebPortletKeys"%>
<%@ include file="/init.jsp"%>

<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">

<!-- DataTables JS -->
<script type="text/javascript" src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>

<style>
    /* Custom styles for smooth transition */
    .filter-card {
        display: none;
        opacity: 0;
        transition: all 0.3s ease-in-out;
    }
    
    .filter-card.show {
        display: block;
        opacity: 1;
    }
    
    /* Ensure card stays below button */
    .filter-container {
        position: relative;
    }
    
    #school_change_list_wrapper .top {
    	display: flex;
    	justify-content: space-between;
    }
    
    .dt-info {
    	display: none;
    }
    
    #school_change_list_wrapper .bottom {
    	/*display: flex;*/
    	justify-content: space-between;
    	align-items: baseline;
    }
    .common-forms-div .card .card-body .btn {
    margin:0px;
    }
</style>


<div class="common-forms-div">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="border-0 card shadow">
					<div class="card-header d-flex align-items-center justify-content-between">
						<h5>
							<liferay-ui:message key="school-change-details" />
						</h5>
							
								<a href="/group/guest/competition-dashboard" class="btn btn-primary btn-sm rounded-pill back-btn-cn">
									<i class="bi bi-arrow-left-circle mr-1"></i> <liferay-ui:message key="back" />
								</a>
					</div>

					<div class="card-body">
					
					
					<!-- filter -->
						<div class="filter-container">
						    <!-- Filter Toggle Button -->
						    <button class="btn btn-primary" id="filterBtn">
						        <liferay-ui:message key="filter" />
						    </button>
						    
						    <!-- Filter Card -->
						    <div class="card filter-card mt-2" id="filterCard">
						        <div class="card-body p-0">
						            <div class="card-header">
						                <h5 class="card-title m-0">
						                    <liferay-ui:message key="filter-options" />
						                </h5>
						            </div>
						
						            <div class="card-body">
						                <div class="row">
						                    <div class="col-md-3">
						                        <div class="form-group">
						                            <label for="orderId"><liferay-ui:message key="participant-name" /></label> 
						                            <input type="text" class="form-control" id="name" />
						                        </div>
						                    </div>
						                
						                
						                    <div class="col-md-3">
						                        <div class="form-group">
						                            <label for="buyerId"><liferay-ui:message key="from-school" /></label> 
						                            <input type="text" class="form-control" id="fromSchool" />
						                        </div>
						                    </div>
						                
						                    <div class="col-md-3">
						                        <div class="form-group">
						                            <label for="buyerName"><liferay-ui:message key="to-school" /></label> 
						                            <input type="text" class="form-control" id="toSchool" />
						                        </div>
						                    </div>
						                </div>
						            </div>
						            <div class="card-footer text-right">
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
							<table id="school_change_list" class="table-bordered" cellspacing="0" width="100%">
									<thead>
										<tr>
											<th><liferay-ui:message key="participant-name" /></th>
											<th><liferay-ui:message key="from-school" /></th>
											<th><liferay-ui:message key="to-school" /></th>
											<th><liferay-ui:message key="action" /></th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="school" items="${schoolChangeList}">

											<portlet:renderURL var="schoolChangeViewURL">
												<portlet:param name="mvcRenderCommandName" value="<%=CompetitionManagementWebPortletKeys.SCHOOL_CHANGE_MVC_RENDER_COMMAND%>" />
												<portlet:param name="id" value="${school.schoolChangeId}" />
												<portlet:param name="mode" value="view" />
											</portlet:renderURL>

											<tr>
												<td>${school.participantName}</td>
												<td>${school.fromSchool}</td>
												<td>${school.toSchool}</td>
												<td>
												        <a href="${schoolChangeViewURL}"><i class="bi bi-patch-check" title="<liferay-ui:message key='view-verify' />"></i></a>
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
</div>

<script>
$(document).ready(function() {
	jQuery.noConflict();
	
    var reportTitle = "School Change Details Report";

    var table = $('#school_change_list').DataTable({
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
            "info": "<liferay-ui:message key='Showing-total-entries' />",
            "zeroRecords": "<liferay-ui:message key='No-matching-records-found' />",
            "infoEmpty": "<liferay-ui:message key='Showing-total-entries' />",
            oPaginate: {
                sNext: '<em class="bi bi-chevron-right"></em>',
                sPrevious: '<em class="bi bi-chevron-left"></em>'
            }
        },
        "layout": {
            topStart: { buttons: ['copy', 'csv', 'excel', 'pdf', 'print'] }
        },
        "dom": '<"top"Bf>rt<"bottom"lip><"clear">',
        "buttons": [
            {
                extend: 'copy',
                title: reportTitle,
                messageTop: '',
                exportOptions: { columns: ':not(:last-child)' }
            },
            {
                extend: 'csv',
                title: reportTitle,
                messageTop: '',
                exportOptions: { columns: ':not(:last-child)' }
            },
            {
                extend: 'excel',
                title: reportTitle,
                messageTop: '',
                exportOptions: { columns: ':not(:last-child)' }
            },
            {
                extend: 'pdf',
                title: reportTitle,
                messageTop: '',
                exportOptions: { columns: ':not(:last-child)' },
                customize: function(doc) {
                    doc.defaultStyle.fontSize = 8;
                    doc.styles.tableHeader.fontSize = 9;
                    doc.pageMargins = [20, 20, 20, 20];
                    doc.content[0].alignment = 'center'; 
                }
            },
            {
                extend: 'print',
                title: reportTitle,
                messageTop: '',
                exportOptions: { columns: ':not(:last-child)' }
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
		$('#name').val('');
        $('#fromSchool').val('');
        $('#toSchool').val('');
        
	    const $filterCard = $('#filterCard');
	    $filterCard.toggleClass('show');
	    $(this).text($filterCard.hasClass('show') ? '<liferay-ui:message key='close' />' : '<liferay-ui:message key='filter' />');
	});
	
	$('#resetBtn').click(function() {
		$('#name').val('');
        $('#fromSchool').val('');
        $('#toSchool').val('');
        
        if (typeof table !== 'undefined') {
            table.search('').columns().search('').draw();
            $('.dataTables_filter input').val('');
        }
    });

	$(document).on('click', '#searchBtn', function () {
		
	    table.search('').columns().search('').draw();
	    $('.dataTables_filter input').val('');
	    
	    var name = $('#name').val().trim();
	    var fromSchool = $('#fromSchool').val().trim();
	    var toSchool = $('#toSchool').val().trim();

	    console.log("Searching for: ", {
	    	name,
	    	fromSchool,
	    	toSchool
	    });
	    
	    if (name) table.column(0).search(name);
	    if (fromSchool) table.column(1).search(fromSchool);
	    if (toSchool) table.column(2).search(toSchool);

	    table.draw();
	});
});
</script>