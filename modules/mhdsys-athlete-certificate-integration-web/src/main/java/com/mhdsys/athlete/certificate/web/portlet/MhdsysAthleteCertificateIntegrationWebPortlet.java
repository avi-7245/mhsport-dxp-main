package com.mhdsys.athlete.certificate.web.portlet;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athlete.certificate.web.constants.MhdsysAthleteCertificateIntegrationWebPortletKeys;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.service.AthleteSportsCertificateLocalServiceUtil;

import java.io.IOException;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author Epiphany
 */
@Component(property = { "com.liferay.portlet.display-category=MHDSYS.Athlete",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=MhdsysAthleteCertificateIntegrationWeb", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/athlete-details-list.jsp",
		"javax.portlet.name="
				+ MhdsysAthleteCertificateIntegrationWebPortletKeys.MHDSYSATHLETECERTIFICATEINTEGRATIONWEB,
		"javax.portlet.resource-bundle=content.Language", "com.liferay.portlet.requires-namespaced-parameters=false",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)
public class MhdsysAthleteCertificateIntegrationWebPortlet extends MVCPortlet {

	private Log LOGGER = LogFactoryUtil.getLog(MhdsysAthleteCertificateIntegrationWebPortlet.class);

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		try {
			LOGGER.info("Athlete Details Portlet");
			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);

			User user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());

			boolean sportsPerson = RoleConstant.isSportsPerson(user, themeDisplay.getCompanyId());

			if (sportsPerson) {
				renderRequest.setAttribute("athleteSportsCertificates",
						AthleteSportsCertificateLocalServiceUtil.getAthleteSportsCertificateByUserId(user.getUserId()));

			} else {
				renderRequest.setAttribute("athleteSportsCertificates",
						AthleteSportsCertificateLocalServiceUtil.getAthleteSportsCertificates(-1, -1));

			}

			renderRequest.setAttribute("isSportsPerson", sportsPerson);

			super.render(renderRequest, renderResponse);

		} catch (Exception e) {
			LOGGER.error(e);
		}
	}

}