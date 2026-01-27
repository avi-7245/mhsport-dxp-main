package com.mhdsys.admin.dashboard.portlet;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.admin.dashboard.constants.AdminDashboardPortletKeys;
import com.mhdsys.common.pojo.SchoolCollegeOfficerRegistrationCommonDTO;
import com.mhdsys.common.util.RoleUtil;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.model.SchoolCollegeOfficerRegistration;
import com.mhdsys.schema.service.SchoolCollegeOfficerRegistrationLocalServiceUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

@Component(property = { "com.liferay.portlet.display-category=MHDSYS.DASHBOARD",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=AthleteDetailList", "javax.portlet.init-param.template-path=/",

		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/bootstrap.bundle.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.validate.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/additional-methods.js",

		"javax.portlet.init-param.view-template=/athlete-list.jsp",
		"javax.portlet.name=" + AdminDashboardPortletKeys.ATHLETEDETAILSLISTPORTLET,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)
public class AthleteDetailsListPortlet extends MVCPortlet {

	private Log LOGGER = LogFactoryUtil.getLog(AthleteDetailsListPortlet.class);

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		User user;
		try {
			user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());

			boolean isCommissioner = RoleUtil.hasRole(user, RoleConstant.COMMISSIONER, themeDisplay.getCompanyId());
			boolean isJointDirector = RoleUtil.hasRole(user, RoleConstant.JOINT_DIRECTOR, themeDisplay.getCompanyId());
			renderRequest.setAttribute("isCommissioner", isCommissioner);
			renderRequest.setAttribute("isJointDirector", isJointDirector);

			List<SchoolCollegeOfficerRegistrationCommonDTO> dtos = new ArrayList<>();

			List<SchoolCollegeOfficerRegistration> schoolCollegeOfficerRegistrations = SchoolCollegeOfficerRegistrationLocalServiceUtil
					.getSchoolCollegeOfficerRegistrations(-1, -1);

			Calendar calendar = Calendar.getInstance();
			calendar.set(2025, Calendar.DECEMBER, 1, 0, 0, 0);
			calendar.set(Calendar.MILLISECOND, 0);

			Date filterDate = calendar.getTime();

			for (SchoolCollegeOfficerRegistration registration : schoolCollegeOfficerRegistrations) {

				if (registration.getCreateDate() == null || !registration.getCreateDate().after(filterDate)) {
					continue;
				}

				SchoolCollegeOfficerRegistrationCommonDTO dto = new SchoolCollegeOfficerRegistrationCommonDTO();

				dto.setFirstName(registration.getFirstName());
				dto.setLastName(registration.getLastName());
				dto.setMobileNumber(registration.getMobileNumber());

				if (registration.getCurrentDesignation() == 1) {
					dto.setDesignation("Athlete");
				} else if (registration.getCurrentDesignation() == 2) {
					dto.setDesignation("Para Athlete");
				} else if (registration.getCurrentDesignation() == 3) {
					dto.setDesignation("Adventure Person");
				} else {
					dto.setDesignation("Coach");
				}

				dtos.add(dto);
			}

			renderRequest.setAttribute("athleteList", dtos);

		} catch (PortalException e) {
			LOGGER.error(e.getMessage(), e);
		}
		super.render(renderRequest, renderResponse);
	}

}
