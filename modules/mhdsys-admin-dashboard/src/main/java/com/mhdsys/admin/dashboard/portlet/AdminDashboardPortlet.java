package com.mhdsys.admin.dashboard.portlet;

import com.liferay.contacts.service.EntryLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.Role;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.RoleLocalServiceUtil;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.admin.dashboard.constants.AdminDashboardPortletKeys;
import com.mhdsys.common.util.RoleUtil;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.service.AwardApplicationLocalServiceUtil;
import com.mhdsys.schema.service.AwardYouthLocalServiceUtil;
import com.mhdsys.schema.service.BudgetLocalServiceUtil;
import com.mhdsys.schema.service.CertificateVerificationLocalServiceUtil;
import com.mhdsys.schema.service.CoachingWingMonthlyReportLocalServiceUtil;
import com.mhdsys.schema.service.CompetitionInitiationLocalServiceUtil;
import com.mhdsys.schema.service.ConstructionTrackerLocalServiceUtil;
import com.mhdsys.schema.service.DistrictGrantSchemeLocalServiceUtil;
import com.mhdsys.schema.service.EstablishmentDetailsLocalServiceUtil;
import com.mhdsys.schema.service.GrievanceLocalServiceUtil;
import com.mhdsys.schema.service.MedicalRecordLocalServiceUtil;
import com.mhdsys.schema.service.ObjectionLocalServiceUtil;
import com.mhdsys.schema.service.SchoolCollegeOfficerRegistrationLocalServiceUtil;
import com.mhdsys.schema.service.ScoutAndGuideRegistrationLocalServiceUtil;
import com.mhdsys.schema.service.sportsFacilityBookingLocalServiceUtil;

import java.io.IOException;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author Epiphany
 */
@Component(property = { "com.liferay.portlet.display-category=MHDSYS.DASHBOARD",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=AdminDashboard", "javax.portlet.init-param.template-path=/",

		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/bootstrap.bundle.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.validate.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/additional-methods.js",

		"javax.portlet.init-param.view-template=/dashboard/admin-dashboard-page.jsp",
		"javax.portlet.name=" + AdminDashboardPortletKeys.ADMINDASHBOARD,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)
public class AdminDashboardPortlet extends MVCPortlet {
	private Log LOGGER = LogFactoryUtil.getLog(AdminDashboardPortlet.class);

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		User user;
		try {
			user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());

			boolean isSchoolCollege = RoleUtil.hasRole(user, RoleConstant.SCHOOLCOLLEGE, themeDisplay.getCompanyId());
			boolean isCommissioner = RoleUtil.hasRole(user, RoleConstant.COMMISSIONER, themeDisplay.getCompanyId());
			boolean isDeputyDirector2 = RoleUtil.hasRole(user, RoleConstant.DEPUTY_DIRECTOR_2, themeDisplay.getCompanyId());
			
			renderRequest.setAttribute("isCommissioner", isCommissioner);
			renderRequest.setAttribute("isDeputyDirector2", isDeputyDirector2);
			
			renderRequest.setAttribute("isSchoolCollege", isSchoolCollege);
			renderRequest.setAttribute("isDeskOfficer", RoleConstant.isDeskOfficer(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isHOAdmin", RoleConstant.isHOAdmin(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isAssociation", RoleConstant.isAssociation(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isDDD", RoleConstant.isDDD(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isSportsPerson",
					RoleConstant.isSportsPerson(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isCoach", RoleConstant.isSportsCoach(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isDeputyDirector",
					RoleConstant.isDeputyDirector(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isSportsDeskOfficer",
					RoleConstant.isSportsDeskOfficer(user, themeDisplay.getCompanyId()));
			renderRequest.setAttribute("isPtTeacher", RoleConstant.isPtTeacher(user, themeDisplay.getCompanyId()));

			boolean isDSO = false;
			boolean isTSO = false;
			List<Role> userRoles = RoleLocalServiceUtil.getUserRoles(user.getUserId());
			for (Role role : userRoles) {
				if (role.getName().endsWith("-DSO")) {
					isDSO = true;
				}
				if (role.getName().endsWith("-TSO") || role.getName().startsWith("TSO-")) {
					isTSO = true;
				}
			}
			renderRequest.setAttribute("isDSO", isDSO);
			renderRequest.setAttribute("isTSO", isTSO);
			LOGGER.info("isDSO: " + isDSO + ", isTSO: " + isTSO);

			renderRequest.setAttribute("entryPassCount", EntryLocalServiceUtil.getEntries(-1, -1).size());
			renderRequest.setAttribute("facilityBookingCount",
					sportsFacilityBookingLocalServiceUtil.getsportsFacilityBookings(-1, -1).size());

			renderRequest.setAttribute("constructionTrackerCount",
					ConstructionTrackerLocalServiceUtil.getConstructionTrackers(-1, -1).size());

			renderRequest.setAttribute("coachingWingCount",
					CoachingWingMonthlyReportLocalServiceUtil.getCoachingWingMonthlyReports(-1, -1).size());

			renderRequest.setAttribute("establishmentCount",
					EstablishmentDetailsLocalServiceUtil.getEstablishmentDetailses(-1, -1).size());

			renderRequest.setAttribute("competitionCount",
					CompetitionInitiationLocalServiceUtil.getCompetitionInitiations(-1, -1).size());

			renderRequest.setAttribute("certificateCount",
					CertificateVerificationLocalServiceUtil.getCertificateVerifications(-1, -1).size());

			renderRequest.setAttribute("youthCount", AwardYouthLocalServiceUtil.getAwardYouths(-1, -1).size());

			renderRequest.setAttribute("awardsCount",
					AwardApplicationLocalServiceUtil.getAwardApplications(-1, -1).size());

			renderRequest.setAttribute("objectionCount", ObjectionLocalServiceUtil.getObjections(-1, -1).size());

			renderRequest.setAttribute("athleteCount", SchoolCollegeOfficerRegistrationLocalServiceUtil
					.getSchoolCollegeOfficerRegistrations(-1, -1).size());

			renderRequest.setAttribute("grievanceCount", GrievanceLocalServiceUtil.getGrievances(-1, -1).size());

			renderRequest.setAttribute("districtCount",
					DistrictGrantSchemeLocalServiceUtil.getDistrictGrantSchemes(-1, -1).size());

			renderRequest.setAttribute("budgetCount", BudgetLocalServiceUtil.getBudgets(-1, -1).size());

			renderRequest.setAttribute("scoutAndGuideCount",
					ScoutAndGuideRegistrationLocalServiceUtil.getScoutAndGuideRegistrations(-1, -1).size());

			renderRequest.setAttribute("medicalRecordsCount",
					MedicalRecordLocalServiceUtil.getMedicalRecords(-1, -1).size());

			renderRequest.setAttribute("registeredUsers", UserLocalServiceUtil.getUsers(-1, -1).size());
			renderRequest.setAttribute("athleteCount", SchoolCollegeOfficerRegistrationLocalServiceUtil
					.getSchoolCollegeOfficerRegistrations(-1, -1).size());

		} catch (PortalException e) {
			LOGGER.error(e.getMessage(), e);
		}
		super.render(renderRequest, renderResponse);
	}

}