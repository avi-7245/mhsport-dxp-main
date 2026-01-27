<%@ include file="/init.jsp"%>

<div class="card card-background p-0">
	<div class="personal_details">
		<div class="card-header header-card"><liferay-ui:message key="agency-details"/></div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-12">
				    <div class="form-group">
				        <label><liferay-ui:message key="contractor-appointed"/> <sup class="text-danger">*</sup></label>
				        <div class="d-flex mt-2">
						    <div class="radio-text">
						        <input type="radio" class="radio-btn" id="architectAppointedYes" name="architectAppointed" value="Yes"
						            <c:if test="${constructionTrackerDTO.architectAppointed == 'Yes'}">checked</c:if>
						            <c:if test="${mode eq 'view'}">disabled</c:if> checked />
						        <label for="architectAppointedYes"><liferay-ui:message key="yes"/></label>
						    </div>
						    <div class="radio-text ms-3">
						        <input type="radio" class="radio-btn" id="architectAppointedNo" name="architectAppointed" value="No"
						            <c:if test="${constructionTrackerDTO.architectAppointed == 'No'}">checked</c:if>
						            <c:if test="${mode eq 'view'}">disabled</c:if> />
						        <label for="architectAppointedNo"><liferay-ui:message key="no"/></label>
						    </div>
						</div>
				    </div>
				</div>
				<div class="col-md-6 agency-details-div">
					<div class="form-group">
						<label><liferay-ui:message key="architechture-name"/><sup class="text-danger">*</sup></label>
						<input type="text" class="form-control" name="executingAgency" id="executingAgency" <c:if test="${mode eq 'view'}">disabled</c:if> value="${constructionTrackerDTO.executingAgency }">
					</div>
				</div>
				
				<div class="col-md-6 agency-details-div">
					<div class="form-group">
						<label><liferay-ui:message key="name-Of-The-Firm"/><sup class="text-danger">*</sup></label>
						<input type="text" class="form-control" name="nameOfTheFirm" id="nameOfTheFirm" <c:if test="${mode eq 'view'}">disabled</c:if> value="${constructionTrackerDTO.nameOfTheFirm }" >
					</div>
				</div>
				
				<div class="col-md-6 agency-details-div">
					<div class="form-group">
						<label><liferay-ui:message key="contact-Number"/><sup class="text-danger">*</sup></label>
						<input class="form-control" name="agencyContactNumber" id="agencyContactNumber" <c:if test="${mode eq 'view'}">disabled</c:if> value="${constructionTrackerDTO.agencyContactNumber }">
					</div>
				</div>
				
				<div class="col-md-6 agency-details-div">
				<div class="form-group">
			    <label><liferay-ui:message key="is-contractor-appointed"/> <sup class="text-danger">*</sup></label>
			    <div class="d-flex mt-2">
			        <div class="radio-text">
			            <input type="radio" class="radio-btn" id="contractorAppointedPWD" name="contractorAppointed" value="PWD"
			                <c:if test="${constructionTrackerDTO.contractorAppointed == 'PWD'}">checked</c:if>
			                <c:if test="${mode eq 'view'}">disabled</c:if> />
			            <label for="contractorAppointedPWD"><liferay-ui:message key="pwd"/></label>
			        </div>
			        <div class="radio-text ms-3">
			            <input type="radio" class="radio-btn" id="contractorAppointedCommittee" name="contractorAppointed" value="Committee"
			                <c:if test="${constructionTrackerDTO.contractorAppointed == 'Committee'}">checked</c:if>
			                <c:if test="${mode eq 'view'}">disabled</c:if> />
			            <label for="contractorAppointedCommittee"><liferay-ui:message key="committee"/></label>
			        </div>
			    </div>
			</div>
			</div>
				
			</div>
		</div>
	</div>
</div>

<script>

function reset_agency_details(){
	if(!isEditMode){
		resetAllFields();
	 }
}

window.validate_agency_details = function () {
    console.log("Inside validate_agency_details ------ ");
    let isValid = true;

    const messages = {
			  architectAppointed: '<liferay-ui:message key="please-select-architect-appointed" />',
			  executingAgency: '<liferay-ui:message key="please-enter-architechture-name" />',
			  nameOfTheFirm: '<liferay-ui:message key="please-enter-name-of-the-firm" />',
    };

    $.each(messages, function (field, message) {
    	
    	if(field === "executingAgency" || field === "nameOfTheFirm" ){
       	 $form.find("#" + field).rules("add", {
       	        required: true,
       	        minlength: 3,
       	        maxlength: 75,
       	     	alphanumericWithPeroidAndHyphen: true,
	             noEdgeSpaces: true,
	             singleSpaceOnly: true,
	             noConsecutiveSpecials:true,
       	        messages: {
       	            required: message,
	       	        minlength: "<liferay-ui:message key='please-enter-min-3-characters' />",
	    	        maxlength: "<liferay-ui:message key='please-enter-max-75-characters' />",
       	        }
       	    });
       }else if(field === "agencyContactNumber"){
    	   $form.find("#" + field).rules("add", {
    	        required: true, digits: true, minlength: 10, maxlength: 10,validContact: true,
    	        messages: {
    	            required: '<liferay-ui:message key="please-enter-contact-number" />',
    	            digits: '<liferay-ui:message key="contact-number-digits-only" />',
    	            minlength: '<liferay-ui:message key="contact-number-should-be-10-digits" />',
    	            maxlength: '<liferay-ui:message key="contact-number-should-be-10-digits" />'
    	        }
    	    });
    	   
       }else if (field === "contractorAppointed") {
    	    $form.find("input[name='contractorAppointed']").rules("add", {
    	        required: true,
    	        messages: {
    	            required: '<liferay-ui:message key="please-select-is-contractor-appointed" />'
    	        }
    	    });
    	}
       else{
    	   $form.find("#" + field).rules("add", {
               required: true,
               messages: { required: message }
           });
       }
       
    }); 

    $("#agency-details")
        .find("input, select, textarea")
        .filter(":visible")
        .each(function () {
            if (!$form.validate().element(this)) {
                isValid = false;
            }
        });

    return isValid;
};

$(document).ready(function () {

	let architectAppointed = '${constructionTrackerDTO.architectAppointed}';
	if(architectAppointed == "Yes" || architectAppointed == ""){
		$('.agency-details-div').show();
	}else if(architectAppointed == "No"){
		 $('.agency-details-div').hide();
         $('.agency-details-div input').val('');
	}
	/* $('input[name="architectAppointed"]').on('change', function () {
	        const value = $(this).val();
	        if (value === 'No') {
	            $('.agency-details-div').hide();
	            $('.agency-details-div input').val('');
	        } else {
	            $('.agency-details-div').show();
	        }
	    }); */
	    
	    $('input[name="architectAppointed"]').on('change', function () {
	        const value = $(this).val();

	        if (value === 'No') {
	            // Clear and disable all inputs inside agency-details-div
	            $('.agency-details-div input[type="text"], .agency-details-div select, .agency-details-div textarea')
	                .val('')
	                .prop('disabled', true);

	            $('.agency-details-div input[type="radio"]')
	                .prop('checked', false)
	                .prop('disabled', true);
	        } else {
	            // Enable all inputs inside agency-details-div
	            $('.agency-details-div input, .agency-details-div select, .agency-details-div textarea')
	                .prop('disabled', false);

	            $('.agency-details-div input[type="radio"]').prop('disabled', false);
	        }
	    });


	
	$.validator.addMethod("alphanumericOnly", function(value, element) {
	    return this.optional(element) || /^[A-Za-z0-9 ]+$/.test(value);
	}, "<liferay-ui:message key='please-enter-alphanumeric-characters' />");
	$.validator.addMethod("noEdgeSpaces", function(value, element) {
		  return this.optional(element) || value === value.trim();
	}, "<liferay-ui:message key='no-leading-trailing-spaces-allowed' />");

	$.validator.addMethod("singleSpaceOnly", function(value, element) {
	  return this.optional(element) || !/\s{2,}/.test(value);
	}, "<liferay-ui:message key='only-one-space-between-words-allowed' />");
	
	$.validator.addMethod("noConsecutiveSpecials", function(value, element) {
		  return this.optional(element) || !/[.,/#-]{2,}/.test(value);
	}, "<liferay-ui:message key='no-consecutive-specials-allowed' />");
	
	$.validator.addMethod("validContact", function(value, element) {
        return this.optional(element) || /^[6-9]\d{9}$/.test(value);
    }, "<liferay-ui:message key='contact-number-invalid-pattern' />");
	
	 const messages = {
		        executingAgency: '<liferay-ui:message key="please-enter-architechture-name" />',
		        nameOfTheFirm: '<liferay-ui:message key="please-enter-name-of-the-firm" />',
		        architectAppointed: '<liferay-ui:message key="please-select-architect-appointed" />'
		    };

		    $.each(messages, function (field, message) {
		        if (field === "executingAgency" || field === "nameOfTheFirm") {
		            $("#" + field).rules("add", {
		            	  required: true,
		         	        minlength: 3,
		         	        maxlength: 75,
		         	     	alphanumericWithPeroidAndHyphen: true,
		  	             noEdgeSpaces: true,
		  	             singleSpaceOnly: true,
		  	             noConsecutiveSpecials:true,
		                messages: {
		                    required: message,
		                    minlength: "<liferay-ui:message key='please-enter-min-3-characters' />",
			    	        maxlength: "<liferay-ui:message key='please-enter-max-75-characters' />",
		                }
		            });
		        } else if(field === "agencyContactNumber"){
		     	   $form.find("#" + field).rules("add", {
		    	        required: true, digits: true, minlength: 10, maxlength: 10,validContact: true,
		    	        messages: {
		    	            required: '<liferay-ui:message key="please-enter-contact-number" />',
		    	            digits: '<liferay-ui:message key="contact-number-digits-only" />',
		    	            minlength: '<liferay-ui:message key="contact-number-should-be-10-digits" />',
		    	            maxlength: '<liferay-ui:message key="contact-number-should-be-10-digits" />'
		    	        }
		    	    });
		    	   
		       }else {
		            $("input[name='architectAppointed']").rules("add", {
		                required: true,
		                messages: { required: message }
		            });
		        }
		    });
		    
});

</script>