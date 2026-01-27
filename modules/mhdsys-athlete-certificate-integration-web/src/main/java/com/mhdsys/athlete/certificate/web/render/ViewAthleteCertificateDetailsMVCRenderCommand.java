package com.mhdsys.athlete.certificate.web.render;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athlete.certificate.web.constants.MhdsysAthleteCertificateIntegrationWebPortletKeys;
import com.mhdsys.athlete.certificate.web.util.AthleteDetailsUtil;
import com.mhdsys.schema.model.AthleteSportsCertificate;
import com.mhdsys.schema.service.AthleteSportsCertificateLocalServiceUtil;
import com.mhdsys.schema.service.CompetitionLevelMasterLocalServiceUtil;
import com.mhdsys.schema.service.DistrictMasterLocalServiceUtil;
import com.mhdsys.schema.service.SportsMasterLocalServiceUtil;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = {
		"javax.portlet.name="
				+ MhdsysAthleteCertificateIntegrationWebPortletKeys.MHDSYSATHLETECERTIFICATEINTEGRATIONWEB,
		"javax.portlet.name=" + MhdsysAthleteCertificateIntegrationWebPortletKeys.MHDSYSATHLETECERTIFICATEDETAILSWEB,
		"mvc.command.name="
				+ MhdsysAthleteCertificateIntegrationWebPortletKeys.VIEWATHLETEDETAILSMVCRENDERCOMMAND }, service = MVCRenderCommand.class)

public class ViewAthleteCertificateDetailsMVCRenderCommand implements MVCRenderCommand {

	private Log LOGGER = LogFactoryUtil.getLog(ViewAthleteCertificateDetailsMVCRenderCommand.class);
	@Reference
	AthleteDetailsUtil util;

	@Override
	public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {
		try {
			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			User user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());

			long athleteCertificateId = ParamUtil.getLong(renderRequest, "athleteCertificateId");
			String mode = ParamUtil.getString(renderRequest, "mode");

			AthleteSportsCertificate athleteSportsCertificate = AthleteSportsCertificateLocalServiceUtil
					.getAthleteSportsCertificate(athleteCertificateId);

			renderRequest.setAttribute("districts", DistrictMasterLocalServiceUtil.getDistrictMasters(-1, -1));

			renderRequest.setAttribute("sports", SportsMasterLocalServiceUtil.getSportsMasters(-1, -1));

			renderRequest.setAttribute("compLevels",
					CompetitionLevelMasterLocalServiceUtil.getCompetitionLevelMasters(-1, -1));

			renderRequest.setAttribute("sportsDTO",
					util.getSportsCertificateDTO(athleteSportsCertificate, themeDisplay));
			renderRequest.setAttribute("mode", mode);

		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return MhdsysAthleteCertificateIntegrationWebPortletKeys.ATHLETE_CERTIFICATE_DETAILS_JSP;
	}

}
