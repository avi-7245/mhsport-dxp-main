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
import com.mhdsys.schema.service.DistrictMasterLocalServiceUtil;
import com.mhdsys.schema.service.SportsFacilityMasterLocalServiceUtil;

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
	    		"mvc.command.name="+MhdysKreedapithSportsFacilityPortletKeys.GET_DISTRICT_BY_DIVISION
	    }, 
	    service = MVCResourceCommand.class
)
public class GetDistrictByDivisionMVCResourceCommand  implements MVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(GetDistrictByDivisionMVCResourceCommand.class);
	
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
			_log.info("Entry into GetDistrictByDivisionMVCResourceCommand ::  serveResource ::");
			JSONArray jsonArray =JSONFactoryUtil.createJSONArray();
			List<DistrictMaster> districts =null;
			
			String facilityLevel = ParamUtil.getString(resourceRequest, "facilityLevel");
			String fetch = ParamUtil.getString(resourceRequest, "fetch");
			long divisionId =ParamUtil.getLong(resourceRequest,"divisionId");
			_log.info("facilityLevel :::::::"+facilityLevel);
			_log.info("fetch :::::::"+fetch);
			_log.info("divisionId :::::::"+divisionId);
			if(facilityLevel.equalsIgnoreCase("Division")) {
				
				//Get the facility complex at division level
				List<SportsFacilityMaster> facilities=null;
				try {
					facilities=SportsFacilityMasterLocalServiceUtil.getByFacilityTypeAndDivision(facilityLevel, divisionId);
				} catch (Exception e) {
					_log.error("Error in code ::" +e);
				}
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
			}else {
				//Get the district by division id
				if (Validator.isNotNull(divisionId) && divisionId > 0) {
					districts = DistrictMasterLocalServiceUtil.getDistrictByDivisionId(divisionId);
				}
				_log.info("districts :::" + districts);
				if (Validator.isNotNull(districts)) {
					for (DistrictMaster district : districts) {
						JSONObject districtJson = JSONFactoryUtil.createJSONObject();
						districtJson.put("name", district.getDistrictName_en());
						districtJson.put("id", district.getDistrictId());
						jsonArray.put(districtJson);
					}
				}
				_log.info("jsonArray :::" + jsonArray);
			}
			
			_log.info("divisionId :::"+divisionId);
			_log.info("jsonArray :::"+jsonArray);
			
			try {
				resourceResponse.getWriter().print(jsonArray.toJSONString());
			} catch (IOException e) {
				_log.error("Error in code :::" +e);
			}
		return false;
	}
	
}

