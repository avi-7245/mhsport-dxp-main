<%@page import="com.mhdsys.admin.dashboard.constants.AdminDashboardPortletKeys"%>
<%@ include file="/init.jsp"%>

<style>
.number-badge {
    position: absolute;
    top: 5px;
    right: 5px;
    background-color: #861f419c;
    color: #fff;
    border-radius: 5px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 20px;
    padding: 5px;
    height: 20px;
    font-size: 10px;
}

.number-badge:has(:not(:empty)) {
    padding: 0 8px;
    min-width: 35px;
}

.blue .number-badge{
background-color: #26268e9e;
}

.light-color .number-badge{
background-color: #00999099;
}

.dashboardPage a .card p {
font-size:12px;
}

@media(max-width:729px){
.maharashtraSports-main-content:has(.deshbordSidebar.ifCond) .maharashtraSports-body-main {
    width: calc(100% - 0px) !important;
	}
}
@media (min-width: 992px) {
    .maharashtraSports-dashboard-wrapper.closed-sidebar .maharashtraSports-main-content .maharashtraSports-body-main {
        width: calc(100% - 80px) !important;
    }
}
</style>


<div class="container-fluid dashboardPage">
	<div class="row">

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/competition-dashboard"
				class="text-decoration-none">
				<div class="card">

					<div class="number-badge">${competitionCount}</div>

					<div class="d-flex justify-content-start align-items-center mt-2">
						<img
							src="https://cdn-icons-png.flaticon.com/128/11126/11126024.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="sports-competition-management" />
						</p>
					</div>
				</div>
			</a>
		</div>

		<c:if test="${isSportsPerson || isDDD || isDeputyDirector || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/application-details-list"
					class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${certificateCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/16949/16949711.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="5%-reservation-certification" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>
		

		<%-- <c:if test="${isSportsPerson || isHOAdmin}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/application-certificate-verification"
					class="text-decoration-none" target="_blank">
					<div class="card">

						<div class="number-badge">${certificateCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/16949/16949711.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="5%-reservation-certification" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if> --%>

		<c:if
			test="${isSportsDeskOfficer || isDeputyDirector || isCoach || isDeskOfficer || isHOAdmin || isAssociation || isSportsPerson || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/awards" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${awardsCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/1090/1090339.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="sport-awards" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<c:if
			test="${isCoach || isHOAdmin || isSportsPerson || isDeskOfficer || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/athelet-performance"
					class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${athleteCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/1248/1248343.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="athelet-monitoring-system" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/sports-facility" class="text-decoration-none">
				<div class="card">

					<div class="number-badge">${facilityBookingCount}</div>

					<div class="d-flex justify-content-start align-items-center mt-2">
						<img src="https://cdn-icons-png.flaticon.com/128/3511/3511371.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="sports-facility" />
						</p>
					</div>
				</div>
			</a>
		</div>

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/entrypass" class="text-decoration-none">
				<div class="card">

					<div class="number-badge">${entryPassCount}</div>

					<div class="d-flex justify-content-start align-items-center mt-2">
						<img src="https://cdn-icons-png.flaticon.com/128/6993/6993222.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="entry-pass" />
						</p>
					</div>
				</div>
			</a>
		</div>

		<c:if test="${isDSO || isTSO || isDDD || isHOAdmin || isCoach || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/sports-coaching-wing"
					class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${coachingWingCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/14250/14250109.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="sports-coaching-wing" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/grants-and-scheme" class="text-decoration-none">
				<div class="card">

					<div class="number-badge">${districtCount}</div>

					<div class="d-flex justify-content-start align-items-center mt-2">
						<img
							src="https://cdn-icons-png.flaticon.com/128/10236/10236154.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="grants-and-scheme" />
						</p>
					</div>
				</div>
			</a>
		</div>

		<c:if test="${isDSO || isTSO || isDDD || isHOAdmin || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/construction-tracker"
					class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${constructionTrackerCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/512/11287/11287228.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="construction-tracker" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<c:if test="${!isPtTeacher && !isCoach && !isSportsPerson || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/establishment-dashboard"
					class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${establishmentCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/18832/18832058.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="establishment" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<c:if test="${!isSportsPerson || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/scout-guide-ncc" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${scoutAndGuideCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/11476/11476545.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="scout-guide-and-ncc" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<c:if
			test="${isHOAdmin || isDeskOfficer || isDeputyDirector || isDDD || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/budget" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${budgetCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/11476/11476545.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="budget" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<%-- <c:if test="${!isSportsPerson}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/administrative-dashboard"
					class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${grievanceCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/11269/11269058.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="administrative" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if> --%>

		<%-- <c:if test="${isCommissioner }">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${registeredUsers}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/512/11287/11287228.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="registered-users" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if> --%>

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/grievance-dashboard"
				class="text-decoration-none">
				<div class="card">

					<div class="number-badge">${grievanceCount}</div>

					<div class="d-flex justify-content-start align-items-center mt-2">
						<img src="https://cdn-icons-png.flaticon.com/128/792/792114.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="grievance-and-complaint-redressal" />
						</p>
					</div>
				</div>
			</a>
		</div>

		<c:if test="${isSchoolCollege || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/school-college-officer-application"
					class="text-decoration-none">
					<div class="card">
						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/3135/3135711.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="school-college-officer" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<c:if test="${isPtTeacher || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/objection" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${objectionCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/11126/11126024.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="suggestion-objection" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>

		<c:if test="${isCoach || isSportsPerson || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/athelet-details" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${medicalRecordsCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img src="<%=request.getContextPath()%>/images/athlet.png" alt="">

							<p class="mb-0">
								<liferay-ui:message key="athlete-details" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>


        <c:if test="${!isPtTeacher || isCommissioner}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/youth-awards" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${youthCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/8165/8165803.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="youth-service" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>
		
		
		
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/sport-person-details" class="text-decoration-none">
					<div class="card">

						<div class="number-badge">${athleteCount}</div>

						<div class="d-flex justify-content-start align-items-center mt-2">
							<img
								src="https://cdn-icons-png.flaticon.com/128/1090/1090339.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="athlete-list" />
							</p>
						</div>
					</div>
				</a>
			</div>
		
	</div>
</div>








<%-- <div class="container-fluid dashboardPage">
	<div class="row">
	
	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/entrypass"
					class="text-decoration-none">
					<div class="card">
					
						<div class="number-badge">${entryPassCount}</div>
						
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/128/6993/6993222.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="entry-pass" />
							</p>
						</div>
					</div>
				</a>
			</div>
		
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/sports-facility"
					class="text-decoration-none">
					<div class="card">
					
						<div class="number-badge">${facilityBookingCount}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/128/3511/3511371.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="sports-facility" />
							</p>
						</div>
					</div>
				</a>
			</div>
		<c:if test="${isDSO || isTSO || isDDD || isHOAdmin }">	
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/construction-tracker"
					class="text-decoration-none">
					<div class="card">
					
						<div class="number-badge">${constructionTrackerCount}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/512/11287/11287228.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="construction-tracker" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>
		<c:if test="${isDSO || isTSO || isDDD || isHOAdmin || isCoach}">	
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
					<a href="/group/guest/sports-coaching-wing"
						class="text-decoration-none">
						<div class="card">
						
						<div class="number-badge">${coachingWingCount}</div>
						
							<div class="d-flex justify-content-start align-items-center">
								<img
									src="https://cdn-icons-png.flaticon.com/128/14250/14250109.png"
									alt="">
								<p class="mb-0">
									<liferay-ui:message key="sports-coaching-wing" />
								</p>
							</div>
						</div>
					</a>
				</div>
		</c:if>
		
		<c:if test="${!isPtTeacher && !isCoach && !isSportsPerson}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/establishment-dashboard"
					class="text-decoration-none">
					<div class="card">
					
					<div class="number-badge">${establishmentCount}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/128/18832/18832058.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="establishment" />
							</p>
						</div>
					</div>
				</a>
			</div> 
	    </c:if>	
			
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/competition-dashboard"
					class="text-decoration-none">
					<div class="card">
					
					<div class="number-badge">${competitionCount}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/128/11126/11126024.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="sports-competition-management" />
							</p>
						</div>
					</div>
				</a>
			</div>
	
		<c:if test="${isSchoolCollege}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/school-college-officer-application"
					class="text-decoration-none">
					<div class="card">
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/128/3135/3135711.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="school-college-officer" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>
		
		<c:if test="${isDDD}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/application-certificate-verification-list" class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${certificateCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/16949/16949711.png"
							alt="">
						<p class="mb-0"><liferay-ui:message key="5%-reservation-certification" /></p>
					</div>
				</div>
			</a>
		</div>
		</c:if>
		
		<c:if test="${isSportsPerson}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/application-certificate-verification" class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${certificateCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/16949/16949711.png"
							alt="">
						<p class="mb-0"><liferay-ui:message key="5%-reservation-certification" /></p>
					</div>
				</div>
			</a>
		</div>
		</c:if>
		
	<c:if test="${!isPtTeacher}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/youth-awards" class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${youthCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/8165/8165803.png"
							alt="">
						<p class="mb-0"><liferay-ui:message key="youth-service" /></p>
					</div>
				</div>
			</a>
		</div>
	</c:if>

	<c:if test="${isSportsDeskOfficer || isDeputyDirector || isCoach || isDeskOfficer || isHOAdmin || isAssociation || isSportsPerson}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/awards" class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${awardsCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/1090/1090339.png"
							alt="">
						<p class="mb-0"><liferay-ui:message key="sports-awards" /></p>
					</div>
				</div>
			</a>
		</div>
	</c:if>
	
	<c:if test="${isPtTeacher}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/objection"
				class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${objectionCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img
							src="https://cdn-icons-png.flaticon.com/128/11126/11126024.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="suggestion-objection"/>
						</p>
					</div>
				</div>
			</a>
		</div>
	</c:if>

<c:if test="${isCoach || isHOAdmin || isSportsPerson || isDeskOfficer}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/athelet-performance" class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${athleteCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/1248/1248343.png"
							alt="">
						<p class="mb-0"><liferay-ui:message key="athelet-performance-monitoring" /></p>
					</div>
				</div>
			</a>
		</div>
</c:if>

		<!-- <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="" class="text-decoration-none">
				<div class="card">
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/3511/3511371.png"
							alt="">
						<p class="mb-0">Sports Facilities</p>
					</div>
				</div>
			</a>
		</div>

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="" class="text-decoration-none">
				<div class="card">
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/3254/3254935.png"
							alt="">
						<p class="mb-0">Kridapeeth Application</p>
					</div>
				</div>
			</a>
		</div> 

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="" class="text-decoration-none">
				<div class="card">
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/6993/6993222.png"
							alt="">
						<p class="mb-0">Entry Pass</p>
					</div>
				</div>
			</a>
		</div>-->

		<!-- <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="" class="text-decoration-none">
				<div class="card">
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/4609/4609771.png"
							alt="">
						<p class="mb-0">Implementation and Monitoring of Various
							Schemes and Grants</p>
					</div>
				</div>
			</a>
		</div> -->

		<!-- <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="" class="text-decoration-none">
				<div class="card">
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/3254/3254935.png"
							alt="">
						<p class="mb-0">Website & Mobile application with integrated
							Decision Support system portal</p>
					</div>
				</div>
			</a>
		</div> -->

		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/grievance-dashboard" class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${grievanceCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="https://cdn-icons-png.flaticon.com/128/792/792114.png"
							alt="">
						<p class="mb-0"><liferay-ui:message key="grievance-and-complaint-redressal" /></p>
					</div>
				</div>
			</a>
		</div>
		
		<c:if test="${!isSportsPerson}">
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/administrative-dashboard" class="text-decoration-none">
					<div class="card">
					
					<div class="number-badge">${grievanceCount}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img src="https://cdn-icons-png.flaticon.com/128/11269/11269058.png"
								alt="">
							<p class="mb-0"><liferay-ui:message key="administrative" /></p>
						</div>
					</div>
				</a>
			</div>
		</c:if>
		<c:if test="${isAssociation || isHOAdmin || isDeskOfficer }">
			<!-- <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/objection" class="text-decoration-none">
					<div class="card">
						<div class="d-flex justify-content-start align-items-center">
							<img src="https://cdn-icons-png.flaticon.com/128/17873/17873502.png"
								alt="">
							<p class="mb-0"><liferay-ui:message key="objection" /></p>
						</div>
					</div>
				</a>
			</div>
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/objection-list" class="text-decoration-none">
					<div class="card">
						<div class="d-flex justify-content-start align-items-center">
							<img src="https://cdn-icons-png.flaticon.com/128/14785/14785145.png"
								alt="">
							<p class="mb-0"><liferay-ui:message key="objection-list" /></p>
						</div>
					</div>
				</a>
			</div> -->
			
		</c:if>
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href="/group/guest/grants-and-scheme"
					class="text-decoration-none">
					<div class="card">
					
					<div class="number-badge">${districtCount}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/128/10236/10236154.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="grants-and-scheme" />
							</p>
						</div>
					</div>
				</a>
			</div>
			
	<c:if test="${isHOAdmin || isDeskOfficer || isDeputyDirector || isDDD}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/budget"
				class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${budgetCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img
							src="https://cdn-icons-png.flaticon.com/128/11476/11476545.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="budget" />
						</p>
					</div>
				</div>
			</a>
		</div>
	</c:if>
		
		<c:if test="${!isSportsPerson}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/scout-guide-ncc"
				class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${scoutAndGuideCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img
							src="https://cdn-icons-png.flaticon.com/128/11476/11476545.png"
							alt="">
						<p class="mb-0">
							<liferay-ui:message key="scout-guide-and-ncc" />
						</p>
					</div>
				</div>
			</a>
		</div>
		</c:if>
		
	<c:if test="${isCoach || isSportsPerson}">
		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
			<a href="/group/guest/athelet-details"
				class="text-decoration-none">
				<div class="card">
				
				<div class="number-badge">${medicalRecordsCount}</div>
				
					<div class="d-flex justify-content-start align-items-center">
						<img src="<%=request.getContextPath()%>/images/athlet.png" alt="">

						<p class="mb-0">
							<liferay-ui:message key="athlete-details" />
						</p>
					</div>
				</div>
			</a>
		</div>
	</c:if>
	
		<c:if test="${isHOAdmin }">	
			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<a href=""
					class="text-decoration-none">
					<div class="card">
					
						<div class="number-badge">${registeredUsers}</div>
					
						<div class="d-flex justify-content-start align-items-center">
							<img
								src="https://cdn-icons-png.flaticon.com/512/11287/11287228.png"
								alt="">
							<p class="mb-0">
								<liferay-ui:message key="registered-users" />
							</p>
						</div>
					</div>
				</a>
			</div>
		</c:if>
	
	</div>
</div> --%>


