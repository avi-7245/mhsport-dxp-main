package mhdsys.kreedapith.sports.mvc.resource.commands;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.mhdsys.schema.model.DistrictMaster;
import com.mhdsys.schema.model.SportsFacilityMaster;
import com.mhdsys.schema.model.TalukaMaster;
import com.mhdsys.schema.service.DistrictMasterLocalServiceUtil;
import com.mhdsys.schema.service.SportsFacilityMasterLocalServiceUtil;
import com.mhdsys.schema.service.TalukaMasterLocalServiceUtil;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

import mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys;

@Component(
		immediate=true,
	    property = { 
	    		"javax.portlet.name=" + MhdysKreedapithSportsFacilityPortletKeys.MHDYSKREEDAPITHSPORTSFACILITY,
	    		"mvc.command.name="+MhdysKreedapithSportsFacilityPortletKeys.GET_SPORTS_COMPLEX_BY_DISTRICT
	    }, 
	    service = MVCResourceCommand.class
)
public class GetSportsComplexByDistrictMVCResourceCommand  implements MVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(GetSportsComplexByDistrictMVCResourceCommand.class);
	
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
		
			_log.info("Entry into GetSportsComplexByDistrictMVCResourceCommand ::  serveResource ::");
			
			long districtId = ParamUtil.getLong(resourceRequest, "districtId");
			String facilityLevel = ParamUtil.getString(resourceRequest, "facilityLevel");
			String fetch = ParamUtil.getString(resourceRequest, "fetch");
			JSONArray jsonArray =JSONFactoryUtil.createJSONArray();
			
			_log.info("districtId ::::::::::::" +districtId);
			_log.info("facilityLevel ::::::::::::" +facilityLevel);
			_log.info("fetch ::::::::::::" +fetch);
			if(facilityLevel.equalsIgnoreCase("district")) {
				_log.info("inside district::::::::::::" );
				List<SportsFacilityMaster> facilities = null;
				try {
					facilities=SportsFacilityMasterLocalServiceUtil.getByFacilityTypeAndDistrict(facilityLevel,districtId);
				} catch (Exception e) {
					_log.error("Error in code :::" +e);
				}
				
				_log.info("facilities size :::" +facilities.size());
				_log.info("facilities :::" +facilities);
				
				if(Validator.isNotNull(facilities) && facilities.size()>0) {
					Set<String> facilitySet=new HashSet<>();
					for(SportsFacilityMaster facility:facilities) {
						facilitySet.add(facility.getFacilityName());
					}
					
					for(String str:facilitySet) {
						JSONObject obj=JSONFactoryUtil.createJSONObject();
						obj.put("name",str);
						jsonArray.put(obj);
					}
				}
			}else if(facilityLevel.equalsIgnoreCase("taluka")) {
				//get the taluka by district id
				List<TalukaMaster> talukaList = null;
				try {
					talukaList=TalukaMasterLocalServiceUtil.getTalukaByDistrictId(districtId);
				} catch (Exception e) {
					_log.error("Error in code :::" +e);
				}
				if(Validator.isNotNull(talukaList) && talukaList.size()>0) {
					for(TalukaMaster taluka :talukaList) {
						JSONObject obj=JSONFactoryUtil.createJSONObject();
						obj.put("id", taluka.getTalukaId());
						obj.put("name", taluka.getTalukaName_en());
						jsonArray.put(obj);
					}
				}
			}
			_log.info("jsonArray  :::" +jsonArray);
			
			try {
				resourceResponse.getWriter().print(jsonArray.toJSONString());
			} catch (Exception e) {
				_log.error("Error in code :::" +e);
			}
		return false;
	}
	
}

