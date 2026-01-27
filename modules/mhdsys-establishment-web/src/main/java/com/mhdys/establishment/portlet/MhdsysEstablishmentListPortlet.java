package com.mhdys.establishment.portlet;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.common.pojo.EstablishmentCommonDTO;
import com.mhdsys.schema.model.EstablishmentDetails;
import com.mhdsys.schema.model.PersonalDetails;
import com.mhdsys.schema.service.EstablishmentDetailsLocalServiceUtil;
import com.mhdsys.schema.service.PersonalDetailsLocalServiceUtil;
import com.mhdys.establishment.constants.EstablishmentWebPortletKeys;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

@Component(property = { "com.liferay.portlet.display-category=category.establishment",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=MhdsysEstablishmentDetailsListWeb", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/jsps/establishment-details-list.jsp",
		"javax.portlet.name=" + EstablishmentWebPortletKeys.MHDSYSESTABLISHMENTLISTWEB,
		"javax.portlet.resource-bundle=content.Language", "com.liferay.portlet.requires-namespaced-parameters=false",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/bootstrap.bundle.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.validate.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/additional-methods.js",

		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)

public class MhdsysEstablishmentListPortlet extends MVCPortlet {

	private static final Log LOGGER = LogFactoryUtil.getLog(MhdsysEstablishmentListPortlet.class);

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);

		try {
			List<EstablishmentDetails> establishmentDetails = EstablishmentDetailsLocalServiceUtil
					.getEstablishmentDetailses(-1, -1);

			List<EstablishmentCommonDTO> establishmentCommonDTOs = new ArrayList<>();

			for (EstablishmentDetails details : establishmentDetails) {
				EstablishmentCommonDTO commonDTO = new EstablishmentCommonDTO();
//				User user = UserLocalServiceUtil.getUser(details.getUserId());
//
//				List<Role> roles = RoleLocalServiceUtil.getUserRoles(user.getUserId());
//				StringBuilder roleNames = new StringBuilder();
//
//				for (Role role : roles) {
//					if (!"User".equalsIgnoreCase(role.getName())) {
//						if (roleNames.length() > 0) {
//							roleNames.append(", ");
//						}
//						roleNames.append(role.getName());
//					}
//				}

				PersonalDetails byEstablishmentId = PersonalDetailsLocalServiceUtil
						.findByEstablishmentId(details.getEstablishmentDetailId());

				commonDTO.setEmployeeName(byEstablishmentId.getEmployeeName());
				commonDTO.setSevarathId(byEstablishmentId.getSevarthID());
				commonDTO.setEducation(byEstablishmentId.getEducation());
				commonDTO.setHometown(byEstablishmentId.getHometown());
				// commonDTO.setUserId(user.getUserId());

				establishmentCommonDTOs.add(commonDTO);
			}

			renderRequest.setAttribute("detailses", establishmentCommonDTOs);

		} catch (Exception e) {
			LOGGER.error("Error while rendering establishment list", e);
		}

		super.render(renderRequest, renderResponse);
	}

}
