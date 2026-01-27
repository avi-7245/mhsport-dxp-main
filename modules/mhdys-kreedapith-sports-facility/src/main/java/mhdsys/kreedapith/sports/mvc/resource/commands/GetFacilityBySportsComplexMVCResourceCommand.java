package mhdsys.kreedapith.sports.mvc.resource.commands;

import com.liferay.petra.string.StringPool;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.common.util.FileUploadUtil;
import com.mhdsys.schema.model.SportsFacilityMaster;
import com.mhdsys.schema.service.SportsFacilityMasterLocalServiceUtil;

import java.io.IOException;
import java.util.List;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys;

@Component(
		immediate=true,
	    property = { 
	    		"javax.portlet.name=" + MhdysKreedapithSportsFacilityPortletKeys.MHDYSKREEDAPITHSPORTSFACILITY,
	    		"mvc.command.name="+MhdysKreedapithSportsFacilityPortletKeys.GET_FACILITY_BY_SPORTS_COMPLEX
	    }, 
	    service = MVCResourceCommand.class
)
public class GetFacilityBySportsComplexMVCResourceCommand  implements MVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(GetFacilityBySportsComplexMVCResourceCommand.class);
	
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
		
			_log.info("Entry into GetFacilityBySportsComplexMVCResourceCommand ::  serveResource ::");
			
			ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
			
			
			JSONArray facilityArray =JSONFactoryUtil.createJSONArray();
			
			String complexName =ParamUtil.getString(resourceRequest,"facilityComplexName");
			String facilitytypeSelected =ParamUtil.getString(resourceRequest,"facilitytypeSelected");
			// TO DO code for type(level of facility)
			
			
			_log.info("facilitytypeSelected :::"+facilitytypeSelected);
			_log.info("complexName :::"+complexName);
			
		//	JSONObject facilityJson = JSONFactoryUtil.createJSONObject();
			List<SportsFacilityMaster> sportsFacilities=null;
			if(Validator.isNotNull(complexName)) {
				try {
					sportsFacilities= SportsFacilityMasterLocalServiceUtil.getByfacilityType(facilitytypeSelected);
					//sportsFacilities= SportsFacilityMasterLocalServiceUtil.getByFacilityLocation(complexName);
				} catch (Exception e) {
					_log.error("Error in code :::"+e);
				}
 				if(Validator.isNotNull(sportsFacilities) && sportsFacilities.size()>0) {
 					sportsFacilities=sportsFacilities.stream().filter(facility->facility.getFacilityName().equalsIgnoreCase(complexName)).toList();
 					for(SportsFacilityMaster sportsFacility:sportsFacilities) {
 						JSONObject facilityJson=JSONFactoryUtil.createJSONObject();
 						facilityJson.put("id", sportsFacility.getSportsFacilityId());
 						JSONArray imageArray = JSONFactoryUtil.createJSONArray();
 						
 						imageArray=getImageURLArray(themeDisplay, sportsFacility, imageArray);
 						
 						facilityJson.put("imageUrl",imageArray);
 						facilityJson.put("name", sportsFacility.getMainTypeOfFacility());
 						facilityJson.put("court", sportsFacility.getSportsCourt());
 						facilityJson.put("courtNameNumber", sportsFacility.getCourtNameNumber());
 						
 						facilityJson.put("assosicationHourlyFees", sportsFacility.getAssoc_fed_perHour());
 						facilityJson.put("assosicationDailyFees", sportsFacility.getAssoc_fed_perDay());
 						facilityJson.put("assosicationMonthlyFees", sportsFacility.getAssoc_fed_perMonth());
 						
 						facilityJson.put("otherSportsHourlyFees", sportsFacility.getRent_other_sports_perHour());
 						facilityJson.put("otherSportsDailyFees", sportsFacility.getRent_other_sports_perDay());
 						facilityJson.put("otherSportsMonthlyFees", sportsFacility.getRent_other_sports_perMonth());
 						
 						facilityJson.put("nonSportsHourlyFees", sportsFacility.getRent_nonsports_perHour());
 						facilityJson.put("nonSportsDailyFees", sportsFacility.getRent_nonsports_perDay());
 						facilityJson.put("nonSportsMonthlyFees", sportsFacility.getRent_nonsports_perMonth());
 						
 						facilityJson.put("indevidualHourlyFees", sportsFacility.getIndividual_perHour());
 						facilityJson.put("indevidualDailyFees", sportsFacility.getIndividual_perDay());
 						facilityJson.put("indevidualMonthlyFees", sportsFacility.getIndividual_perMonth());
 						
 						facilityJson.put("acFees", sportsFacility.getAc_perHour());
 						facilityJson.put("arenaLightFees", sportsFacility.getArena_lights_perHour());
 						
 						facilityArray.put(facilityJson);
 					}
 				}
 			}
			_log.info("facilityArray :::" +facilityArray);
			try {
				resourceResponse.getWriter().print(facilityArray.toJSONString());
			} catch (IOException e) {
				_log.error("Error in code :::" +e);
			}
		return false;
	}

	/**
	 * @param themeDisplay
	 * @param sportsFacility
	 * @param imageArray
	 */
	private JSONArray getImageURLArray(ThemeDisplay themeDisplay, SportsFacilityMaster sportsFacility,
			JSONArray imageArray) {
		if(Validator.isNotNull(sportsFacility.getGeotagPhotos()) && sportsFacility.getGeotagPhotos().length()>0) {
			JSONArray arr=null;
			try {
				 arr=JSONFactoryUtil.createJSONArray(sportsFacility.getGeotagPhotos());
			} catch (Exception e) {
				_log.error("Error in code ::" +e);
			}
			if(Validator.isNotNull(arr) && arr.length()>0) {
				for(int i=0;i<arr.length();i++) {
					JSONObject jsonObject = null;
					try {
						jsonObject=arr.getJSONObject(i);
					}catch(Exception e) {
						_log.error("Error in code ::" +e);
					}
					if(Validator.isNotNull(jsonObject)) {
						
						long fileEntryId=jsonObject.getLong("fileEntryId");
						String previewURL=StringPool.BLANK;
								
						try {
							previewURL=fileUploadUtil.getPreviewURL(fileEntryId, themeDisplay);
						} catch (Exception e) {
							_log.error("Error in code :::" +e);
						}
						JSONObject imageJson = JSONFactoryUtil.createJSONObject();
						imageJson.put("previewURL", previewURL);
						imageJson.put("name", jsonObject.getString("fileName"));
						imageArray.put(imageJson);
					}
				}
			}
		}
		return imageArray;
	}
	
	@Reference
	FileUploadUtil fileUploadUtil;
	
}

