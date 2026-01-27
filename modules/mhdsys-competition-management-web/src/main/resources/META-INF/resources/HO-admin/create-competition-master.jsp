<%@ include file="/init.jsp" %>

<div class="common-forms-div">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="border-0 card shadow">
                    <div class="align-items-center back-btn-cn card-header d-flex justify-content-between">
                        <h5><liferay-ui:message key="create-competition-master"/></h5>						
                        <div>
                            <a href="/group/guest/competition-dashboard" class="btn btn-primary btn-sm rounded-pill back-btn-cn">  
                                <i class="bi bi-arrow-left-circle mr-1"></i> <liferay-ui:message key="back" /> 
                            </a>
                        </div>
                    </div>
                    
                    <form id="create_comp_master" autocomplete="off"> 
                    <!-- Add all these hidden fields to your form -->
						<input type="hidden" id="sportTypeData" name="sportTypeData" />
						<input type="hidden" id="teamSizeData" name="teamSizeData" />
						<input type="hidden" id="groundSizeData" name="groundSizeData" />
						<input type="hidden" id="netHeightData" name="netHeightData" />
						<input type="hidden" id="participantsCountData" name="participantsCountData" />
						<input type="hidden" id="competitionTypeData" name="competitionTypeData" />
						<input type="hidden" id="weightCategoriesData" name="weightCategoriesData" />
						<input type="hidden" id="boysEventsData" name="boysEventsData" />
						<input type="hidden" id="girlsEventsData" name="girlsEventsData" />
						<input type="hidden" id="specialDetailsData" name="specialDetailsData" />
                        <div class="card-body">
                            <div class="card card-background p-0">
                                <div class="card-header header-card"><liferay-ui:message key="create-competition-master"/></div>
                                <div class="card-body">
                                    <!-- Sport and Category Selection -->
                                    <div class="row">
                                        <div class="col-md-6">
										    <div class="form-group">
										        <label><liferay-ui:message key="sports-name"/><sup class="text-danger">*</sup></label>
										        <select class="form-control" name="sportName" id="sportName" onchange="loadSportDetails()">
										            <option value=""><liferay-ui:message key="select" /></option>
										            <c:forEach var="sportsMaster" items="${sportsMaster}">
										                <option value="${sportsMaster.name_en}" data-id="${sportsMaster.sportMasterId}">
										                    ${sportsMaster.name_en}
										                </option>
										            </c:forEach>
										        </select>
										        <input type="hidden" name="sportId" id="sportId" />
										    </div>
										</div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="category"/><sup class="text-danger">*</sup></label>
                                                <select class="form-control" name="category" id="category" onchange="loadSportDetails()">
                                                    <option value=""><liferay-ui:message key="select" /></option>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.categoryMasterId}">${category.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Age Group Selection with Radio Buttons and Dates -->
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group age-group">
                                                <label><liferay-ui:message key="age-group" /></label>
                                                <div>
                                                    <input type="radio" id="ageGroupUnder14" name="ageGroup" value="14" class="ageGroupRadio" onchange="handleAgeGroupChange()" />
                                                    <label for="ageGroupUnder14" class="pl-2"><liferay-ui:message key="under-14" /></label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="under-14-cut-off-date"/></label>
                                                <input type="date" class="form-control" name="underForteenCutOffDate" id="underForteenCutOffDate" value="" disabled />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group age-group">
                                                <label><liferay-ui:message key="age-group" /></label>
                                                <div>
                                                    <input type="radio" name="ageGroup" value="17" id="underSeventeen" class="ageGroupRadio" onchange="handleAgeGroupChange()" />
                                                    <label for="underSeventeen" class="pl-2"><liferay-ui:message key="under-17"/></label>	
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="under-17-cut-off-date"/></label>
                                                <input type="date" class="form-control" name="underSeventeenCutOffDate" id="underSeventeenCutOffDate" value="" disabled />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group age-group">
                                                <label><liferay-ui:message key="age-group" /></label>
                                                <div>
                                                    <input type="radio" name="ageGroup" value="19" id="underNineteen" class="ageGroupRadio" onchange="handleAgeGroupChange()"/>
                                                    <label for="underNineteen" class="pl-2"><liferay-ui:message key="under-19"/></label>
                                                </div>			
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="under-19-cut-off-date"/></label>
                                                <input type="date" class="form-control" name="underNineteenCutOffDate" id="underNineteenCutOffDate" value="" disabled />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Dynamic Sport Details Section -->
                                    <div id="sportDetailsSection" style="display: none;">
                                        <hr>
                                        <h5 class="text-primary"><liferay-ui:message key="sport-specific-details"/></h5>
                                        
                                        <!-- Team Sports Details -->
                                        <div id="teamSportsDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="team-size"/></label>
                                                        <input type="number" class="form-control" id="teamSize" name="teamSize">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="ground-size"/></label>
                                                        <input type="text" class="form-control" id="groundSize" name="groundSize">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="net-height"/></label>
                                                        <input type="text" class="form-control" id="netHeight" name="netHeight">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Individual Sports Details -->
                                        <div id="individualSportsDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="participants-count"/></label>
                                                        <input type="number" class="form-control" id="participantsCount" name="participantsCount">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="competition-type"/></label>
                                                        <input type="text" class="form-control" id="competitionType" name="competitionType">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Weight Category Sports -->
                                        <div id="weightCategoryDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="weight-categories"/></label>
                                                        <textarea class="form-control" id="weightCategories" name="weightCategories" rows="4"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Athletics Details -->
                                        <div id="athleticsDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="boys-events"/></label>
                                                        <select class="form-control" id="athleticsBoysEvents" name="athleticsBoysEvents" multiple size="8">
                                                            <!-- Boys athletics events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="girls-events"/></label>
                                                        <select class="form-control" id="athleticsGirlsEvents" name="athleticsGirlsEvents" multiple size="8">
                                                            <!-- Girls athletics events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Swimming Details -->
                                        <div id="swimmingDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="boys-events"/></label>
                                                        <select class="form-control" id="swimmingBoysEvents" name="swimmingBoysEvents" multiple size="8">
                                                            <!-- Boys swimming events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="girls-events"/></label>
                                                        <select class="form-control" id="swimmingGirlsEvents" name="swimmingGirlsEvents" multiple size="8">
                                                            <!-- Girls swimming events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Cycling Details -->
                                        <div id="cyclingDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="boys-events"/></label>
                                                        <select class="form-control" id="cyclingBoysEvents" name="cyclingBoysEvents" multiple size="6">
                                                            <!-- Boys cycling events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="girls-events"/></label>
                                                        <select class="form-control" id="cyclingGirlsEvents" name="cyclingGirlsEvents" multiple size="6">
                                                            <!-- Girls cycling events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Yoga Details -->
                                        <div id="yogaDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="boys-categories"/></label>
                                                        <select class="form-control" id="yogaBoysCategories" name="yogaBoysCategories" multiple size="6">
                                                            <!-- Boys yoga categories will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple categories</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="girls-categories"/></label>
                                                        <select class="form-control" id="yogaGirlsCategories" name="yogaGirlsCategories" multiple size="6">
                                                            <!-- Girls yoga categories will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple categories</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Shooting Details -->
                                        <div id="shootingDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="boys-events"/></label>
                                                        <select class="form-control" id="shootingBoysEvents" name="shootingBoysEvents" multiple size="6">
                                                            <!-- Boys shooting events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="girls-events"/></label>
                                                        <select class="form-control" id="shootingGirlsEvents" name="shootingGirlsEvents" multiple size="6">
                                                            <!-- Girls shooting events will be populated dynamically -->
                                                        </select>
                                                        <small class="form-text text-muted">Hold Ctrl to select multiple events</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Special Sports Details -->
                                        <div id="specialSportsDetails" class="sport-detail-category">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label><liferay-ui:message key="special-details"/></label>
                                                        <textarea class="form-control" id="specialDetails" name="specialDetails" rows="4"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Common Fields -->
                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="fees-for-competition"/><sup class="text-danger">*</sup></label>
                                                <input type="text" class="form-control" name="fees" value="" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="granted/non-granted"/><sup class="text-danger">*</sup></label>
                                                <select class="form-control" name="sportType">
                                                    <option value=""><liferay-ui:message key="select" /></option>
                                                    <option value="1"><liferay-ui:message key="granted" /></option>
                                                    <option value="2"><liferay-ui:message key="non-granted" /></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="mandatory-for-current-year" /><sup class="text-danger">*</sup></label>
                                                <div class="d-flex mt-2">
                                                    <div class="radio-text">
                                                        <input type="radio" class="radio-btn" name="currentYear" id="mandatoryYearYes" value="1" /> 
                                                        <label for="mandatoryYearYes"><liferay-ui:message key="yes" /></label>
                                                    </div>
                                                    <div class="ml-3">
                                                        <input type="radio" class="radio-btn" name="currentYear" id="mandatoryYearNo" value="0" /> 
                                                        <label for="mandatoryYearNo"><liferay-ui:message key="no" /></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    
                    <div class="card-footer bg-transparent text-right p-4">
                        <div class="d-flex justify-content-end">
                            <a href="/group/guest/competition-dashboard" class="btn btn-secondary maha-save-btn" id="modalCloseBtn">
                                <liferay-ui:message key="cancel"/>
                            </a>
                            <button type="button" class="btn btn-primary reset-btn" id="reset-btn">
                                <liferay-ui:message key="reset" />
                            </button>
                            <button class="btn btn-primary" onclick="saveCompetitionMaster()"><liferay-ui:message key="save" /></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Success Modal -->
<div class="modal fade" id="saveCompetitionMasterModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content modal-bg">
            <div class="modal-header justify-content-center align-items-center">
                <h5 class="modal-title" id="exampleModalLongTitle"><liferay-ui:message key="add-competition-master"/></h5>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div>
                            <img src="<%=request.getContextPath()%>/images/check.png" alt="" width="50px" class="my-3">
                            <p class="text-primary mt-2"><liferay-ui:message key="competition-master-has-been-successfully-created"/></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-end">
                <a href="/group/guest/competition-dashboard" type="button" id="closeModal" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal"><liferay-ui:message key="close"/></a>
            </div>
        </div>
    </div>
</div>

<script>
// Complete Sport data structure based on ALL 41 sports from Excel sheets
const sportData = {
    // ATHLETICS
    "Athletics": {
        type: "athletics",
        ages: {
            "14": { 
                boysEvents: [
                    "100 m. run", "200 m. run", "400 m. run", "600 m. Run", 
                    "80 m. Hurdle (Height-0.76 m.)", "Plate Throw (Weight - 1 kg.)", 
                    "Shot put (weight - 4 kg)", "Long jump", "High jump", 
                    "4 x 100m relays", "4 x 400m relays"
                ],
                girlsEvents: [
                    "100 m. run", "200 m. run", "400 m. run", "600 m. Run", 
                    "80 m. Hurdle (Height-0.76 m.)", "Plate Throw (Weight - 1 kg.)", 
                    "Shot put (weight - 3 kg)", "Long jump", "High jump", 
                    "4 x 100m relays", "4 x 400m relays"
                ]
            },
            "17": { 
                boysEvents: [
                    "100 m. run", "200 m. run", "400 m. run", "800 m. Run", 
                    "1100 m. Run", "3000 m. run", "5000 m. run", "400m hurdles",
                    "110 m. Hurdle (Height-0.91 m.)", "Long jump", "High jump", 
                    "Triple jump", "Bamboo jump", "Plate Throw (Weight-1.5 kg.)", 
                    "Shot put (weight-5 kg)", "Javelin throw (weight-700 grams)", 
                    "Hammer throw (weight-5 kg)", "4 x 400m relays", "5 km. Walk", 
                    "Crosscountry 6 km"
                ],
                girlsEvents: [
                    "100 m. run", "200 m. run", "400 m. run", "800 m. Run", 
                    "100 m. Hurdles", "3000 m. run", "400m hurdles", "Long jump", 
                    "High jump", "Triple jump", "Bamboo jump", 
                    "Plate Throw (Weight-1 kg.)", "Shot put (weight-4 kg)", 
                    "Javelin throw (weight-500 grams)", "Hammer throw (weight-4 kg)", 
                    "4 x 400m relays", "3 km walk", "Crosscountry 4 km"
                ]
            },
            "19": { 
                boysEvents: [
                    "100 m. run", "200 m. run", "400 m. run", "800 m. Run", 
                    "1500 m. Run", "3000 m. run", "5000 m. run", "400m hurdles",
                    "11 m. Hurdle (Height-1.06 m.)", "Long jump", "High jump", 
                    "Triple jump", "Bamboo jump", "Plate Throw (Weight-1.75 kg.)", 
                    "Shot put (weight-6 kg)", "Javelin throw (weight-800 grams)", 
                    "Hammer throw (weight-7.26 kg)", "4 x 400m relays", "5 km. Walk", 
                    "Cross Country 8 km"
                ],
                girlsEvents: [
                    "100 m. run", "200 m. run", "400 m. run", "800 m. Run", 
                    "1500 m. Run", "3000 m. run", "5000 m. run", "400m hurdles",
                    "1500 m. Hurdle (Height-0.76 m.)", "Long jump", "High jump", 
                    "Triple jump", "Bamboo jump", "Plate Throw (Weight-1 kg.)", 
                    "Shot put (weight-4 kg)", "Javelin throw (weight-600 grams)", 
                    "Hammer throw (weight-4 kg)", "4 x 400m relays", "3 km walk", 
                    "Crosscountry 6 km"
                ]
            }
        }
    },

    // CYCLING
    "Cycling": {
        type: "cycling",
        ages: {
            "14": { 
                boysEvents: ["5 km Individual Time Trial", "10 km Mass Start"],
                girlsEvents: ["5 km Individual Time Trial", "7 km Mass Start"]
            },
            "17": { 
                boysEvents: ["15 km Individual Time Trial", "20 km Mass Start"],
                girlsEvents: ["10 km Individual Time Trial", "15 km Mass Start"]
            },
            "19": { 
                boysEvents: ["15 km Individual Time Trial", "20 km Mass Start"],
                girlsEvents: ["10 km Individual Time Trial", "15 km Mass Start"]
            }
        }
    },

    // ARCHERY
    "Archery": {
        type: "individual",
        ages: {
            "14": { participants: 12, competitionType: "40m Recurve, 40m Compound, 30m Indian" },
            "17": { participants: 12, competitionType: "60m Recurve, 50m Compound, 30m Indian" },
            "19": { participants: 12, competitionType: "70m Recurve, 50m Compound, 40m Indian" }
        }
    },

    // YOGA
    "Yogasana": {
        type: "yoga",
        ages: {
            "14": { 
                boysCategories: ["Traditional Yogasana Single", "Artistic Yogasana Single", "Artistic Yogasana Pair", "Rhythmic Yogasana Pair"],
                girlsCategories: ["Traditional Yogasana Single", "Artistic Yogasana Single", "Artistic Yogasana Pair", "Rhythmic Yogasana Pair"]
            },
            "17": { 
                boysCategories: ["Traditional Yogasana Single", "Artistic Yogasana Single", "Artistic Yogasana Pair", "Rhythmic Yogasana Pair"],
                girlsCategories: ["Traditional Yogasana Single", "Artistic Yogasana Single", "Artistic Yogasana Pair", "Rhythmic Yogasana Pair"]
            },
            "19": { 
                boysCategories: ["Traditional Yogasana Single", "Artistic Yogasana Single", "Artistic Yogasana Pair", "Rhythmic Yogasana Pair"],
                girlsCategories: ["Traditional Yogasana Single", "Artistic Yogasana Single", "Artistic Yogasana Pair", "Rhythmic Yogasana Pair"]
            }
        }
    },

    // GYMNASTICS
    "Gymnastics": {
        type: "special",
        ages: {
            "14": { details: "Floor Exercises, Pommel Horse, Rings, Vault, Parallel Bars, Horizontal Bar, All-round, Balancing Beam, Uneven Bars" },
            "17": { details: "All Artistic events, Rhythmic events" },
            "19": { details: "Team: 7 Boys, 6 Girls - All Artistic and Rhythmic events" }
        }
    },

    // SHOOTING
    "Shooting": {
        type: "shooting",
        ages: {
            "14": { 
                boysEvents: ["1.77 Peep Sight Air Rifle", "1.77 Air Pistol", "1.77 Open Sight Air Rifle"],
                girlsEvents: ["1.77 Peep Sight Air Rifle", "1.77 Air Pistol", "1.77 Open Sight Air Rifle"]
            },
            "17": { 
                boysEvents: ["1.77 Peep Sight Air Rifle", "1.77 Air Pistol", "1.77 Open Sight Air Rifle"],
                girlsEvents: ["1.77 Peep Sight Air Rifle", "1.77 Air Pistol", "1.77 Open Sight Air Rifle"]
            },
            "19": { 
                boysEvents: ["1.77 Peep Sight Air Rifle", "1.77 Air Pistol", "1.77 Open Sight Air Rifle"],
                girlsEvents: ["1.77 Peep Sight Air Rifle", "1.77 Air Pistol", "1.77 Open Sight Air Rifle"]
            }
        }
    },

    // SWIMMING
    "Swimming": {
        type: "swimming",
        ages: {
            "14": { 
                boysEvents: [
                    "50 m. Freestyle", "100 m. Freestyle", "200 m. Freestyle", "400 m. Freestyle",
                    "50 m. Backstroke", "100 m. Backstroke", "50m Breaststroke", "100m Breaststroke",
                    "50 m. Butterfly", "200m Individual Middle Distance", "4 x 50m freestyle relay",
                    "4 x 100 m freestyle relay", "Diving - 1 and 3 m. Spring board, highboard - 5 m."
                ],
                girlsEvents: [
                    "50 m. Freestyle", "100 m. Freestyle", "200 m. Freestyle", "400 m. Freestyle",
                    "50 m. Backstroke", "100 m. Backstroke", "50m Breaststroke", "100m Breaststroke",
                    "50 m. Butterfly", "200m Individual Middle Distance", "4 x 50m freestyle relay",
                    "4 x 100 m freestyle relay", "Diving - 1 and 3 m. Spring board, highboard - 5 m."
                ]
            },
            "17": { 
                boysEvents: [
                    "50 m. Freestyle", "100 m. Freestyle", "200 m. Freestyle", "400 m. Freestyle",
                    "800 m. Freestyle", "100 m. Backstroke", "200 m. Backstroke", "100m Breaststroke",
                    "200m Breaststroke", "100 m. Butterfly", "200 m. Butterfly", "200m Individual Middle Distance",
                    "400 m. Individual Middle Distance", "4 x 100 m freestyle relay", "4 x 50 m. Midlen Relay",
                    "4 x 100 m. Midlen Relay", "Diving - 3 m. Spring board, highboard - 7.5 m."
                ],
                girlsEvents: [
                    "50 m. Freestyle", "100 m. Freestyle", "200 m. Freestyle", "400 m. Freestyle",
                    "800 m. Freestyle", "100 m. Backstroke", "200 m. Backstroke", "100m Breaststroke",
                    "200m Breaststroke", "100 m. Butterfly", "200 m. Butterfly", "200m Individual Middle Distance",
                    "400 m. Individual Middle Distance", "4 x 100 m freestyle relay", "4 x 50 m. Midlen Relay",
                    "4 x 100 m. Midlen Relay", "Diving - 3 m. Spring board, highboard - 7.5 m."
                ]
            },
            "19": { 
                boysEvents: [
                    "50 m. Freestyle", "100 m. Freestyle", "200 m. Freestyle", "400 m. Freestyle",
                    "800 m. Freestyle", "100 m. Backstroke", "200 m. Backstroke", "100m Breaststroke",
                    "200m Breaststroke", "100 m. Butterfly", "200 m. Butterfly", "200m Individual Middle Distance",
                    "400 m. Individual Middle Distance", "4 x 100 m freestyle relay", "4 x 100 m. Midlen Relay",
                    "4 x 50m freestyle relay", "4 x 50 m. Midlen Relay", 
                    "Diving - 1 and 3 m. Spring board, highboard - 10 m."
                ],
                girlsEvents: [
                    "50 m. Freestyle", "100 m. Freestyle", "200 m. Freestyle", "400 m. Freestyle",
                    "800 m. Freestyle", "100 m. Backstroke", "200 m. Backstroke", "100m Breaststroke",
                    "200m Breaststroke", "100 m. Butterfly", "200 m. Butterfly", "200m Individual Middle Distance",
                    "400 m. Individual Middle Distance", "4 x 100 m freestyle relay", "4 x 100 m. Midlen Relay",
                    "4 x 50m freestyle relay", "4 x 50 m. Midlen Relay", 
                    "Diving - 1 and 3 m. Spring board, highboard - 10 m."
                ]
            }
        }
    },

    // CHESS
    "Chess": {
        type: "individual",
        ages: {
            "14": { participants: 5, competitionType: "Swiss League Format" },
            "17": { participants: 5, competitionType: "Swiss League Format" },
            "19": { participants: 5, competitionType: "Swiss League Format" }
        }
    },

    // BADMINTON
    "Badminton": {
        type: "team",
        ages: {
            "14": { teamSize: 5, groundSize: "13.40m x 5.18m", netHeight: "Standard" },
            "17": { teamSize: 5, groundSize: "Standard court", netHeight: "Standard" },
            "19": { teamSize: 5, groundSize: "Standard court", netHeight: "Standard" }
        }
    },

    // WRESTLING
    "Wrestling": {
        type: "weight",
        ages: {
            "14": { weights: "35kg, 38kg, 41kg, 44kg, 48kg, 52kg, 57kg, 62kg, 68kg, 75kg (Freestyle)" },
            "17": { weights: "45kg, 48kg, 51kg, 55kg, 60kg, 65kg, 71kg, 80kg, 92kg, 110kg (Freestyle & Greco-Roman)" },
            "19": { weights: "57kg, 61kg, 65kg, 70kg, 74kg, 79kg, 86kg, 92kg, 97kg, 125kg (Freestyle & Greco-Roman)" }
        }
    },

    // JUDO
    "Judo": {
        type: "weight",
        ages: {
            "14": { weights: "Below 25kg, Below 30kg, Below 35kg, Below 40kg, Below 45kg, Below 50kg, Above 50kg" },
            "17": { weights: "Below 40kg, Below 45kg, Below 50kg, Below 55kg, Below 60kg, Below 66kg, Below 73kg, Below 81kg, Below 90kg, Above 90kg" },
            "19": { weights: "Below 40kg, Below 45kg, Below 50kg, Below 55kg, Below 60kg, Below 66kg, Below 73kg, Below 81kg, Below 90kg, Above 90kg" }
        }
    },

    // KARATE
    "Karate": {
        type: "weight",
        ages: {
            "14": { weights: "-20kg, -25kg, -30kg, -35kg, -40kg, -45kg, -50kg, -55kg, -60kg, +60kg (Boys); -18kg, -22kg, -24kg, -26kg, -30kg, -34kg, -38kg, -42kg, -46kg, -50kg, +50kg (Girls)" },
            "17": { weights: "-35kg to +82kg (Multiple categories for Boys & Girls)" },
            "19": { weights: "-35kg to +82kg (Multiple categories for Boys & Girls)" }
        }
    },

    // TAEKWONDO
    "Taekwondo": {
        type: "weight",
        ages: {
            "14": { weights: "-18kg to +41kg (Multiple categories for Boys & Girls)" },
            "17": { weights: "-35kg to +78kg (Multiple categories for Boys & Girls)" },
            "19": { weights: "-45kg to +83kg (Multiple categories for Boys & Girls)" }
        }
    },

    // BOXING
    "Boxing": {
        type: "weight",
        ages: {
            "14": { weights: "28-30kg, 30-32kg, 32-34kg, 34-36kg, 36-38kg, 38-40kg, 40-42kg, 42-44kg, 44-46kg, 46-48kg, 48-50kg" },
            "17": { weights: "Below 46kg, 46-48kg, 48-50kg, 50-52kg, 52-54kg, 54-57kg, 57-60kg, 60-63kg, 63-66kg, 66-69kg, 69-75kg, 75-80kg, Above 80kg" },
            "19": { weights: "Below 42kg, 42-44kg, 44-46kg, 46-48kg, 48-50kg, 50-52kg, 52-54kg, 54-57kg, 57-60kg, 60-63kg, 63-66kg, 66-69kg, 69-75kg, 75-80kg, Above 80kg" }
        }
    },

    // WEIGHTLIFTING
    "Weightlifting": {
        type: "weight",
        ages: {
            "17": { weights: "49kg, 55kg, 61kg, 67kg, 73kg, 81kg, 89kg, +89kg (Boys); 40kg, 45kg, 49kg, 55kg, 59kg, 64kg, 71kg, +71kg (Girls)" },
            "19": { weights: "49kg, 55kg, 61kg, 67kg, 73kg, 81kg, 89kg, +89kg (Boys); 40kg, 45kg, 49kg, 55kg, 59kg, 64kg, 71kg, +71kg (Girls)" }
        }
    },

    // KABADDI
    "Kabaddi": {
        type: "team",
        ages: {
            "14": { teamSize: 12, groundSize: "12×9 sq.m", netHeight: "N/A" },
            "17": { teamSize: 12, groundSize: "12×9 sq.m", netHeight: "N/A" },
            "19": { teamSize: 12, groundSize: "13×10 sq.m", netHeight: "N/A" }
        }
    },

    // KHO-KHO
    "Kho Kho": {
        type: "team",
        ages: {
            "14": { teamSize: 15, groundSize: "23m×14m", netHeight: "N/A" },
            "17": { teamSize: 15, groundSize: "27m×16m", netHeight: "N/A" },
            "19": { teamSize: 15, groundSize: "27m×16m", netHeight: "N/A" }
        }
    },

    // VOLLEYBALL
    "Volleyball": {
        type: "team",
        ages: {
            "14": { teamSize: 12, groundSize: "18×9 sq.m", netHeight: "2.18m" },
            "17": { teamSize: 12, groundSize: "18×9 sq.m", netHeight: "2.43m(B), 2.24m(G)" },
            "19": { teamSize: 12, groundSize: "18×9 sq.m", netHeight: "2.43m(B), 2.24m(G)" }
        }
    },

    // FOOTBALL
    "Football": {
        type: "team",
        ages: {
            "14": { teamSize: 18, groundSize: "100m×55m", netHeight: "N/A" },
            "17": { teamSize: 18, groundSize: "100m×65m", netHeight: "N/A" },
            "19": { teamSize: 18, groundSize: "100m×65m", netHeight: "N/A" }
        }
    },

    // CRICKET
    "Cricket": {
        type: "team",
        ages: {
            "14": { teamSize: 16, groundSize: "60m boundary", netHeight: "N/A" },
            "17": { teamSize: 16, groundSize: "65m boundary", netHeight: "N/A" },
            "19": { teamSize: 16, groundSize: "75m boundary", netHeight: "N/A" }
        }
    },

    // BASKETBALL
    "Basketball": {
        type: "team",
        ages: {
            "14": { teamSize: 12, groundSize: "Standard court", netHeight: "3.05m" },
            "17": { teamSize: 12, groundSize: "Standard court", netHeight: "3.05m" },
            "19": { teamSize: 12, groundSize: "Standard court", netHeight: "3.05m" }
        }
    },

    // HOCKEY
    "Hockey": {
        type: "team",
        ages: {
            "14": { teamSize: 18, groundSize: "Standard field", netHeight: "N/A" },
            "17": { teamSize: 18, groundSize: "Standard field", netHeight: "N/A" },
            "19": { teamSize: 18, groundSize: "Standard field", netHeight: "N/A" }
        }
    },

    // Add remaining sports here...
    "Handball": {
        type: "team",
        ages: {
            "14": { teamSize: 16, groundSize: "Standard court", netHeight: "N/A" },
            "17": { teamSize: 16, groundSize: "Standard court", netHeight: "N/A" },
            "19": { teamSize: 16, groundSize: "Standard court", netHeight: "N/A" }
        }
    },

    "Table Tennis": {
        type: "team",
        ages: {
            "14": { teamSize: 5, groundSize: "Standard table", netHeight: "Standard" },
            "17": { teamSize: 5, groundSize: "Standard table", netHeight: "Standard" },
            "19": { teamSize: 5, groundSize: "Standard table", netHeight: "Standard" }
        }
    },

    // Continue with other sports...
    "Baseball": {
        type: "team",
        ages: {
            "14": { teamSize: 16, groundSize: "Standard field", netHeight: "N/A" },
            "17": { teamSize: 16, groundSize: "Standard field", netHeight: "N/A" },
            "19": { teamSize: 16, groundSize: "Standard field", netHeight: "N/A" }
        }
    },

    "Softball": {
        type: "team",
        ages: {
            "14": { teamSize: 16, groundSize: "Standard field", netHeight: "N/A" },
            "17": { teamSize: 16, groundSize: "Standard field", netHeight: "N/A" },
            "19": { teamSize: 16, groundSize: "Standard field", netHeight: "N/A" }
        }
    },

    "Throwball": {
        type: "team",
        ages: {
            "14": { teamSize: 12, groundSize: "Standard court", netHeight: "Standard" },
            "17": { teamSize: 12, groundSize: "Standard court", netHeight: "Standard" },
            "19": { teamSize: 12, groundSize: "Standard court", netHeight: "Standard" }
        }
    },

    "Netball": {
        type: "team",
        ages: {
            "14": { teamSize: 12, groundSize: "Standard court", netHeight: "Standard" },
            "17": { teamSize: 12, groundSize: "Standard court", netHeight: "Standard" },
            "19": { teamSize: 12, groundSize: "Standard court", netHeight: "Standard" }
        }
    },

    "Ball badminton": {
        type: "team",
        ages: {
            "14": { teamSize: 8, groundSize: "12x24 Sq.m", netHeight: "1.82m" },
            "17": { teamSize: 8, groundSize: "Standard court", netHeight: "1.82m" },
            "19": { teamSize: 8, groundSize: "Standard court", netHeight: "1.82m" }
        }
    },

    "Roller skating": {
        type: "individual",
        ages: {
            "14": { participants: 6, competitionType: "Various skating events" },
            "17": { participants: 6, competitionType: "Various skating events" },
            "19": { participants: 6, competitionType: "Various skating events" }
        }
    },

    "Carrom": {
        type: "individual",
        ages: {
            "14": { participants: 6, competitionType: "Singles/Doubles" },
            "17": { participants: 6, competitionType: "Singles/Doubles" },
            "19": { participants: 6, competitionType: "Singles/Doubles" }
        }
    },

    "Lawn tennis": {
        type: "individual",
        ages: {
            "14": { participants: 5, competitionType: "Singles/Doubles" },
            "17": { participants: 5, competitionType: "Singles/Doubles" },
            "19": { participants: 5, competitionType: "Singles/Doubles" }
        }
    },

    "Squash": {
        type: "individual",
        ages: {
            "14": { participants: 5, competitionType: "Singles" },
            "17": { participants: 5, competitionType: "Singles" },
            "19": { participants: 5, competitionType: "Singles" }
        }
    },

    "Fencing": {
        type: "individual",
        ages: {
            "14": { participants: 12, competitionType: "Foil, Epee, Sabre" },
            "17": { participants: 12, competitionType: "Foil, Epee, Sabre" },
            "19": { participants: 12, competitionType: "Foil, Epee, Sabre" }
        }
    },

    "Mallakhamb": {
        type: "individual",
        ages: {
            "14": { participants: 4, competitionType: "Traditional Indian gymnastics" },
            "17": { participants: 4, competitionType: "Traditional Indian gymnastics" },
            "19": { participants: 4, competitionType: "Traditional Indian gymnastics" }
        }
    },

    "Rifle shooting": {
        type: "individual",
        ages: {
            "14": { participants: 9, competitionType: "Air Rifle, Air Pistol - 10m distance" },
            "17": { participants: 9, competitionType: "Air Rifle, Air Pistol - 10m distance" },
            "19": { participants: 9, competitionType: "Air Rifle, Air Pistol - 10m distance" }
        }
    },

    "Kick boxing": {
        type: "weight",
        ages: {
            "14": { weights: "Below 28kg to Above 63kg (Multiple categories)" },
            "17": { weights: "Below 34kg to Above 75kg (Multiple categories)" },
            "19": { weights: "Below 34kg to Above 75kg (Multiple categories)" }
        }
    },

    "Wushu": {
        type: "weight",
        ages: {
            "17": { weights: "-45kg to -80kg (Multiple categories)" },
            "19": { weights: "-48kg to -90kg (Multiple categories)" }
        }
    },

    "Modern Pentathlon": {
        type: "special",
        ages: {
            "17": { details: "4 players - Run 1200m + Swim 100m + Run 1200m" },
            "19": { details: "4 players - Run 1600m + Swim 200m + Run 1600m" }
        }
    },

    "Tug of war": {
        type: "team",
        ages: {
            "14": { teamSize: "Variable", groundSize: "Standard area", weightClass: "380kg Boys, 340kg Girls" },
            "17": { teamSize: "Variable", groundSize: "Standard area", weightClass: "480kg Boys, 400kg Girls" },
            "19": { teamSize: "Variable", groundSize: "Standard area", weightClass: "560kg Boys, 440kg Girls" }
        }
    },

    "Beach volleyball": {
        type: "team",
        ages: {
            "17": { teamSize: 7, groundSize: "Beach court", netHeight: "Standard" },
            "19": { teamSize: "9 Boys, 8 Girls", groundSize: "Beach court", netHeight: "Standard" }
        }
    },

    "Powerlifting": {
        type: "weight",
        ages: {
            "14": { weights: "53kg, -57kg, -66kg, -74kg, -83kg, -93kg, +93kg" },
            "17": { weights: "53kg to +120kg (Multiple categories)" },
            "19": { weights: "43kg to +120kg (Multiple categories)" }
        }
    },
    
    
 // Add these to your existing sportData object

 // TENNIS
 "Tennis": {
     type: "individual",
     ages: {
         "14": { participants: 5, competitionType: "Singles/Doubles" },
         "17": { participants: 5, competitionType: "Singles/Doubles" },
         "19": { participants: 5, competitionType: "Singles/Doubles" }
     }
 },

 // SQUASH
 "Squash": {
     type: "individual",
     ages: {
         "14": { participants: 5, competitionType: "Singles" },
         "17": { participants: 5, competitionType: "Singles" },
         "19": { participants: 5, competitionType: "Singles" }
     }
 },

 // FENCING
 "Fencing": {
     type: "individual",
     ages: {
         "14": { participants: 12, competitionType: "Foil, Epee, Sabre" },
         "17": { participants: 12, competitionType: "Foil, Epee, Sabre" },
         "19": { participants: 12, competitionType: "Foil, Epee, Sabre" }
     }
 },

 // MALLAKHAMB
 "Mallakhamb": {
     type: "individual",
     ages: {
         "14": { participants: 4, competitionType: "Traditional Indian gymnastics" },
         "17": { participants: 4, competitionType: "Traditional Indian gymnastics" },
         "19": { participants: 4, competitionType: "Traditional Indian gymnastics" }
     }
 },

 // ROLLER SKATING
 "Roller skating": {
     type: "individual",
     ages: {
         "14": { participants: 6, competitionType: "Various skating events" },
         "17": { participants: 6, competitionType: "Various skating events" },
         "19": { participants: 6, competitionType: "Various skating events" }
     }
 },

 // CARROM
 "Carrom": {
     type: "individual",
     ages: {
         "14": { participants: 6, competitionType: "Singles/Doubles" },
         "17": { participants: 6, competitionType: "Singles/Doubles" },
         "19": { participants: 6, competitionType: "Singles/Doubles" }
     }
 },

 // RIFLE SHOOTING
 "Rifle shooting": {
     type: "individual",
     ages: {
         "14": { participants: 9, competitionType: "Air Rifle, Air Pistol - 10m distance" },
         "17": { participants: 9, competitionType: "Air Rifle, Air Pistol - 10m distance" },
         "19": { participants: 9, competitionType: "Air Rifle, Air Pistol - 10m distance" }
     }
 },

 // KICK BOXING
 "Kick boxing": {
     type: "weight",
     ages: {
         "14": { weights: "Below 28kg to Above 63kg (Multiple categories)" },
         "17": { weights: "Below 34kg to Above 75kg (Multiple categories)" },
         "19": { weights: "Below 34kg to Above 75kg (Multiple categories)" }
     }
 },

 // WUSHU
 "Wushu": {
     type: "weight",
     ages: {
         "17": { weights: "-45kg to -80kg (Multiple categories)" },
         "19": { weights: "-48kg to -90kg (Multiple categories)" }
     }
 },

 // MODERN PENTATHLON
 "Modern Pentathlon": {
     type: "special",
     ages: {
         "17": { details: "4 players - Run 1200m + Swim 100m + Run 1200m" },
         "19": { details: "4 players - Run 1600m + Swim 200m + Run 1600m" }
     }
 },

 // TUG OF WAR
 "Tug of war": {
     type: "team",
     ages: {
         "14": { teamSize: "Variable", groundSize: "Standard area", weightClass: "380kg Boys, 340kg Girls" },
         "17": { teamSize: "Variable", groundSize: "Standard area", weightClass: "480kg Boys, 400kg Girls" },
         "19": { teamSize: "Variable", groundSize: "Standard area", weightClass: "560kg Boys, 440kg Girls" }
     }
 },

 // BEACH VOLLEYBALL
 "Beach volleyball": {
     type: "team",
     ages: {
         "17": { teamSize: 7, groundSize: "Beach court", netHeight: "Standard" },
         "19": { teamSize: "9 Boys, 8 Girls", groundSize: "Beach court", netHeight: "Standard" }
     }
 },

 // POWERLIFTING
 "Powerlifting": {
     type: "weight",
     ages: {
         "14": { weights: "53kg, -57kg, -66kg, -74kg, -83kg, -93kg, +93kg" },
         "17": { weights: "53kg to +120kg (Multiple categories)" },
         "19": { weights: "43kg to +120kg (Multiple categories)" }
     }
 }
    
};

function handleAgeGroupChange() {
	 const selectedAgeGroup = document.querySelector('input[name="ageGroup"]:checked')?.value;

    const dateFields = {
        "14": document.getElementById("underForteenCutOffDate"),
        "17": document.getElementById("underSeventeenCutOffDate"),
        "19": document.getElementById("underNineteenCutOffDate")
    };

    Object.values(dateFields).forEach(field => {
        field.value = "";
        field.disabled = true;
    });

    if (selectedAgeGroup && dateFields[selectedAgeGroup]) {
        dateFields[selectedAgeGroup].disabled = false;
    }
	
    loadSportDetails();
}

function loadSportDetails() {
    const sportName = document.getElementById('sportName').value;
    const selectedAgeGroup = document.querySelector('input[name="ageGroup"]:checked')?.value;
    
    const detailsSection = document.getElementById('sportDetailsSection');
    
    // Hide all detail sections first
    document.querySelectorAll('.sport-detail-category').forEach(section => {
        section.style.display = 'none';
    });
    
    if (!sportName || !selectedAgeGroup) {
        detailsSection.style.display = 'none';
        return;
    }
    
    const sport = sportData[sportName];
    if (!sport || !sport.ages[selectedAgeGroup]) {
        detailsSection.style.display = 'none';
        return;
    }
    
    detailsSection.style.display = 'block';
    const ageData = sport.ages[selectedAgeGroup];
    
    switch(sport.type) {
        case 'team':
            document.getElementById('teamSportsDetails').style.display = 'block';
            document.getElementById('teamSize').value = ageData.teamSize || '';
            document.getElementById('groundSize').value = ageData.groundSize || '';
            document.getElementById('netHeight').value = ageData.netHeight || '';
            break;
            
        case 'individual':
            document.getElementById('individualSportsDetails').style.display = 'block';
            document.getElementById('participantsCount').value = ageData.participants || '';
            document.getElementById('competitionType').value = ageData.competitionType || '';
            break;
            
        case 'weight':
            document.getElementById('weightCategoryDetails').style.display = 'block';
            document.getElementById('weightCategories').value = ageData.weights || '';
            break;
            
        case 'athletics':
            document.getElementById('athleticsDetails').style.display = 'block';
            
            // Populate Boys Events
            const athleticsBoysSelect = document.getElementById('athleticsBoysEvents');
            athleticsBoysSelect.innerHTML = '';
            if (ageData.boysEvents && Array.isArray(ageData.boysEvents)) {
                ageData.boysEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    athleticsBoysSelect.appendChild(option);
                });
            }
            
            // Populate Girls Events
            const athleticsGirlsSelect = document.getElementById('athleticsGirlsEvents');
            athleticsGirlsSelect.innerHTML = '';
            if (ageData.girlsEvents && Array.isArray(ageData.girlsEvents)) {
                ageData.girlsEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    athleticsGirlsSelect.appendChild(option);
                });
            }
            break;
            
        case 'swimming':
            document.getElementById('swimmingDetails').style.display = 'block';
            
            // Populate Boys Events
            const swimmingBoysSelect = document.getElementById('swimmingBoysEvents');
            swimmingBoysSelect.innerHTML = '';
            if (ageData.boysEvents && Array.isArray(ageData.boysEvents)) {
                ageData.boysEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    swimmingBoysSelect.appendChild(option);
                });
            }
            
            // Populate Girls Events
            const swimmingGirlsSelect = document.getElementById('swimmingGirlsEvents');
            swimmingGirlsSelect.innerHTML = '';
            if (ageData.girlsEvents && Array.isArray(ageData.girlsEvents)) {
                ageData.girlsEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    swimmingGirlsSelect.appendChild(option);
                });
            }
            break;
            
        case 'cycling':
            document.getElementById('cyclingDetails').style.display = 'block';
            
            // Populate Boys Events
            const cyclingBoysSelect = document.getElementById('cyclingBoysEvents');
            cyclingBoysSelect.innerHTML = '';
            if (ageData.boysEvents && Array.isArray(ageData.boysEvents)) {
                ageData.boysEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    cyclingBoysSelect.appendChild(option);
                });
            }
            
            // Populate Girls Events
            const cyclingGirlsSelect = document.getElementById('cyclingGirlsEvents');
            cyclingGirlsSelect.innerHTML = '';
            if (ageData.girlsEvents && Array.isArray(ageData.girlsEvents)) {
                ageData.girlsEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    cyclingGirlsSelect.appendChild(option);
                });
            }
            break;
            
        case 'yoga':
            document.getElementById('yogaDetails').style.display = 'block';
            
            // Populate Boys Categories
            const yogaBoysSelect = document.getElementById('yogaBoysCategories');
            yogaBoysSelect.innerHTML = '';
            if (ageData.boysCategories && Array.isArray(ageData.boysCategories)) {
                ageData.boysCategories.forEach(category => {
                    const option = document.createElement('option');
                    option.value = category;
                    option.textContent = category;
                    yogaBoysSelect.appendChild(option);
                });
            }
            
            // Populate Girls Categories
            const yogaGirlsSelect = document.getElementById('yogaGirlsCategories');
            yogaGirlsSelect.innerHTML = '';
            if (ageData.girlsCategories && Array.isArray(ageData.girlsCategories)) {
                ageData.girlsCategories.forEach(category => {
                    const option = document.createElement('option');
                    option.value = category;
                    option.textContent = category;
                    yogaGirlsSelect.appendChild(option);
                });
            }
            break;
            
        case 'shooting':
            document.getElementById('shootingDetails').style.display = 'block';
            
            // Populate Boys Events
            const shootingBoysSelect = document.getElementById('shootingBoysEvents');
            shootingBoysSelect.innerHTML = '';
            if (ageData.boysEvents && Array.isArray(ageData.boysEvents)) {
                ageData.boysEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    shootingBoysSelect.appendChild(option);
                });
            }
            
            // Populate Girls Events
            const shootingGirlsSelect = document.getElementById('shootingGirlsEvents');
            shootingGirlsSelect.innerHTML = '';
            if (ageData.girlsEvents && Array.isArray(ageData.girlsEvents)) {
                ageData.girlsEvents.forEach(event => {
                    const option = document.createElement('option');
                    option.value = event;
                    option.textContent = event;
                    shootingGirlsSelect.appendChild(option);
                });
            }
            break;
            
        case 'special':
            document.getElementById('specialSportsDetails').style.display = 'block';
            document.getElementById('specialDetails').value = ageData.details || '';
            break;
    }
    
    document.getElementById('sportId').value = document.getElementById('sportName').options[document.getElementById('sportName').selectedIndex].getAttribute('data-id');
}

// Reset function
document.getElementById('reset-btn').addEventListener('click', function() {
    document.getElementById('create_comp_master').reset();
    document.getElementById('sportDetailsSection').style.display = 'none';
    document.querySelectorAll('.sport-detail-category').forEach(section => {
        section.style.display = 'none';
    });
});

// Your existing validation and save functions remain the same
var competitionCreationErrorMessage = '<liferay-ui:message key="the-competition-master-creation-is-unsucessfull" />';
var saveCompetitionMasterURL = '${saveCompetitionMasterURL}';

$(document).ready(function() {
    $('#create_comp_master').validate({
        onkeyup: function (element) {
            $(element).valid();
        },
        onchange: function (element) {
            $(element).valid();
        },
        rules:{
            sportName: { required:true },
            category: { required:true },
            sportType: { required:true },
            fees: {
                required:true,
                pattern: /^\d+(\.\d{1,2})?$/,
                minlength:2,
                maxlength:7,
            },
            currentYear: { required:true },
            ageGroup: { required:true }
        },
        messages:{
            sportName: { required:"<liferay-ui:message key="please-select-sports-name"/>" },
            category: { required:"<liferay-ui:message key="please-select-category"/>" },
            sportType: { required:"<liferay-ui:message key="please-select-sport-type"/>" },
            fees: {
                required:"<liferay-ui:message key="please-enter-fees"/>",
                pattern: "<liferay-ui:message key="please-enter-valid-fees"/>",
                minlength:"<liferay-ui:message key="minimum-length-is-2"/>",
                maxlength:"<liferay-ui:message key="maximum-length-is-7"/>"
            },
            currentYear: { required:"<liferay-ui:message key="please-check-current-year"/>" },
            ageGroup: { required:"<liferay-ui:message key="please-select-age-group"/>" }
        },
        errorPlacement: function (error, element) {
            if (element.attr("type") == "radio") {
                error.insertAfter(element.parent().parent());
            } else if (element.attr("type") == "checkbox" && element.hasClass("form-check-input")) {
                error.insertAfter(element.closest('.form-check'));
            } else {
                error.insertAfter(element);
            }
        },
    });
});

</script>

<style>
.sport-detail-category {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 5px;
    margin-bottom: 15px;
    border-left: 4px solid #007bff;
}

/* Style for multiple select dropdowns */
select[multiple] {
    min-height: 150px;
}

/* Style for age group radio buttons */
.age-group label {
    font-weight: bold;
}
</style>