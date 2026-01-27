<%@ include file="/init.jsp"%>

<div class="card card-background p-0">
	<div class="personal_details">
		<div class="card-header header-card"><liferay-ui:message key="other"/></div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label><liferay-ui:message key="Received-Amount"/><sup class="text-danger">*</sup></label>
						<input type="text" class="form-control" name="otherTotalReceivedAmount" id="otherTotalReceivedAmount" readonly="readonly">
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="form-group">
						<label><liferay-ui:message key="construction-amount"/><sup class="text-danger">*</sup></label>
						<input type="text" class="form-control" name="otherTotalFacilityAmount" id="otherTotalFacilityAmount" readonly="readonly">
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="form-group">
						<label><liferay-ui:message key="equipment-amount"/><sup class="text-danger">*</sup></label>
						<input type="text" class="form-control" name="otherTotalExpenditureAmount" id="otherTotalExpenditureAmount" readonly="readonly">
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="form-group">
						<label><liferay-ui:message key="Total-Amount"/><sup class="text-danger">*</sup></label>
						<input type="text" class="form-control" name="otherTotalBalanceAmount" id="otherTotalBalanceAmount" readonly="readonly">
						<small style="font-size: x-small;">Note:<liferay-ui:message key="construction-amount"/> + <liferay-ui:message key="equipment-amount"/></small>
					</div>
				</div>
				
				<div class="col-md-6">
				  <div class="form-group">
				    <label for="totalExtraFund">
				      Total Extra Fund <sup class="text-danger">*</sup>
				    </label>
				    <input 
				      type="text" 
				      class="form-control" 
				      id="totalExtraFund" 
				      name="totalExtraFund" 
				      readonly
				     
				    >
				  </div>
				</div>
				
			</div>
		</div>
	</div>
</div>

<script>

function validate_other() {
	var totalReceivedAmount = $('#totalReceivedAmount').val();
	var totalExpenditureAmount = $('#totalExpenditureAmount').val();
	var totalFacilityAmount = $('#totalFacilityAmount').val();
	var totalOverallAmount = $('#totalOverallAmount').val();

	var totalGovtReceivedAmount = $('#totalGovtReceivedAmount').val();
	var totalGovtExpenditureAmount = $('#totalGovtExpenditureAmount').val();
	var totalGovtFacilityAmount = $('#totalGovtFacilityAmount').val();
	var totalGovtOverallAmount = $('#totalGovtOverallAmount').val();

	console.log("totalGovtReceivedAmount: "+totalGovtReceivedAmount+ " totalGovtExpenditureAmount: "+totalGovtExpenditureAmount+" totalGovtOverallAmount: "+totalGovtOverallAmount+" totalFacilityAmount: "+totalFacilityAmount)
	console.log("totalReceivedAmount: "+totalReceivedAmount+ " totalExpenditureAmount: "+totalExpenditureAmount+" totalOverallAmount: "+totalOverallAmount+" totalGovtFacilityAmount: "+totalGovtFacilityAmount)
	
	$("#otherTotalReceivedAmount").val(Number(totalReceivedAmount) + Number(totalGovtReceivedAmount));
	$("#otherTotalExpenditureAmount").val(Number(totalExpenditureAmount) + Number(totalGovtExpenditureAmount));
	$("#otherTotalFacilityAmount").val(Number(totalFacilityAmount) + Number(totalGovtFacilityAmount));
	$("#otherTotalBalanceAmount").val(Number(totalOverallAmount) + Number(totalGovtOverallAmount));
	
	return true;
}




</script>