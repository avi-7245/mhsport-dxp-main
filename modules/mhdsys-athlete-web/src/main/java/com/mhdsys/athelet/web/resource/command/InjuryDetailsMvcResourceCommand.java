package com.mhdsys.athelet.web.resource.command;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athelet.web.com.constants.MhdsysAthleteWebPortletKeys;
import com.mhdsys.athelet.web.com.portlet.MhdsysAthleteWebPortlet;
import com.mhdsys.athelet.web.util.AtheletUtil;
import com.mhdsys.schema.model.MedicalRecord;
import com.mhdsys.schema.service.MedicalRecordLocalServiceUtil;
import com.mhdsys.schema.service.SchoolCollegeOfficerRegistrationLocalServiceUtil;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

@Component(
	    immediate = true,
	    property = {
	    		"javax.portlet.name=" + MhdsysAthleteWebPortletKeys.INJURYDETAILS,
	    		"javax.portlet.name=" + MhdsysAthleteWebPortletKeys.EXCHANGEDETAILS,
	    		"javax.portlet.name=" + MhdsysAthleteWebPortletKeys.HISTORYDETAILS,
	    		"javax.portlet.name=" + MhdsysAthleteWebPortletKeys.MSSCREENINGDETAILS,
	    		"mvc.command.name=injuryDetailsResourceCommand"
	    },
	    service = MVCResourceCommand.class
	)

public class InjuryDetailsMvcResourceCommand implements MVCResourceCommand{
	private Log LOGGER = LogFactoryUtil.getLog(InjuryDetailsMvcResourceCommand.class);
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
	        throws PortletException {

	    JSONObject jsonResponse = JSONFactoryUtil.createJSONObject();
	    String formName = ParamUtil.getString(resourceRequest, "formName");
	    LOGGER.info("Form submitted: " + formName);

	    try {
	        ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
	        long userId = themeDisplay.getUserId();

	        // Fetch existing record by userId
	        MedicalRecord medicalRecord = MedicalRecordLocalServiceUtil.fetchByUserId(userId);
	        boolean isNewRecord = false;

	        if (medicalRecord == null) {
	            long medicalRecordId = CounterLocalServiceUtil.increment(MedicalRecord.class.getName());
	            medicalRecord = MedicalRecordLocalServiceUtil.createMedicalRecord(medicalRecordId);
	            medicalRecord.setUserId(userId);
	            medicalRecord.setUserName(themeDisplay.getUser().getFullName());
	            medicalRecord.setCreateDate(new Date());
	            isNewRecord = true;
	        }

	        // Update only the fields for the submitted form
	        switch (formName) {
	            case "historyDetails":
	                medicalRecord.setRecentInjuries(ParamUtil.getString(resourceRequest, "recentInjuries"));
	                medicalRecord.setComorbidities(ParamUtil.getString(resourceRequest, "comorbidities"));
	                medicalRecord.setSurgeries(ParamUtil.getString(resourceRequest, "surgeries"));
	                medicalRecord.setMedications(ParamUtil.getString(resourceRequest, "medications"));
	                medicalRecord.setFamilyHistory(ParamUtil.getString(resourceRequest, "familyHistory"));
	                break;

	            case "exchangeDetails":
	                medicalRecord.setExchangeRecentInjuries(ParamUtil.getString(resourceRequest, "exchangeRecentInjuries"));
	                medicalRecord.setExchangeComorbidities(ParamUtil.getString(resourceRequest, "exchangeComorbidities"));
	                medicalRecord.setExchangeSurgeries(ParamUtil.getString(resourceRequest, "exchangeSurgeries"));
	                medicalRecord.setExchangeMedications(ParamUtil.getString(resourceRequest, "exchangeMedications"));
	                medicalRecord.setExchangeFamilyHistory(ParamUtil.getString(resourceRequest, "exchangeFamilyHistory"));
	                break;

	            case "addInjury":
	                medicalRecord.setEvent(ParamUtil.getString(resourceRequest, "event"));
	                medicalRecord.setTrainingAge(ParamUtil.getString(resourceRequest, "trainingAge"));
	                medicalRecord.setInjury(ParamUtil.getString(resourceRequest, "injury"));
	                medicalRecord.setHistoryOfCurrentInjury(ParamUtil.getString(resourceRequest, "historyOfCurrentInjury"));
	                medicalRecord.setMechanismOfInjury(ParamUtil.getString(resourceRequest, "mechanismOfInjury"));
	                medicalRecord.setAreaOfInjury(ParamUtil.getString(resourceRequest, "areaOfInjury"));
	                medicalRecord.setAffectedPart(ParamUtil.getString(resourceRequest, "affectedPart"));
	                medicalRecord.setOnObservation(ParamUtil.getString(resourceRequest, "onObservation"));
	                medicalRecord.setOdema(ParamUtil.getString(resourceRequest, "odema"));
	                medicalRecord.setPittingType(ParamUtil.getString(resourceRequest, "pittingType"));
	                medicalRecord.setRedness(ParamUtil.getString(resourceRequest, "redness"));
	                medicalRecord.setOnPalpation(ParamUtil.getString(resourceRequest, "onPalpation"));
	                medicalRecord.setTenderness(ParamUtil.getString(resourceRequest, "tenderness"));
	                medicalRecord.setStiffness(ParamUtil.getString(resourceRequest, "stiffness"));
	                medicalRecord.setPain(ParamUtil.getString(resourceRequest, "pain"));
	                medicalRecord.setVasScale(ParamUtil.getString(resourceRequest, "vasScale"));
	                medicalRecord.setSpecialTest(ParamUtil.getString(resourceRequest, "specialTest"));
	                medicalRecord.setTreatment(ParamUtil.getString(resourceRequest, "treatment"));
	                medicalRecord.setExerciseVideo(ParamUtil.getString(resourceRequest, "exerciseVideo"));
	                medicalRecord.setMachineWork(ParamUtil.getString(resourceRequest, "machineWork"));
	                break;

	            case "msDetails":
	                medicalRecord.setKiblerLateralSlideRight(ParamUtil.getString(resourceRequest, "kiblerLateralSlideRight"));
	                medicalRecord.setKiblerLateralSlideLeft(ParamUtil.getString(resourceRequest, "kiblerLateralSlideLeft"));
	                medicalRecord.setRectusFemorisLengthRight(ParamUtil.getString(resourceRequest, "rectusFemorisLengthRight"));
	                medicalRecord.setRectusFemorisLengthLeft(ParamUtil.getString(resourceRequest, "rectusFemorisLengthLeft"));
	                medicalRecord.setHipFlexionRomRight(ParamUtil.getString(resourceRequest, "hipFlexionRomRight"));
	                medicalRecord.setHipFlexionRomLeft(ParamUtil.getString(resourceRequest, "hipFlexionRomLeft"));
	                break;

	            default:
	                LOGGER.warn("Unknown form submitted: " + formName);
	        }

	        medicalRecord.setModifiedDate(new Date());

	        // Persist
	        if (isNewRecord) {
	            MedicalRecordLocalServiceUtil.addMedicalRecord(medicalRecord);
	        } else {
	            MedicalRecordLocalServiceUtil.updateMedicalRecord(medicalRecord);
	        }

	        jsonResponse.put("status", "success");

	    } catch (Exception e) {
	        LOGGER.error("Error updating MedicalRecord", e);
	        jsonResponse.put("status", "error");
	        jsonResponse.put("message", e.getMessage());
	    }

	    try {
	        resourceResponse.getWriter().write(jsonResponse.toString());
	    } catch (Exception e) {
	        LOGGER.error(e);
	    }

	    return true;
	}

}
