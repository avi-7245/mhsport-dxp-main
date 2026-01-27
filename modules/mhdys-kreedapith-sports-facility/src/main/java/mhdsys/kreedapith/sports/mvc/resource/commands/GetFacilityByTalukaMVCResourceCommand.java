package mhdsys.kreedapith.sports.mvc.resource.commands;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.mhdsys.schema.model.SportsFacilityMaster;
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
	    		"mvc.command.name="+MhdysKreedapithSportsFacilityPortletKeys.GET_COMPLEX_BY_TALUKA_URL
	    }, 
	    service = MVCResourceCommand.class
)
public class GetFacilityByTalukaMVCResourceCommand  implements MVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(GetFacilityByTalukaMVCResourceCommand.class);
	
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
		
			_log.info("Entry into GetFacilityByTalukaMVCResourceCommand ::  serveResource ::");
			
			JSONArray jsonArray =JSONFactoryUtil.createJSONArray();
			
			long talukaId =ParamUtil.getLong(resourceRequest,"talukaId");
			String facilityLevel = ParamUtil.getString(resourceRequest, "facilityLevel");
			String fetch = ParamUtil.getString(resourceRequest, "fetch");
			_log.info("talukaId :::" +talukaId);
			
			List<SportsFacilityMaster> facilities = SportsFacilityMasterLocalServiceUtil.getByByFacilityTypeAndTaluka("Taluka", talukaId);
			
			//List<TalukaMaster> talukaList = TalukaMasterLocalServiceUtil.getTalukaByDistrictId(districtId);
			_log.info("facilities :::" +facilities);
			
			if(Validator.isNotNull(facilities) && facilities.size()>0) {
				Set<String> facilitySet=new HashSet<>();
				
				for(SportsFacilityMaster facility:facilities) {
					facilitySet.add(facility.getFacilityName());
				}
				
				for(String facility:facilitySet) {
					JSONObject obj=JSONFactoryUtil.createJSONObject();
					obj.put("name",facility);
					//obj.put("id",facility.getSportsFacilityId());
					jsonArray.put(obj);
				}
			}
			_log.info("jsonArray :::" +jsonArray);
			try {
				resourceResponse.getWriter().print(jsonArray.toJSONString());
			} catch (IOException e) {
				_log.error("Error in code :::" +e);
			}
		return false;
	}
}