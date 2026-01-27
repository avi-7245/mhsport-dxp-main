
$(document).ready(function () {
    // Add a change event to all checkboxes with the class "ageGroupCheckbox"
    $('.ageGroupCheckbox').on('change', function () {
        if ($(this).is(':checked')) {
            $(this).val('true'); // Set value to true if checked
        } else {
            $(this).val('false'); // Set value to false if unchecked
        }
    });
});


function saveCompetitionMaster(){debugger



// First validate the form
    if (!$('#create_comp_master').valid()) {
        return;
    }
    
    // Collect sport details data
    collectSportDetailsData();
    
    // Get form data
    var formData = new FormData(document.getElementById('create_comp_master'));
	
 $.ajax({
        type: "POST",
        url: saveCompetitionMasterURL,
        data:  formData, 
        contentType : false,
		cache : false,
		processData : false,
        success: function(data){ 
        	console.log("data: ", typeof data);
        if (typeof data === 'string') {
            try {
                data = JSON.parse(data);
            } catch (e) {
                console.error("Failed to parse JSON response: ", e);
                return; 
            }
        }
        console.log("Parsed data: ", data);
        	if(data.createCompetition == true){
        		var $jq = jQuery.noConflict();
        		$jq("#saveCompetitionMasterModal").modal('show');
        		 /* $("#saveCompetitionMasterModal").modal('show');  */
        	}else{
        		var msg = competitionCreationErrorMessage;
        		 $("#saveCompetitionMasterModal").modal('show'); 
        	}
    	 }
       
    });
   
};

function closeModal() {
    $("#saveCompetitionMasterModal").modal('hide');
	$(".modal-backdrop").remove();
	$("body").removeClass("modal-open");
}





function collectSportDetailsData() {
    const sportName = document.getElementById('sportName').value;
    const selectedAgeGroup = document.querySelector('input[name="ageGroup"]:checked')?.value;
    
    // Reset all hidden fields first
    document.querySelectorAll('input[type="hidden"][id$="Data"]').forEach(field => {
        field.value = '';
    });
    
    if (!sportName || !selectedAgeGroup) return;
    
    const sport = sportData[sportName];
    if (!sport) return;
    
    // Set sport type
    const sportTypeData = document.getElementById('sportTypeData');
    if (sportTypeData) sportTypeData.value = sport.type;
    
    const ageData = sport.ages[selectedAgeGroup];
    if (!ageData) return;
    
    // Collect data based on sport type
    switch(sport.type) {
        case 'team':
            if (document.getElementById('teamSizeData')) {
                document.getElementById('teamSizeData').value = document.getElementById('teamSize')?.value || ageData.teamSize || '';
            }
            if (document.getElementById('groundSizeData')) {
                document.getElementById('groundSizeData').value = document.getElementById('groundSize')?.value || ageData.groundSize || '';
            }
            if (document.getElementById('netHeightData')) {
                document.getElementById('netHeightData').value = document.getElementById('netHeight')?.value || ageData.netHeight || '';
            }
            break;
            
        case 'individual':
            if (document.getElementById('participantsCountData')) {
                document.getElementById('participantsCountData').value = document.getElementById('participantsCount')?.value || ageData.participants || '';
            }
            if (document.getElementById('competitionTypeData')) {
                document.getElementById('competitionTypeData').value = document.getElementById('competitionType')?.value || ageData.competitionType || '';
            }
            break;
            
        case 'weight':
            if (document.getElementById('weightCategoriesData')) {
                document.getElementById('weightCategoriesData').value = document.getElementById('weightCategories')?.value || ageData.weights || '';
            }
            break;
            
        case 'athletics':
            const athleticsBoysEvents = Array.from(document.getElementById('athleticsBoysEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            const athleticsGirlsEvents = Array.from(document.getElementById('athleticsGirlsEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            if (document.getElementById('boysEventsData')) document.getElementById('boysEventsData').value = athleticsBoysEvents;
            if (document.getElementById('girlsEventsData')) document.getElementById('girlsEventsData').value = athleticsGirlsEvents;
            break;
            
        case 'swimming':
            const swimmingBoysEvents = Array.from(document.getElementById('swimmingBoysEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            const swimmingGirlsEvents = Array.from(document.getElementById('swimmingGirlsEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            if (document.getElementById('boysEventsData')) document.getElementById('boysEventsData').value = swimmingBoysEvents;
            if (document.getElementById('girlsEventsData')) document.getElementById('girlsEventsData').value = swimmingGirlsEvents;
            break;
            
        case 'cycling':
            const cyclingBoysEvents = Array.from(document.getElementById('cyclingBoysEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            const cyclingGirlsEvents = Array.from(document.getElementById('cyclingGirlsEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            if (document.getElementById('boysEventsData')) document.getElementById('boysEventsData').value = cyclingBoysEvents;
            if (document.getElementById('girlsEventsData')) document.getElementById('girlsEventsData').value = cyclingGirlsEvents;
            break;
            
        case 'yoga':
            const yogaBoysCategories = Array.from(document.getElementById('yogaBoysCategories')?.selectedOptions || [])
                .map(option => option.value).join('|');
            const yogaGirlsCategories = Array.from(document.getElementById('yogaGirlsCategories')?.selectedOptions || [])
                .map(option => option.value).join('|');
            if (document.getElementById('boysEventsData')) document.getElementById('boysEventsData').value = yogaBoysCategories;
            if (document.getElementById('girlsEventsData')) document.getElementById('girlsEventsData').value = yogaGirlsCategories;
            break;
            
        case 'shooting':
            const shootingBoysEvents = Array.from(document.getElementById('shootingBoysEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            const shootingGirlsEvents = Array.from(document.getElementById('shootingGirlsEvents')?.selectedOptions || [])
                .map(option => option.value).join('|');
            if (document.getElementById('boysEventsData')) document.getElementById('boysEventsData').value = shootingBoysEvents;
            if (document.getElementById('girlsEventsData')) document.getElementById('girlsEventsData').value = shootingGirlsEvents;
            break;
            
        case 'special':
            if (document.getElementById('specialDetailsData')) {
                document.getElementById('specialDetailsData').value = document.getElementById('specialDetails')?.value || ageData.details || '';
            }
            break;
    }
    
    // Log the collected data for debugging
    document.getElementById('sportId').value = document.getElementById('sportName').options[document.getElementById('sportName').selectedIndex].getAttribute('data-id');
    console.log("Collected Sport Details Data:");
    console.log("Sport Type:", document.getElementById('sportTypeData').value);
    console.log("Team Size:", document.getElementById('teamSizeData').value);
    console.log("Ground Size:", document.getElementById('groundSizeData').value);
    console.log("Net Height:", document.getElementById('netHeightData').value);
    console.log("Participants Count:", document.getElementById('participantsCountData').value);
    console.log("Competition Type:", document.getElementById('competitionTypeData').value);
    console.log("Weight Categories:", document.getElementById('weightCategoriesData').value);
    console.log("Boys Events:", document.getElementById('boysEventsData').value);
    console.log("Girls Events:", document.getElementById('girlsEventsData').value);
    console.log("Special Details:", document.getElementById('specialDetailsData').value);
}
