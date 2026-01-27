package com.mhdsys.athlete.certificate.web.resource;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athlete.certificate.web.constants.MhdsysAthleteCertificateIntegrationWebPortletKeys;
import com.mhdsys.athlete.certificate.web.util.AthleteDetailsUtil;
import com.mhdsys.athlete.certificate.web.util.AthleteExternalApiUtil;
import com.mhdsys.common.api.athlete.details.certificate.AthleteDetailsCommonApi;
import com.mhdsys.common.pojo.AthleteSportsCertificateDTO;
import com.mhdsys.schema.model.AthleteSportsCertificate;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = {
		"javax.portlet.name=" + MhdsysAthleteCertificateIntegrationWebPortletKeys.MHDSYSATHLETECERTIFICATEDETAILSWEB,
		"javax.portlet.name="
				+ MhdsysAthleteCertificateIntegrationWebPortletKeys.MHDSYSATHLETECERTIFICATEINTEGRATIONWEB,
		"mvc.command.name="
				+ MhdsysAthleteCertificateIntegrationWebPortletKeys.SAVEATHLETEDETAILSMVCRESOURECCOMMAND }, service = MVCResourceCommand.class)

public class SaveAthleteCertificateDetailsMVCResourceCommand implements MVCResourceCommand {

	private static final Log LOGGER = LogFactoryUtil.getLog(SaveAthleteCertificateDetailsMVCResourceCommand.class);

	@Reference
	private AthleteDetailsCommonApi athleteDetailsCommonApi;

	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) {

		try {
			ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);

			JSONObject json = JSONFactoryUtil.createJSONObject();
			UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(resourceRequest);

			LOGGER.info("SAVE FUNCTION :::::   ");

			// OTP

//			String otpXml = AadharRequestUtil.generateOtpXml("662121151583");
//			LOGGER.info("SEND OTP XML    ::::   " + otpXml);

//			String verifyOtpAndFetchKyc = AadharOtpVerificationUtil.buildVerifyOtpXml("662121151583", "218303",
//					"AUA-ASA-2026-01-23T10:24:10");
//			LOGGER.info("VERIFY OTP XML :::::   " + verifyOtpAndFetchKyc);

			// OTP

			// OTR

//			JSONObject validationResponse = OTRVerificationUtil.validateOtrWithAadhaar("87632478634788",
//					"662121151583");
//			LOGGER.info(validationResponse);

			// OTR

			// SARAL

//			String studentByPenId = SaralApiUtil.getStudentByPenId("20000227454");
//
//			LOGGER.info("Student Data By PEN ID :::  " + studentByPenId);
//
//			String studentsBySchoolCode = SaralApiUtil.getStudentsBySchoolCode("27150705804");
//
//			LOGGER.info("Student Data By School ID   :::  " + studentsBySchoolCode);

			// SARAL

			AthleteSportsCertificateDTO dto = AthleteDetailsUtil.setSportsCertificateDTO(resourceRequest, themeDisplay);

			AthleteSportsCertificate saved = athleteDetailsCommonApi.saveAthleteDetails(dto);

			LOGGER.info("Data Saved");
			if (Validator.isNotNull(saved)) {
				json.put("success", true);
				LOGGER.info("Calling Api ::: ");
				boolean apiResponse = AthleteExternalApiUtil.submitCertificate(dto);

				LOGGER.info("API Response :::::   " + apiResponse);
			} else {
				json.put("success", false);
			}

			resourceResponse.getWriter().write(json.toString());

		} catch (Exception e) {
			LOGGER.error(e, e);
		}
		return false;
	}

}
